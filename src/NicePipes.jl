module NicePipes

struct ShPipe{T}
    val::T
    cmd::Cmd
end

function Base.show(io_out::IO, x::ShPipe)
    open(x.cmd, io_out, write=true) do io_in
        show(io_in, x.val)
    end
    return nothing
end

struct ShPipeEndpoint
    cmd::Cmd
end

macro p_cmd(s)
    return :(ShPipeEndpoint(@cmd $s))
end

(endpoint::ShPipeEndpoint)(val) = ShPipe(val, endpoint.cmd)
Base.:|(val, endpoint::ShPipeEndpoint) = val |> endpoint


macro special_command(name)
    return quote
        export $(Symbol('@', name))
        macro $name(args...)
            s = $(string(name, " ")) * join(args, " ")
            return :(@p_cmd $s)
        end
    end |> esc
end

@special_command grep
@special_command sed

end
