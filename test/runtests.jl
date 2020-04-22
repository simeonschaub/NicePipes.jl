using NicePipes
using Test

function test_show(x, show_x)
    io = IOBuffer()
    show(io, x)
    output = String(take!(io))
    output = replace(output, "\n\e[1A" => "")
    @test output == show_x
end

@testset "NicePipes.jl" begin
    a = ["foo", "bar"]
    show_a = [
        "2-element Array{String,1}:",
        " \"foo\"",
        " \"bar\"",
    ]
    test_show((a | @grep foo), show_a[2])
    test_show((a | @grep -iv FoO), join(show_a[[1, 3]], '\n'))
    test_show((a | @sed "/foo/d"), join(show_a[[1, 3]], '\n'))
    test_show((a | @sed raw"s/f\(o\+\)/b\1/g"), show_a[1] * "\n \"boo\"\n" * show_a[3])
end
