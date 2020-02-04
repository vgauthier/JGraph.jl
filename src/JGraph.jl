module JGraph

using Distributions

# export
export  AbstractGraph,
        Graph,
        nv,
        ne,
        has_edge,
        add_edge!,
        add_vertex!,
        degree

export  erdos_renyi

# Include
include("core.jl")
include("random.jl")

end # module
