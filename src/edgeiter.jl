import Base: iterate, length, show

struct EdgeIter{T}
    g::T
end

length(eit::EdgeIter) = ne(eit.g)

show(io::IO, eit::EdgeIter) = write(io, "EdgeIter $(length(eit))")

function iterate(eit::EdgeIter, state=(1,1))
    fadjlist = fadj(eit.g)
    n = nv(eit.g)
    (i,j) = state
    n == 0 && return nothing

    while i <= n
        if j > length(fadjlist[i])
            i += 1
            j = 1
            continue
        end
        e = Edge(i, fadjlist[i][j])
        state = (i,j+1)
        return (e, state)
    end

    return nothing
end
