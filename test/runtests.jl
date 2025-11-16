using CocoTools; c=CocoTools
using Test

@testset "CocoTools.jl" begin
    @test c.classnumber2classname(21) == "cow"
    @test c.classname2classnumber("cow") == 21
    @test c.colormap2classnumber((120,166,157)) == 21
    @test c.get_classname(0) == "background"
    @test c.get_classname(300) == "background"
    @test c.get_classnumber("background") == 0
end
