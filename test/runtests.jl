using JGraph
using Test

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
    @test has_edge(g, 3, 4) == false

    # test the handshake lemma
    @test sum(degree(g)) == 2*ne(g)
end

@testset "JGraph.random" begin
    g = erdos_renyi(10, 0.2);
    @test nv(g) == 10
    # test the handshake lemma
    @test sum(degree(g)) == 2*ne(g)
end
