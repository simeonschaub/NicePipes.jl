module NicePipes

if VERSION < v"1.3.0-rc4"
    @warn "Can't use binary artifacts, using your system's `grep` and `sed`."
    grep(f) = f("grep")
    sed(f) = f("sed")
else
    using grep_jll, sed_jll
end

struct ShPipe{T,C}
    val::T
    cmd::C
    args::Cmd
end

# like Base.open, but doesn't throw if exitcode is non-zero and always returns process instead
# of return value of f
function _open(f::Function, cmds::Base.AbstractCmd, args...; kwargs...)
    P = open(cmds, args...; kwargs...)
    ret = try
        f(P)
    catch
        kill(P)
        rethrow()
    finally
        close(P.in)
    end
    wait(P)
    return P
end


function Base.show(io_out::IO, x::ShPipe)
    x.cmd() do cmd
        p = _open(`$cmd $(x.args)`, "w", io_out) do io_in
            show(io_in, MIME("text/plain"), x.val)
        end
        if x.cmd === grep && p.exitcode == 1
            println(io_out, "No matches found!")
        elseif p.exitcode != 0
            print(io_out, "Command $(p.cmd) failed with exit code $(p.exitcode)")
        elseif x.cmd === grep
            # delete additional newline
            print(io_out, "\033[1A")
        end
    end
    return nothing
end

struct ShPipeEndpoint{C}
    cmd::C
    args::Cmd
end

macro p_cmd(s)
    cmd, args = match(r"^(.*)\s(.*)$", s).captures
    return :(ShPipeEndpoint(f->f($cmd)), @cmd($args))
end

(endpoint::ShPipeEndpoint)(val) = ShPipe(val, endpoint.cmd, endpoint.args)
Base.:|(val, endpoint::ShPipeEndpoint) = val |> endpoint


macro special_command(cmd)
    return quote
        export $(Symbol('@', cmd))
        macro $cmd(args...)
            args = map(args) do arg
                # interpret raw_str as raw string
                if Meta.isexpr(arg, :macrocall) && arg.args[1] === Symbol("@raw_str")
                    arg = arg.args[3]
                end
                return arg isa String ? string('"', arg, '"') : arg
            end
            args = join(args, ' ')
            return :(ShPipeEndpoint($$cmd, @cmd($args)))
        end
    end |> esc
end

@special_command grep
@special_command sed

end
