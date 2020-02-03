abstract type AbstractGraph end

mutable struct Graph{T <: Integer} <: AbstractGraph
    ne::T
    adjlist::Vector{Vector{T}}

    function Graph()
        new{Int64}(0, [])
    end
end

nv(G::AbstractGraph) = length(G.adjlist)

ne(G::AbstractGraph) = G.ne

function has_edge(G::AbstractGraph, u::T, v::T) where T <: Integer
    if max(u,v) > nv(G)
        return false
    elseif v in G.adjlist[u]
        return true
    else
        return false
    end
end

function add_edge!(G::AbstractGraph, u::T, v::T) where T <: Integer
    if has_edge(G, u, v)
        return true
    end
    if nv(G) < max(u,v)
        add_vertex!(G, max(u,v));
    end
    push!(G.adjlist[u], v);
    push!(G.adjlist[v], u);
    G.ne += 1;
end

function add_vertex!(G::AbstractGraph, num_vertex::T) where T <: Integer
    while nv(G) < num_vertex
        add_vertex!(G);
    end
end

function add_vertex!(G::AbstractGraph)
    push!(G.adjlist, Vector{Int}());
end

function degree(G::AbstractGraph)
    degree_list = []
    for u in G.adjlist
        push!(degree_list, length(u))
    end
    degree_list
end
