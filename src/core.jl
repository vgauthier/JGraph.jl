import Base:show
import JGraph: Edge, EdgeIter

abstract type AbstractGraph end

mutable struct Graph{T <: Integer} <: AbstractGraph
    ne::T
    adjlist::Vector{Vector{T}}

    function Graph()
        new{Int64}(0, [])
    end
end

"""
    Graph(n, m)

generate a graph with n vertices and m edges. Return a graph G.
"""
function Graph(n, m)
    g = Graph();
    add_vertex!(g, n);
    num_vertice = 0

    while num_vertice < m
        s = rand(1:n)
        t = rand(1:n)
        if s != t && !has_edge(g, s, t)
            add_edge!(g, s, t);
            num_vertice += 1
        end
    end
    return g
end

nv(G::AbstractGraph) = length(G.adjlist)

ne(G::AbstractGraph) = G.ne

"""
    has_edge(G::AbstractGraph, u::T, v::T)

Test if egde(u,v) exist in the graph G.
"""
function has_edge(G::AbstractGraph, u::T, v::T) where T <: Integer
    if max(u,v) > nv(G)
        return false
    elseif v in G.adjlist[u]
        return true
    else
        return false
    end
end

has_edge(G::AbstractGraph, e::Edge) = has_edge(G, src(e), dst(e))

"""
    add_edge(G::AbstractGraph, u::T, v::T)

Add the egde(u,v) in the graph G. Return False is the edge already exit, true otherwise.
"""
function add_edge!(G::AbstractGraph, u::T, v::T) where T <: Integer
    if has_edge(G, u, v)
        return false
    end
    if nv(G) < max(u,v)
        add_vertex!(G, max(u,v));
    end
    push!(G.adjlist[u], v);
    push!(G.adjlist[v], u);
    G.ne += 1;
    return true
end

add_edge!(G::AbstractGraph, e::Edge) = add_edge(G, src(e), dst(e))

"""
    add_edge(G::AbstractGraph, num_vertex)

Add "num_vertex" vertices to the graph G.
"""
function add_vertex!(G::AbstractGraph, num_vertex::T) where T <: Integer
    while nv(G) < num_vertex
        add_vertex!(G);
    end
    return true
end

function add_vertex!(G::AbstractGraph)
    return push!(G.adjlist, Vector{Int}());
end

function remove_edge!(G::AbstractGraph, u, v)
    if has_edge(G, u, v)
        G.adjlist[u] = deleteat!(G.adjlist[u], findall(x-> x == v, G.adjlist[u]));
        G.adjlist[v] = deleteat!(G.adjlist[v], findall(x-> x == u, G.adjlist[v]));
        return true
    else
        return false
    end
end

remove_edge!(G::AbstractGraph, e::Edge) = remove_edge!(G, src(e), dst(e))

function remove_vertex!(G::AbstractGraph, s)
    for t in neighbors(G, s)
        remove_edge!(G, s, t)
    end
    return true
end

"""
    degree(G::Graph)

Return the list of nodes degree.
"""
function degree(G::Graph)
    degree_list = []
    for u in G.adjlist
        push!(degree_list, length(u))
    end
    degree_list
end

"""
    neighbors(G::Graph, u)

return the neighbors list adjacent to the node u
"""
function neighbors(G::Graph, u)
    return copy(G.adjlist[u])
end

"""
    vertices(G::Graph)

vertices itertor
"""
vertices(G::Graph) = Base.OneTo(nv(G))

edges(g::AbstractGraph) = EdgeIter(g)

"""
    fadj(G::Graph)

return the adjacency list of the graph
"""
fadj(G::Graph) = G.adjlist
fadj(G::Graph, v::Integer) = G.adjlist[v]

show(io::IO, G::Graph) = print(io, "Undirected Graph G(V,E) with |V|=$(nv(G)), |E|=$(ne(G))");
