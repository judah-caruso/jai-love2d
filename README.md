# Love2D bindings for Jai

This weird thing allows you to create games with [Love2D](https://love2d.org) and Jai. It works by autogenerating glue code to call into Love2D's Lua api and exposing that to Jai. All we have to do on the Jai side is compile our game code to a dynamic library that can be loaded on startup.

# Instructions

```bash
# Clone this repo with submodules
git clone --recurse-submodules https://github.com/judah-caruso/jai-love2d

# Generate Jai bindings for Lua 5.1 (needed for Love2D interop; already done)
cd lua51 && jai generate.jai

# Generate Jai bindings for Love2D (will generate the love_*.jai files)
lua5.1 generate_bindings.lua
```

# Usage

See `examples/00-it-works` for a basic example.

# Todo

- Generate the Jai wrapper files using information from the binding generation
- Generate Jai types for the specific Lua tables needed

# License

MIT
