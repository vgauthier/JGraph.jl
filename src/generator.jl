function erdos_renyi(n::Int64, p::Float64; seed::Integer=-1)
    if seed > 0
        Random.seed!(seed)
    end
    g = Graph();
    add_vertex!(g, n);
    m = round(Int, n * (n - 1) / 2);
    ne = rand(Binomial(m, p));
    g = Graph(n, ne);
    return g
end
