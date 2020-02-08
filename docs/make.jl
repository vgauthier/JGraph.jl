using Pkg
Pkg.activate(@__DIR__)

using JGraph
using Documenter

makedocs(;
    modules=[JGraph],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    sitename="JGraph.jl",
    authors="Vincent Gauthier",
    doctest  = true,
)


deploydocs(;
    target = "build",
    branch = "gh-pages",
    repo="github.com/vgauthier/JGraph.jl.git",
    devbranch = "master",
    devurl = "dev",
    versions = ["stable" => "v^", "v#.#", "dev" => "dev"]
)
