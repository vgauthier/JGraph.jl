using Documenter, JGraph

makedocs(;
    modules=[JGraph],
    format=Documenter.HTML(prettyurls = true),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/vgauthier/JGraph.jl/blob/{commit}{path}#L{line}",
    sitename="JGraph.jl",
    authors="Vincent Gauthier",
    assets=String[],
)

deploydocs(;
    repo="github.com/vgauthier/JGraph.jl",
)
