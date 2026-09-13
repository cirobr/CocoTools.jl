using CocoTools; ct=CocoTools
using Test

@testset "CocoTools.jl" begin
    @test ct.classnumber2classname(0) == "background"
    @test ct.classname2classnumber("background") == 0
    @test ct.classnumber2classname(255) == "void"
    @test ct.classname2classnumber("void") == 255
    @test ct.classnumber2classname(21) == "cow"
    @test ct.classname2classnumber("cow") == 21
end
