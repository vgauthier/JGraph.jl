using JGraph
using Test
using Statistics

@testset "JGraph.core" begin
    g = Graph();
    @test ne(g) == 0
    @test nv(g) == 0

    # add vertices
    g = Graph();
    add_vertex!(g, 10)
    @test ne(g) == 0
    @test nv(g) == 10

    # add a edge
    g = Graph();
    add_edge!(g, 3, 4);
    @test ne(g) == 1
    @test nv(g) == 4
    @test has_edge(g, 3, 4) == true
    @test has_edge(g, 4, 3) == true

    # test if the edge is already there
    @test add_edge!(g, 3, 4) == false

    # test the handshake lemma
    @test sum(degree(g)) == 2*ne(g)

    # test the neighbors function
    g = Graph();
    @test add_edge!(g, 1, 2) == true
    @test add_edge!(g, 2, 3) == true
    @test add_edge!(g, 3, 1) == true
    @test neighbors(g, 1) == [2, 3]

    # test itertor
    g = Graph();
    add_vertex!(g, 10);
    @test collect(vertices(g)) == collect(1:10)

    # test remove edge
    g = Graph()
    add_edge!(g, 1, 2)
    add_edge!(g, 2, 3)
    add_edge!(g, 3, 1)

    remove_edge!(g, 3, 1)

    @test !has_edge(g, 3, 1)
    @test !has_edge(g, 1, 3)

    e = Edge((1, 2))
    remove_edge!(g, e)

    @test !has_edge(g, 2, 1)
    @test !has_edge(g, 1, 2)

    #  test remove all_edges incident to a node
    g = Graph()
    add_edge!(g, 1, 2)
    add_edge!(g, 2, 3)
    add_edge!(g, 3, 1)

    remove_vertex!(g, 2)
    @test !has_edge(g, 2, 1)
    @test !has_edge(g, 1, 2)
    @test !has_edge(g, 2, 3)
    @test !has_edge(g, 3, 2)
end

@testset "JGraph.edge" begin
    e1 = Edge((1, 2))
    e2 = Edge(Pair(2, 1))
    e3 = Edge((2, 3))
    e4 = Edge((3, 2))
    e5 = Edge((1, 2))
    results = [e4, e3, e2, e1];

    @test src(e1) == 1
    @test dst(e1) == 2

    @test src(e2) == 2
    @test dst(e2) == 1
    @test e1 == e5
    
    ## test iterator 
    g = Graph();
    add_edge!(g, 1, 2);
    add_edge!(g, 2, 3);

    @test length(edges(g)) == 2

    for e in edges(g)
        @test e == pop!(results)
    end
end

@testset "JGraph.generator" begin
    g = erdos_renyi(10, 0.2)
    @test nv(g) == 10

    # test the handshake lemma
    @test sum(degree(g)) == 2*ne(g)

    # test the mean degree
    n = 10000;
    p = 0.0003;
    kmean = (n-1) * p
    g = erdos_renyi(n, p);
    @test mean(degree(g)) ≈ kmean atol=1e-1

    g1 = erdos_renyi(n, p, seed=5);
    g2 = erdos_renyi(n, p, seed=5);
    @test nv(g1) == nv(g2)
    @test ne(g1) == ne(g2)
end

@testset "JGraph.traversal" begin
    g = Graph();
    @test add_edge!(g, 1, 2) == true
    @test add_edge!(g, 2, 3) == true
    @test add_edge!(g, 3, 1) == true
    @test bfs(g, 1) == Set([2, 1, 3])

    g = Graph();
    add_vertex!(g, 6);
    add_edge!(g, 1, 2);
    add_edge!(g, 2, 3);
    add_edge!(g, 1, 3);

    add_edge!(g, 4, 5);
    add_edge!(g, 5, 6);
    add_edge!(g, 4, 6);

    cc = connected_components(g);
    for elem in cc 
        @test length(elem) == 3
    end

    @test bfs(g, 1) == Set([2, 3, 1])
    @test bfs(g, 4) == Set([4, 5, 6])
end
