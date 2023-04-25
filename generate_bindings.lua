package.path = "./love-api/?.lua" .. package.path

local api = require("extra")(require("love_api"))

local TYPE_UNKNOWN = 0
local TYPE_NUMBER  = 1
local TYPE_INTEGER = 2
local TYPE_BOOL    = 3
local TYPE_STRING  = 4
local TYPE_TABLE   = 5
local TYPE_ENUM    = 6
local TYPE_OBJECT  = 7
local TYPE_POINTER = 8
local TYPE_FUNCTION = 9

local unbound_types = {}

local jai_types = {
  ["number"]         = { lua = "number",         jai = "lua.Number", builtin = true,  type = TYPE_NUMBER  },
  ["integer"]        = { lua = "integer",        jai = "u64",        builtin = true,  type = TYPE_INTEGER },
  ["boolean"]        = { lua = "boolean",        jai = "s32",        builtin = true,  type = TYPE_BOOL    },
  ["string"]         = { lua = "string",         jai = "*u8",        builtin = false, type = TYPE_STRING  },
  ["table"]          = { lua = "table",          jai = "lua.Table",  builtin = false, type = TYPE_TABLE   },
  ["light userdata"] = { lua = "lightuserdata",  jai = "*void",      builtin = false, type = TYPE_POINTER  },
  ["function"]       = { lua = "cfunction",      jai = "*void",      builtin = false, type = TYPE_FUNCTION },
}

jai_types["Variant"] = jai_types["string"]

local generated_procs = {}

function generate_value_conversion(t, index)
  if t.builtin then
    return ("lua.to%s(L, %d)"):format(t.lua, index)
  end
  
  if t.type == TYPE_ENUM then
    return ("lua.tolstring(L, %d, null)"):format(index)
  elseif t.type == TYPE_STRING then
    return ("lua.tolstring(L, %d, null)"):format(index)
  elseif t.type == TYPE_OBJECT or t.type == TYPE_TABLE then
    return "xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX)"
  elseif t.type == TYPE_FUNCTION then
    return ("xx lua.tocfunction(L, %d)"):format(index)
  elseif t.type == TYPE_POINTER then
    return ("xx lua.touserdata(L, %d)"):format(index)
  end

  return ('assert(false, "unimplemented type for value conversion: %s")'):format(t.lua)
end

function generate_push_instruction(t, name)
  if t.builtin then
    return ("lua.push%s(L, %s)"):format(t.lua, name)
  end
  
  if t.type == TYPE_ENUM or t.type == TYPE_STRING then 
    return ("lua.pushstring(L, %s)"):format(name)
  elseif t.type == TYPE_OBJECT then
    return ("lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx %s)"):format(name)
  elseif t.type == TYPE_TABLE then
    return "lua.createtable(L, 0, 0)"
  elseif t.type == TYPE_FUNCTION then
    return ("lua.pushcclosure(L, %s, 0)"):format(name)
  elseif t.type == TYPE_POINTER then
    return ("lua.pushlightuserdata(L, %s)"):format(name)
  end
  
  return ('assert(false, "unimplemented type for push instruction: %s")'):format(t.lua)
end

