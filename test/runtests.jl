using Spikes
using Test
using SafeTestsets


@testset "Spikes.jl" begin
	@safetestset "bin" begin include("test/bin-test.jl") end
	@safetestset "average" begin include("test/average-test.jl") end
	@safetestset "convolve" begin include("test/convolve-test.jl") end
	@safetestset "cross-correlation" begin include("test/cross-correlation-test.jl") end
end;
