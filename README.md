# NicePipes

[![Build Status](https://github.com/simeonschaub/NicePipes.jl/workflows/CI/badge.svg)](https://github.com/simeonschaub/NicePipes.jl/actions)
[![Coverage](https://codecov.io/gh/simeonschaub/NicePipes.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/simeonschaub/NicePipes.jl)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://simeonschaub.github.io/NicePipes.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://simeonschaub.github.io/NicePipes.jl/dev)

Pipe REPL `show` output into unix tools:

```julia-repl
julia> using NicePipes

julia> methods(+) | @grep BigFloat
[15] +(c::BigInt, x::BigFloat) in Base.MPFR at mpfr.jl:414
[22] +(a::BigFloat, b::BigFloat, c::BigFloat, d::BigFloat, e::BigFloat) in Base.MPFR at mpfr.jl:564
[23] +(a::BigFloat, b::BigFloat, c::BigFloat, d::BigFloat) in Base.MPFR at mpfr.jl:557
[24] +(a::BigFloat, b::BigFloat, c::BigFloat) in Base.MPFR at mpfr.jl:551
[25] +(x::BigFloat, c::BigInt) in Base.MPFR at mpfr.jl:410
[26] +(x::BigFloat, y::BigFloat) in Base.MPFR at mpfr.jl:379
[27] +(x::BigFloat, c::Union{UInt16, UInt32, UInt64, UInt8}) in Base.MPFR at mpfr.jl:386
[28] +(x::BigFloat, c::Union{Int16, Int32, Int64, Int8}) in Base.MPFR at mpfr.jl:394
[29] +(x::BigFloat, c::Union{Float16, Float32, Float64}) in Base.MPFR at mpfr.jl:402
[61] +(c::Union{UInt16, UInt32, UInt64, UInt8}, x::BigFloat) in Base.MPFR at mpfr.jl:390
[62] +(c::Union{Int16, Int32, Int64, Int8}, x::BigFloat) in Base.MPFR at mpfr.jl:398
[63] +(c::Union{Float16, Float32, Float64}, x::BigFloat) in Base.MPFR at mpfr.jl:406
```