function get_jai_type(lua_type)
  if string.match(lua_type, "%s(or)%s") then
    local first_type = string.match(lua_type, "(%w+)%s")
    lua_type = first_type
  end

  local t = jai_types[lua_type]
  if t == nil then
    print(("Unregistered type: %s"):format(lua_type))

    unbound_types[#unbound_types + 1] = lua_type
    t = { lua = lua_type, jai = lua_type, builtin = false, type = TYPE_UNKNOWN }
    jai_types[lua_type] = t
  end
  
  return t
end

function fn_path_parts(path)
  local parts = {}  
  local start = 1
  for i=1, #path do
    local c = path:sub(i, i)
    if c == "." then
      parts[#parts + 1] = path:sub(start, i-1)
      start = i + 1
    elseif i >= #path then
      parts[#parts + 1] = path:sub(start, i)
    end
  end
  
  return parts
end


function string.trim(s)
   local a = s:match('^%s*()')
   local b = s:match('()%s*$', a)
   return s:sub(a,b-1)
end

function split_names(name_str)
  local parts = {}  
  local start = 1
  for i=1, #name_str do
    local c = name_str:sub(i, i)
    if c == "," then
      parts[#parts + 1] = name_str:sub(start, i-1):trim()
      start = i + 1
    elseif i >= #name_str then
      parts[#parts + 1] = name_str:sub(start, i):trim()
    end
  end
  
  return parts
end

function generate_table_access_instructions(path)
  local buf  = ""

  local path = fn_path_parts(path)
  for i, part in ipairs(path) do
    local index = "-1"
    if i == 1 then index = "lua.LUA_GLOBALSINDEX" end
    
    buf = buf .. ('\tlua.getfield(L, %s, "%s");\n'):format(index, part)
  end
  
  for i=#path, #path-1, -1 do
    buf = buf .. ("\tlua._remove(L, %d);\n"):format(-i)
  end

  return buf
end

function generate_fn_binding(func, mod)
  local buffer = ""
  local name = func.fullname:gsub("[.]", "_")
  
  for _, variant in ipairs(func.variants) do
    local arg_map = {}
    local ret_map = {}
    
    -- filter anything invalid
    for i, arg in ipairs(variant.arguments) do
      if arg.name == "..." then
        variant.arguments[i] = nil
      else
        variant.arguments[i].name = arg.name:lower()
      end
    end
    
    -- split any combined names
    local args = {}
    for i, old_arg in ipairs(variant.arguments) do
      if old_arg ~= nil then
        if string.match(old_arg.name, "[,]") then
          local names = split_names(old_arg.name)
          for _, name in ipairs(names) do
            local new_arg = {
              type = old_arg.type,
              name = name,
            }
          
            args[#args + 1] = new_arg
          end
        elseif string.match(old_arg.name, "[']") then
          old_arg.name = old_arg.name:gsub("[']", "")
        else 
          args[#args + 1] = old_arg
        end
      end
    end
    
    -- filter anything invalid
    for i, ret in ipairs(variant.returns) do
      if ret.type == nil or ret.type == "nil" or ret.name == "..." then
        variant.returns[i] = nil
      else
        variant.returns[i].name = ret.name:lower()
      end
    end

    -- split any combined names
    local rets = {}
    for i, old_ret in ipairs(variant.returns) do
      if old_ret ~= nil then
        if string.match(old_ret.name, "[,]") then
          local names = split_names(old_ret.name)
          for _, name in ipairs(names) do
            local new_ret = {
              type = old_ret.type,
              name = name,
            }
          
            rets[#rets + 1] = new_ret
          end
        else
          rets[#rets + 1] = old_ret
        end
      end
    end
    
    variant.arguments = args
    variant.returns   = rets

    buffer = buffer .. ("// %s\n"):format(func.minidescription)

    local stub = ("%s :: ("):format(name)
    
    for i, arg in ipairs(variant.arguments) do
      if arg ~= nil then
        local jai_type = get_jai_type(arg.type)

        arg_map[#arg_map + 1] = {
          ["name"] = arg.name,
          ["lua"]  = arg.type,
          ["jai"]  = jai_type,
        }

        stub = stub .. ("%s: %s"):format(arg.name, jai_type.jai)
        if i <= #variant.arguments - 1 then stub = stub .. ", " end
      end
    end
    
    stub = stub .. ")"
    
    if #variant.returns > 1 then
      for _, ret in ipairs(variant.returns) do
        if ret ~= nil then
          local jai_type = get_jai_type(ret.type)
          ret_map[#ret_map + 1] = {
            ["name"] = ret.name,
            ["lua"]  = ret.type,
            ["jai"]  = jai_type,
          }
        end
      end
      
      local agg = "struct { "
      for _, ret in ipairs(ret_map) do
        agg = agg .. ("_%s: %s; "):format(ret.name, ret.jai.jai)
      end
      
      stub = stub .. " -> " .. agg .. "}"
    elseif #variant.returns == 1 then
      local ret      = variant.returns[1]
      local jai_type = get_jai_type(ret.type)

      ret_map[#ret_map + 1] = {
        ["name"] = ret.name,
        ["lua"]  = ret.type,
        ["jai"]  = jai_type,
      }
      
      stub = stub .. (" -> (%s: %s)"):format(ret.name, jai_type.jai)
    end

    local unique_id = ""
    unique_id = unique_id .. name .. ":"
    for i, arg in ipairs(arg_map) do
      unique_id = unique_id .. arg.jai.jai
      if i <= #arg_map - 1 then unique_id = unique_id .. "|" end
    end

    unique_id = unique_id .. ":"

    for i, ret in ipairs(ret_map) do
      unique_id = unique_id .. ret.jai.jai
      if i <= #ret_map - 1 then unique_id = unique_id .. "|" end
    end

    if not generated_procs[unique_id] then
      generated_procs[unique_id] = unique_id

      buffer = buffer .. stub .. " #no_context #c_call {\n"
      buffer = buffer .. generate_table_access_instructions(func.fullname) .. "\n"

      for _, arg in ipairs(arg_map) do
        local jai_type = get_jai_type(arg.lua)
        buffer = buffer .. "\t" .. generate_push_instruction(jai_type, arg.name) .. ";\n"
      end

      buffer = buffer .. ("\tlua.call(L, %d, %d);\n"):format(#arg_map, #ret_map)

      local ret_buf = ""
      if #ret_map > 1 then
        ret_buf = "return .{ "

        for i, ret in ipairs(ret_map) do
          local id = (#ret_map - i) + 1
          local jt = get_jai_type(ret.lua)
          ret_buf  = ret_buf .. ("_%s = %s"):format(ret.name, generate_value_conversion(jt, -id))
          if i <= #ret_map - 1 then
            ret_buf = ret_buf .. ", "
          end
        end

        ret_buf = ret_buf .. " };"
      elseif #ret_map == 1 then
        local ret = ret_map[1]
        local jt  = get_jai_type(ret.lua)
        ret_buf = ("return %s;"):format(generate_value_conversion(jt, -1))
      end

      if #ret_buf > 0 then
        buffer = buffer .. "\n\t" .. ret_buf .. "\n"
      end

      buffer = buffer .. "}\n"
      end
    end
  return buffer
end

local enum_table = {
  ["DistanceModel"] = {
    ["none"]            = "None",
    ["inverse"]         = "Inverse",
    ["inverseclamped"]  = "InverseClamped",
    ["linear"]          = "Linear",
    ["linearclamped"]   = "LinearClamped",
    ["exponent"]        = "Exponent",
    ["exponentclamped"] = "ExponentClamped",
  },

  ["EffectType"] = {
    ["chorus"]        = "Chorus",
    ["compressor"]    = "Compressor",
    ["distortion"]    = "Distortion",
    ["echo"]          = "Echo",
    ["equalizer"]     = "Equalizer",
    ["flanger"]       = "Flanger",
    ["reverb"]        = "Reverb",
    ["ringmodulator"] = "RingModulator",
  },

  ["EffectWaveform"] = {
    ["sawtooth"] = "Sawtooth",
    ["sine"]     = "Sine",
    ["square"]   = "Square",
    ["triangle"] = "Triangle",
  },

  ["FilterType"] = {
    ["lowpass"]  = "Lowpass",
    ["highpass"] = "Highpass",
    ["bandpass"] = "Bandpass",
  },

  ["SourceType"] = {
    ["static"] = "Static",
    ["stream"] = "Stream",
    ["queue"]  = "Queue",
  },

  ["TimeUnit"] = {
    ["seconds"] = "Seconds",
    ["samples"] = "Samples",
  },

  ["CompressedDataFormat"] = {
    ["lz4"]     = "Lz4",
    ["zlib"]    = "Zlib",
    ["gzip"]    = "Gzip",
    ["deflate"] = "Deflate",
  },

  ["ContainerType"] = {
    ["data"]   = "Data",
    ["string"] = "String",
  },

  ["EncodeFormat"] = {
    ["base64"] = "Base64",
    ["hex"]    = "Hex",
  },

  ["HashFunction"] = {
    ["md5"]    = "Md5",
    ["sha1"]   = "Sha1",
    ["sha224"] = "Sha224",
    ["sha256"] = "Sha256",
    ["sha384"] = "Sha384",
    ["sha512"] = "Sha512",
  },

  ["Event"] = {
    ["focus"]            = "Focus",
    ["joystickpressed"]  = "JoystickPressed",
    ["joystickreleased"] = "JoystickReleased",
    ["keypressed"]       = "KeyPressed",
    ["keyreleased"]      = "KeyReleased",
    ["mousepressed"]     = "MousePressed",
    ["mousereleased"]    = "MouseReleased",
    ["quit"]             = "Quit",
    ["resize"]           = "Resize",
    ["visible"]          = "Visible",
    ["mousefocus"]       = "MouseFocus",
    ["threaderror"]      = "ThreadError",
    ["joystickadded"]    = "JoystickAdded",
    ["joystickremoved"]  = "JoystickRemoved",
    ["joystickaxis"]     = "JoystickAxis",
    ["joystickhat"]      = "JoystickHat",
    ["gamepadpressed"]   = "GamepadPressed",
    ["gamepadreleased"]  = "GamepadReleased",
    ["gamepadaxis"]      = "GamepadAxis",
    ["textinput"]        = "TextInput",
    ["mousemoved"]       = "MouseMoved",
    ["lowmemory"]        = "LowMemory",
    ["textedited"]       = "TextEdited",
    ["wheelmoved"]       = "WheelMoved",
    ["touchpressed"]     = "TouchPressed",
    ["touchreleased"]    = "TouchReleased",
    ["touchmoved"]       = "TouchMoved",
    ["directorydropped"] = "DirectoryDropped",
    ["filedropped"]      = "FileDropped",
    ["jp"]               = "Jp",
    ["jr"]               = "Jr",
    ["kp"]               = "Kp",
    ["kr"]               = "Kr",
    ["mp"]               = "Mp",
    ["mr"]               = "Mr",
    ["q"]                = "Q",
    ["f"]                = "F",
  },

  ["BufferMode"] = {
    ["none"] = "None",
    ["line"] = "Line",
    ["full"] = "Full",
  },

  ["FileDecoder"] = {
    ["file"]   = "File",
    ["base64"] = "Base64",
  },

  ["FileMode"] = {
    ["r"] = "R",
    ["w"] = "W",
    ["a"] = "A",
    ["c"] = "C",
  },

  ["FileType"] = {
    ["file"]      = "File",
    ["directory"] = "Directory",
    ["symlink"]   = "Symlink",
    ["other"]     = "Other",
  },

  ["HintingMode"] = {
    ["normal"] = "Normal",
    ["light"]  = "Light",
    ["mono"]   = "Mono",
    ["none"]   = "None",
  },

  ["AlignMode"] = {
    ["center"]  = "Center",
    ["left"]    = "Left",
    ["right"]   = "Right",
    ["justify"] = "Justify",
  },

  ["ArcType"] = {
    ["pie"]    = "Pie",
    ["open"]   = "Open",
    ["closed"] = "Closed",
  },

  ["AreaSpreadDistribution"] = {
    ["uniform"]         = "Uniform",
    ["normal"]          = "Normal",
    ["ellipse"]         = "Ellipse",
    ["borderellipse"]   = "BorderEllipse",
    ["borderrectangle"] = "BorderRectangle",
    ["none"]            = "None",
  },

  ["BlendAlphaMode"] = {
    ["alphamultiply"] = "AlphaMultiply",
    ["premultiplied"] = "Premultiplied",
  },

  ["BlendMode"] = {
    ["alpha"]          = "Alpha",
    ["replace"]        = "Replace",
    ["screen"]         = "Screen",
    ["add"]            = "Add",
    ["subtract"]       = "Subtract",
    ["multiply"]       = "Multiply",
    ["lighten"]        = "Lighten",
    ["darken"]         = "Darken",
    ["additive"]       = "Additive",
    ["subtractive"]    = "Subtractive",
    ["multiplicative"] = "Multiplicative",
    ["premultiplied"]  = "Premultiplied",
  },

  ["CompareMode"] = {
    ["equal"]    = "Equal",
    ["notequal"] = "NotEqual",
    ["less"]     = "Less",
    ["lequal"]   = "LEqual",
    ["gequal"]   = "GEqual",
    ["greater"]  = "Greater",
    ["never"]    = "Never",
    ["always"]   = "Always",
  },

  ["CullMode"] = {
    ["back"]  = "Back",
    ["front"] = "Front",
    ["none"]  = "None",
  },

  ["DrawMode"] = {
    ["fill"] = "Fill",
    ["line"] = "Line",
  },

  ["FilterMode"] = {
    ["linear"]  = "Linear",
    ["nearest"] = "Nearest",
  },

  ["GraphicsFeature"] = {
    ["clampzero"]          = "ClampZero",
    ["lighten"]            = "Lighten",
    ["multicanvasformats"] = "MultiCanvasFormats",
    ["glsl3"]              = "Glsl3",
    ["instancing"]         = "Instancing",
    ["fullnpot"]           = "FullNPOT",
    ["pixelshaderhighp"]   = "PixelShaderHighP",
    ["shaderderivatives"]  = "ShaderDerivatives",
  },

  ["GraphicsLimit"] = {
    ["pointsize"]         = "PointSize",
    ["texturesize"]       = "TextureSize",
    ["multicanvas"]       = "MultiCanvas",
    ["canvasmsaa"]        = "CanvasMSAA",
    ["texturelayers"]     = "TextureLayers",
    ["volumetexturesize"] = "VolumeTextureZize",
    ["cubetexturesize"]   = "CubeTextureZize",
    ["anisotropy"]        = "Anisotropy",
  },

  ["IndexDataType"] = {
    ["uint16"] = "Uint16",
    ["uint32"] = "Uint32",
  },

  ["LineJoin"] = {
    ["miter"] = "Miter",
    ["none"]  = "None",
    ["bevel"] = "Bevel",
  },

  ["LineStyle"] = {
    ["rough"]  = "Rough",
    ["smooth"] = "Smooth",
  },

  ["MeshDrawMode"] = {
    ["fan"]       = "Fan",
    ["strip"]     = "Strip",
    ["triangles"] = "Triangles",
    ["points"]    = "Points",
  },

  ["MipmapMode"] = {
    ["none"]   = "None",
    ["auto"]   = "Auto",
    ["manual"] = "Manual",
  },

  ["ParticleInsertMode"] = {
    ["top"]    = "Top",
    ["bottom"] = "Bottom",
    ["random"] = "Random",
  },

  ["SpriteBatchUsage"] = {
    ["dynamic"] = "Dynamic",
    ["static"]  = "Static",
    ["stream"]  = "Stream",
  },

  ["StackType"] = {
    ["transform"] = "Transform",
    ["all"]       = "All",
  },

  ["StencilAction"] = {
    ["replace"]       = "Replace",
    ["increment"]     = "Increment",
    ["decrement"]     = "Decrement",
    ["incrementwrap"] = "Incrementwrap",
    ["decrementwrap"] = "Decrementwrap",
    ["invert"]        = "Invert",
  },

  ["TextureType"] = {
    ["2d"]     = "_2D",
    ["array"]  = "Array",
    ["cube"]   = "Cube",
    ["volume"] = "Volume",
  },

  ["VertexAttributeStep"] = {
    ["pervertex"]   = "PerVertex",
    ["perinstance"] = "PerInstance",
  },

  ["VertexWinding"] = {
    ["cw"]  = "CW",
    ["ccw"] = "CCW",
  },

  ["WrapMode"] = {
    ["clamp"]          = "Clamp",
    ["repeat"]         = "Repeat",
    ["mirroredrepeat"] = "MirroredRepeat",
    ["clampzero"]      = "ClampZero",
  },

  ["CompressedImageFormat"] = {
    ["DXT1"]      = "DXT1",
    ["DXT3"]      = "DXT3",
    ["DXT5"]      = "DXT5",
    ["BC4"]       = "BC4",
    ["BC4s"]      = "BC4s",
    ["BC5"]       = "BC5",
    ["BC5s"]      = "BC5s",
    ["BC6h"]      = "BC6h",
    ["BC6hs"]     = "BC6hs",
    ["BC7"]       = "BC7",
    ["ETC1"]      = "ETC1",
    ["ETC2rgb"]   = "ETC2rgb",
    ["ETC2rgba"]  = "ETC2rgba",
    ["ETC2rgba1"] = "ETC2rgba1",
    ["EACr"]      = "EACr",
    ["EACrs"]     = "EACrs",
    ["EACrg"]     = "EACrg",
    ["EACrgs"]    = "EACrgs",
    ["PVR1rgb2"]  = "PVR1rgb2",
    ["PVR1rgb4"]  = "PVR1rgb4",
    ["PVR1rgba2"] = "PVR1rgba2",
    ["PVR1rgba4"] = "PVR1rgba4",
    ["ASTC4x4"]   = "ASTC4x4",
    ["ASTC5x4"]   = "ASTC5x4",
    ["ASTC5x5"]   = "ASTC5x5",
    ["ASTC6x5"]   = "ASTC6x5",
    ["ASTC6x6"]   = "ASTC6x6",
    ["ASTC8x5"]   = "ASTC8x5",
    ["ASTC8x6"]   = "ASTC8x6",
    ["ASTC8x8"]   = "ASTC8x8",
    ["ASTC10x5"]  = "ASTC10x5",
    ["ASTC10x6"]  = "ASTC10x6",
    ["ASTC10x8"]  = "ASTC10x8",
    ["ASTC10x10"] = "ASTC10x10",
    ["ASTC12x10"] = "ASTC12x10",
    ["ASTC12x12"] = "ASTC12x12",
  },

  ["ImageFormat"] = {
    ["tga"] = "TGA",
    ["png"] = "PNG",
    ["jpg"] = "JPG",
    ["bmp"] = "BMP",
  },

  ["PixelFormat"] = {
    ["unknown"]          = "Unknown",
    ["normal"]           = "Normal",
    ["hdr"]              = "HDR",
    ["r8"]               = "R8",
    ["rg8"]              = "RG8",
    ["rgba8"]            = "RGBA8",
    ["srgba8"]           = "SRGBA8",
    ["r16"]              = "R16",
    ["rg16"]             = "RG16",
    ["rgba16"]           = "RGBA16",
    ["r16f"]             = "R16f",
    ["rg16f"]            = "RG16f",
    ["rgba16f"]          = "RGBA16f",
    ["r32f"]             = "R32f",
    ["rg32f"]            = "RG32f",
    ["rgba32f"]          = "RGBA32f",
    ["la8"]              = "LA8",
    ["rgba4"]            = "RGBA4",
    ["rgb5a1"]           = "RGB5A1",
    ["rgb565"]           = "RGB565",
    ["rgb10a2"]          = "RGB10A2",
    ["rg11b10f"]         = "RG11B10f",
    ["stencil8"]         = "STENCIL8",
    ["depth16"]          = "DEPTH16",
    ["depth24"]          = "DEPTH24",
    ["depth32f"]         = "DEPTH32f",
    ["depth24stencil8"]  = "Depth24Stencil8",
    ["depth32fstencil8"] = "Depth32fStencil8",
    ["DXT1"]             = "DXT1",
    ["DXT3"]             = "DXT3",
    ["DXT5"]             = "DXT5",
    ["BC4"]              = "BC4",
    ["BC4s"]             = "BC4s",
    ["BC5"]              = "BC5",
    ["BC5s"]             = "BC5s",
    ["BC6h"]             = "BC6h",
    ["BC6hs"]            = "BC6hs",
    ["BC7"]              = "BC7",
    ["ETC1"]             = "ETC1",
    ["ETC2rgb"]          = "ETC2rgb",
    ["ETC2rgba"]         = "ETC2rgba",
    ["ETC2rgba1"]        = "ETC2rgba1",
    ["EACr"]             = "EACr",
    ["EACrs"]            = "EACrs",
    ["EACrg"]            = "EACrg",
    ["EACrgs"]           = "EACrgs",
    ["PVR1rgb2"]         = "PVR1rgb2",
    ["PVR1rgb4"]         = "PVR1rgb4",
    ["PVR1rgba2"]        = "PVR1rgba2",
    ["PVR1rgba4"]        = "PVR1rgba4",
    ["ASTC4x4"]          = "ASTC4x4",
    ["ASTC5x4"]          = "ASTC5x4",
    ["ASTC5x5"]          = "ASTC5x5",
    ["ASTC6x5"]          = "ASTC6x5",
    ["ASTC6x6"]          = "ASTC6x6",
    ["ASTC8x5"]          = "ASTC8x5",
    ["ASTC8x6"]          = "ASTC8x6",
    ["ASTC8x8"]          = "ASTC8x8",
    ["ASTC10x5"]         = "ASTC10x5",
    ["ASTC10x6"]         = "ASTC10x6",
    ["ASTC10x8"]         = "ASTC10x8",
    ["ASTC10x10"]        = "ASTC10x10",
    ["ASTC12x10"]        = "ASTC12x10",
    ["ASTC12x12"]        = "ASTC12x12",
  },

  ["GamepadAxis"] = {
    ["leftx"]        = "LeftX",
    ["lefty"]        = "LeftY",
    ["rightx"]       = "RightX",
    ["righty"]       = "RightY",
    ["triggerleft"]  = "TriggerLeft",
    ["triggerright"] = "TriggerRight",
  },

  ["GamepadButton"] = {
    ["a"]             = "A",
    ["b"]             = "B",
    ["x"]             = "X",
    ["y"]             = "Y",
    ["back"]          = "Back",
    ["guide"]         = "Guide",
    ["start"]         = "Start",
    ["leftstick"]     = "LeftStick",
    ["rightstick"]    = "RightStick",
    ["leftshoulder"]  = "LeftShoulder",
    ["rightshoulder"] = "RightShoulder",
    ["dpup"]          = "DpUp",
    ["dpdown"]        = "DpDown",
    ["dpleft"]        = "DpLeft",
    ["dpright"]       = "DpRight",
  },

  ["JoystickHat"] = {
    ["c"]  = "C",
    ["d"]  = "D",
    ["l"]  = "L",
    ["ld"] = "Ld",
    ["lu"] = "Lu",
    ["r"]  = "R",
    ["rd"] = "Rd",
    ["ru"] = "Ru",
    ["u"]  = "U",
  },

  ["JoystickInputType"] = {
    ["axis"]   = "Axis",
    ["button"] = "Button",
    ["hat"]    = "Hat",
  },

  ["KeyConstant"] = {
    ["a"]            = "A",
    ["b"]            = "B",
    ["c"]            = "C",
    ["d"]            = "D",
    ["e"]            = "E",
    ["f"]            = "F",
    ["g"]            = "G",
    ["h"]            = "H",
    ["i"]            = "I",
    ["j"]            = "J",
    ["k"]            = "K",
    ["l"]            = "L",
    ["m"]            = "M",
    ["n"]            = "N",
    ["o"]            = "O",
    ["p"]            = "P",
    ["q"]            = "Q",
    ["r"]            = "R",
    ["s"]            = "S",
    ["t"]            = "T",
    ["u"]            = "U",
    ["v"]            = "V",
    ["w"]            = "W",
    ["x"]            = "X",
    ["y"]            = "Y",
    ["z"]            = "Z",
    ["0"]           = "_0",
    ["1"]           = "_1",
    ["2"]           = "_2",
    ["3"]           = "_3",
    ["4"]           = "_4",
    ["5"]           = "_5",
    ["6"]           = "_6",
    ["7"]           = "_7",
    ["8"]           = "_8",
    ["9"]           = "_9",
    ["space"]        = "Space",
    ["!"]            = "Exclamation",
    ['"']            = "DoubleQuote",
    ["#"]            = "Hash",
    ["$"]            = "Dollar",
    ["&"]            = "Ampersand",
    ["'"]            = "SingleQuote",
    ["("]            = "LParen",
    [")"]            = "RParen",
    ["*"]            = "Star",
    ["+"]            = "Plus",
    [","]            = "Comma",
    ["-"]            = "Dash",
    ["."]            = "Period",
    ["/"]            = "FSlash",
    [":"]            = "Colon",
    [";"]            = "Semicolon",
    ["<"]            = "LessThan",
    ["="]            = "Equal",
    [">"]            = "GreaterThan",
    ["?"]            = "Question",
    ["@"]            = "At",
    ["["]            = "LBrace",
    ["\\"]           = "BSlash",
    ["]"]            = "RBrace",
    ["^"]            = "Caret",
    ["_"]            = "Underscore",
    ["`"]            = "Grave",
    ["kp0"]          = "Pad0",
    ["kp1"]          = "Pad1",
    ["kp2"]          = "Pad2",
    ["kp3"]          = "Pad3",
    ["kp4"]          = "Pad4",
    ["kp5"]          = "Pad5",
    ["kp6"]          = "Pad6",
    ["kp7"]          = "Pad7",
    ["kp8"]          = "Pad8",
    ["kp9"]          = "Pad9",
    ["kp."]          = "PadDot",
    ["kp/"]          = "PadFSlash",
    ["kp*"]          = "PadStar",
    ["kp-"]          = "PadDash",
    ["kp+"]          = "PadPlus",
    ["kpenter"]      = "PadEnter",
    ["kp="]          = "PadEqual",
    ["up"]           = "Up",
    ["down"]         = "Down",
    ["right"]        = "Right",
    ["left"]         = "Left",
    ["home"]         = "Home",
    ["end"]          = "End",
    ["pageup"]       = "PageUp",
    ["pagedown"]     = "PageDown",
    ["insert"]       = "Insert",
    ["backspace"]    = "Backspace",
    ["tab"]          = "Tab",
    ["clear"]        = "Clear",
    ["return"]       = "Return",
    ["delete"]       = "Delete",
    ["f1"]           = "F1",
    ["f2"]           = "F2",
    ["f3"]           = "F3",
    ["f4"]           = "F4",
    ["f5"]           = "F5",
    ["f6"]           = "F6",
    ["f7"]           = "F7",
    ["f8"]           = "F8",
    ["f9"]           = "F9",
    ["f10"]          = "F10",
    ["f11"]          = "F11",
    ["f12"]          = "F12",
    ["f13"]          = "F13",
    ["f14"]          = "F14",
    ["f15"]          = "F15",
    ["numlock"]      = "NumLock",
    ["capslock"]     = "CapsLock",
    ["rshift"]       = "RShift",
    ["lshift"]       = "LShift",
    ["rctrl"]        = "RCtrl",
    ["lctrl"]        = "LCtrl",
    ["ralt"]         = "RAlt",
    ["lalt"]         = "LAlt",
    ["mode"]         = "Mode",
    ["pause"]        = "Pause",
    ["escape"]       = "Escape",
    ["help"]         = "Help",
  },

  ["Scancode"] = {
    ["a"]                   = "A",
    ["b"]                   = "B",
    ["c"]                   = "C",
    ["d"]                   = "D",
    ["e"]                   = "E",
    ["f"]                   = "F",
    ["g"]                   = "G",
    ["h"]                   = "H",
    ["i"]                   = "I",
    ["j"]                   = "J",
    ["k"]                   = "K",
    ["l"]                   = "L",
    ["m"]                   = "M",
    ["n"]                   = "N",
    ["o"]                   = "O",
    ["p"]                   = "P",
    ["q"]                   = "Q",
    ["r"]                   = "R",
    ["s"]                   = "S",
    ["t"]                   = "T",
    ["u"]                   = "U",
    ["v"]                   = "V",
    ["w"]                   = "W",
    ["x"]                   = "X",
    ["y"]                   = "Y",
    ["z"]                   = "Z",
    ["1"]                   = "_1",
    ["2"]                   = "_2",
    ["3"]                   = "_3",
    ["4"]                   = "_4",
    ["5"]                   = "_5",
    ["6"]                   = "_6",
    ["7"]                   = "_7",
    ["8"]                   = "_8",
    ["9"]                   = "_9",
    ["0"]                   = "_0",
    ["return"]              = "Return",
    ["escape"]              = "Escape",
    ["backspace"]           = "Backspace",
    ["tab"]                 = "Tab",
    ["space"]               = "Space",
    ["-"]                   = "Dash",
    ["="]                   = "Equal",
    ["["]                   = "LBrace",
    ["]"]                   = "RBrace",
    ["\\"]                  = "BSlash",
    ["nonus#"]              = "NonUS",
    [";"]                   = "Semicolon",
    ["'"]                   = "SingleQuote",
    ["`"]                   = "Grave",
    [","]                   = "Comma",
    ["."]                   = "Period",
    ["/"]                   = "FSlash",
    ["capslock"]            = "CapsLock",
    ["f1"]                  = "F1",
    ["f2"]                  = "F2",
    ["f3"]                  = "F3",
    ["f4"]                  = "F4",
    ["f5"]                  = "F5",
    ["f6"]                  = "F6",
    ["f7"]                  = "F7",
    ["f8"]                  = "F8",
    ["f9"]                  = "F9",
    ["f10"]                 = "F10",
    ["f11"]                 = "F11",
    ["f12"]                 = "F12",
    ["f13"]                 = "F13",
    ["f14"]                 = "F14",
    ["f15"]                 = "F15",
    ["f16"]                 = "F16",
    ["f17"]                 = "F17",
    ["f18"]                 = "F18",
    ["f19"]                 = "F19",
    ["f20"]                 = "F20",
    ["f21"]                 = "F21",
    ["f22"]                 = "F22",
    ["f23"]                 = "F23",
    ["f24"]                 = "F24",
    ["lctrl"]               = "LCtrl",
    ["lshift"]              = "LShift",
    ["lalt"]                = "LAlt",
    ["lgui"]                = "LGui",
    ["rctrl"]               = "RCtrl",
    ["rshift"]              = "RShift",
    ["ralt"]                = "RAlt",
    ["rgui"]                = "RGui",
    ["printscreen"]         = "PrintScreen",
    ["pause"]               = "Pause",
    ["insert"]              = "Insert",
    ["home"]                = "Home",
    ["numlock"]             = "NumLock",
    ["pageup"]              = "PageUp",
    ["delete"]              = "Delete",
    ["end"]                 = "End",
    ["pagedown"]            = "PageDown",
    ["right"]               = "Right",
    ["left"]                = "Left",
    ["down"]                = "Down",
    ["up"]                  = "Up",
    ["nonusbackslash"]      = "NonUSBSlash",
    ["application"]         = "Application",
    ["execute"]             = "Execute",
    ["help"]                = "Help",
    ["menu"]                = "Menu",
    ["select"]              = "Select",
    ["stop"]                = "Stop",
    ["again"]               = "Again",
    ["undo"]                = "Undo",
    ["cut"]                 = "Cut",
    ["copy"]                = "Copy",
    ["paste"]               = "Paste",
    ["find"]                = "Find",
    ["kp/"]                 = "PadFSlash",
    ["kp*"]                 = "PadStar",
    ["kp-"]                 = "PadDash",
    ["kp+"]                 = "PadPlus",
    ["kp="]                 = "PadEqual",
    ["kpenter"]             = "PadEnter",
    ["kp1"]                 = "Pad1",
    ["kp2"]                 = "Pad2",
    ["kp3"]                 = "Pad3",
    ["kp4"]                 = "Pad4",
    ["kp5"]                 = "Pad5",
    ["kp6"]                 = "Pad6",
    ["kp7"]                 = "Pad7",
    ["kp8"]                 = "Pad8",
    ["kp9"]                 = "Pad9",
    ["kp0"]                 = "Pad0",
    ["kp."]                 = "PadPeriod",
    ["international1"]      = "International1",
    ["international2"]      = "International2",
    ["international3"]      = "International3",
    ["international4"]      = "International4",
    ["international5"]      = "International5",
    ["international6"]      = "International6",
    ["international7"]      = "International7",
    ["international8"]      = "International8",
    ["international9"]      = "International9",
    ["lang1"]               = "Lang1",
    ["lang2"]               = "Lang2",
    ["lang3"]               = "Lang3",
    ["lang4"]               = "Lang4",
    ["lang5"]               = "Lang5",
    ["mute"]                = "Mute",
    ["volumeup"]            = "VolumeUp",
    ["volumedown"]          = "VolumeDown",
    ["audionext"]           = "AudioNext",
    ["audioprev"]           = "AudioPrev",
    ["audiostop"]           = "AudioStop",
    ["audioplay"]           = "AudioPlay",
    ["audiomute"]           = "AudioMute",
    ["mediaselect"]         = "MediaSelect",
    ["www"]                 = "WWW",
    ["mail"]                = "Mail",
    ["calculator"]          = "Calculator",
    ["computer"]            = "Computer",
    ["acsearch"]            = "ACSearch",
    ["achome"]              = "ACHome",
    ["acback"]              = "ACBack",
    ["acforward"]           = "ACForward",
    ["acstop"]              = "ACStop",
    ["acrefresh"]           = "ACRefresh",
    ["acbookmarks"]         = "ACBookmarks",
    ["power"]               = "Power",
    ["brightnessdown"]      = "BrightnessDown",
    ["brightnessup"]        = "BrightnessUp",
    ["displayswitch"]       = "DisplaySwitch",
    ["kbdillumtoggle"]      = "KBDIllumToggle",
    ["kbdillumdown"]        = "KBDDIllumDown",
    ["kbdillumup"]          = "KBDIillumUp",
    ["eject"]               = "Eject",
    ["sleep"]               = "Sleep",
    ["alterase"]            = "AltErase",
    ["sysreq"]              = "SysReq",
    ["cancel"]              = "Cancel",
    ["clear"]               = "Clear",
    ["prior"]               = "Prior",
    ["return2"]             = "Return2",
    ["separator"]           = "Separator",
    ["out"]                 = "Out",
    ["oper"]                = "OpEr",
    ["clearagain"]          = "ClearAgain",
    ["crsel"]               = "CrSel",
    ["exsel"]               = "ExSel",
    ["kp00"]                = "Pad00",
    ["kp000"]               = "Pad000",
    ["thsousandsseparator"] = "ThousandsSeparator",
    ["decimalseparator"]    = "DecimalSeparator",
    ["currencyunit"]        = "CurrencyUnit",
    ["currencysubunit"]     = "CurrencySubUnit",
    ["app1"]                = "App1",
    ["app2"]                = "App2",
    ["unknown"]             = "Unknown",
  },

  ["MatrixLayout"] = {
    ["row"]    = "Row",
    ["column"] = "Column",
  },

  ["CursorType"] = {
    ["image"]     = "Image",
    ["arrow"]     = "Arrow",
    ["ibeam"]     = "Ibeam",
    ["wait"]      = "Wait",
    ["waitarrow"] = "WaitArrow",
    ["crosshair"] = "Crosshair",
    ["sizenwse"]  = "SizeNWSE",
    ["sizenesw"]  = "SizeNESW",
    ["sizewe"]    = "SizeWE",
    ["sizens"]    = "SizeNS",
    ["sizeall"]   = "SizeAll",
    ["no"]        = "No",
    ["hand"]      = "Hand",
  },

  ["BodyType"] = {
    ["static"]    = "Static",
    ["dynamic"]   = "Dynamic",
    ["kinematic"] = "Kinematic",
  },

  ["JointType"] = {
    ["distance"]  = "Distance",
    ["friction"]  = "Friction",
    ["gear"]      = "Gear",
    ["mouse"]     = "Mouse",
    ["prismatic"] = "Prismatic",
    ["pulley"]    = "Pulley",
    ["revolute"]  = "Revolute",
    ["rope"]      = "Rope",
    ["weld"]      = "Weld",
  },

  ["ShapeType"] = {
    ["circle"]  = "Circle",
    ["polygon"] = "Polygon",
    ["edge"]    = "Edge",
    ["chain"]   = "Chain",
  },

  ["PowerState"] = {
    ["unknown"]   = "Unknown",
    ["battery"]   = "Battery",
    ["nobattery"] = "NoBattery",
    ["charging"]  = "Charging",
    ["charged"]   = "Charged",
  },

  ["DisplayOrientation"] = {
    ["unknown"]          = "Unknown",
    ["landscape"]        = "Landscape",
    ["landscapeflipped"] = "LandscapeFlipped",
    ["portrait"]         = "Portrait",
    ["portraitflipped"]  = "PortraitFlipped",
  },

  ["FullscreenType"] = {
    ["desktop"]   = "Desktop",
    ["exclusive"] = "Exclusive",
    ["normal"]    = "Normal",
  },

  ["MessageBoxType"] = {
    ["info"]    = "Info",
    ["warning"] = "Warning",
    ["error"]   = "Error",
  },
}

-- Register enums globally
for key in pairs(enum_table) do
  jai_types[key] = { lua = key, jai = "*u8", builtin = false, type = TYPE_ENUM }
end

function generate_enum_binding(enum, module)
  local buf     = ("%s :: enum {\n"):format(enum.name)
  local arr_buf = ("%sMap :: string.[ "):format(enum.name)

  local jai_enum = enum_table[enum.name]
  for i, member in ipairs(enum.constants) do
    local jai_name = jai_enum[member.name]
    if jai_name ~= nil then
      buf = buf .. ("\t%s; // %s\n"):format(jai_name, member.name)
      if jai_name == "DoubleQuote" or jai_name == "BSlash" then
        member.name = '\\' .. member.name
      end

      arr_buf = arr_buf .. ('"%s"'):format(member.name)
      if i <= #enum.constants - 1 then
        arr_buf = arr_buf .. ", "
      end
    end
  end
  
  arr_buf = arr_buf .. " ];\n\n"
  buf     = buf .. "}\n" .. arr_buf

  return buf
end

function generate_type_binding(t, module)
  if jai_types[t.name] == nil then
    jai_types[t.name]  = { lua = t.name, jai = t.name, builtin = false, type = TYPE_OBJECT }
  end

  return ("%s :: #type,distinct lua.Ref;\n"):format(t.name)
end

function write_entire_file(filename, content)
  local handle = io.open(filename, "w+")
  if handle == nil then
    print(("Unable to write to file '%s'"):format(filename))
    return
  end
  
  handle:write(content) 
  handle:close()  
end


-- GENERATE EVERYTHING

for _, t in ipairs(api.types) do
  print((".. generating type: '%s'"):format(t.name))
  generate_type_binding(t, nil)
end

for _, module in ipairs(api.modules) do 
  print((".. generating: '%s'"):format(module.name))

  local mod_buffer = "// This file was generated by generate_bindings.lua\n\n"
  
  for _, t in ipairs(module.types) do
    mod_buffer = mod_buffer .. generate_type_binding(t, module) 
  end
  
  mod_buffer = mod_buffer .. "\n"
  
  for _, enum in ipairs(module.enums) do
    mod_buffer = mod_buffer .. generate_enum_binding(enum, module)
  end
  
  mod_buffer = mod_buffer .. "\n"
  
  for _, func in ipairs(module.functions) do
    if func.what == "function" then -- ignore callbacks
      mod_buffer = mod_buffer .. generate_fn_binding(func, module)
    end
  end
  
  local filename = ("love_%s.jai"):format(module.name)
  write_entire_file(filename, mod_buffer)
end
