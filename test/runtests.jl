using Test
using grep_jll
using Sockets

@show srv = listen("\\\\.\\pipe\\testsocket")
@async @show grep() do grep
    run(`$grep Hello "\\\\.\\pipe\\testsocket"`)
end
@show write("\\\\.\\pipe\\testsocket", "Hello, world!\n")
close(srv)
end
