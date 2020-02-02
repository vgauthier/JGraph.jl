push!(LOAD_PATH,"../src/")
using Documenter, JGraph

makedocs(;
    modules=[JGraph],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    sitename="JGraph.jl",
    authors="Vincent Gauthier",
    doctest  = false,
)

deploydocs(;
    repo="github.com/vgauthier/JGraph.jl.git",
    branch = "gh-pages",
    target = "build",
)
