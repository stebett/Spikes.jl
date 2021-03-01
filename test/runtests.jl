using Spikes
using Test
using SafeTestsets


@testset "Spikes.jl" begin
	@safetestset "bin" begin include("bin-test.jl") end
end
