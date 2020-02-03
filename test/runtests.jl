using JGraph
using Test

@testset "JGraph.core" begin
    g = Graph();
    @test ne(g) == 0
    @test nv(g) == 0

    # add a edge
    add_edge!(g, 3, 4);
    @test ne(g) == 1
    @test nv(g) == 4
    @test has_edge(g, 3, 4)
    @test has_edge(g, 4, 3)

    # test the handshake lemma
    @test sum(degree(g)) == 2*ne(g)
end
