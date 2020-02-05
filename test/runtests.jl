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
end

@testset "JGraph.traversal" begin
    g = Graph();
    @test add_edge!(g, 1, 2) == true
    @test add_edge!(g, 2, 3) == true
    @test add_edge!(g, 3, 1) == true
    @test bfs(g, 1) == Set([2, 1, 3])
end
