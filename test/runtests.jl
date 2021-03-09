using Spikes
using Test
using SafeTestsets


@testset "Spikes.jl" begin
	@safetestset "bin" begin include("bin-test.jl") end
	@safetestset "average" begin include("average-test.jl") end
	@safetestset "convolve" begin include("convolve-test.jl") end
	@safetestset "cross-correlation" begin include("cross-correlation-test.jl") end
end;
