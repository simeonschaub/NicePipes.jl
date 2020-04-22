using NicePipes
using Documenter

makedocs(;
    modules=[NicePipes],
    authors="Simeon Schaub <simeondavidschaub99@gmail.com> and contributors",
    repo="https://github.com/simeonschaub/NicePipes.jl/blob/{commit}{path}#L{line}",
    sitename="NicePipes.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://simeonschaub.github.io/NicePipes.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/simeonschaub/NicePipes.jl",
)
