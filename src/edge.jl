import Base: Pair, Tuple, show, ==

struct Edge{T<:Integer}
    src::T
    dst::T
end

Edge(t::Tuple) = Edge(t[1], t[2])
Edge(p::Pair) = Edge(p.first, p.second)

# Accessors
src(e::Edge) = e.src
dst(e::Edge) = e.dst

# I/O
show(io::IO, e::Edge) = print(io, "Edge: $(e.src) => $(e.dst)")

==(e1::Edge, e2::Edge) = (src(e1) == src(e2) && dst(e1) == dst(e2))
