using CocoTools
using Test

@testset "CocoTools.jl" begin
    @test coco_classnumbers[20]  == "cow"
    @test coco_classnames["cow"] == 20
end
