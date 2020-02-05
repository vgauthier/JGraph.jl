using Pkg
Pkg.activate(@__DIR__)

CI = get(ENV, "CI", nothing) == "true"
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
    repo="github.com/vgauthier/JGraph.jl",
    target="stable",
    devurl = "dev",
)
