function bfs(G, source)
    visited = Set(source);
    q = Deque{typeof(source)}()
    push!(q, source);
    while ! isempty(q)
        v = popfirst!(q);
        for n in neighbors(G, v)
            if ~(n in visited)
                push!(q, n);
                push!(visited, n);
            end
        end
    end
    return visited
end
