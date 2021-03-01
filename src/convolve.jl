using ImageFiltering
using OffsetArrays

function convolve(x::Array{Array{Float64, 1}, 1}, σ::Float64=10)::Array{Array{Float64, 1}, 1}
	convolve.(x, σ)
end

function convolve(x::Array{Float64, 1}, σ::Float64=10)::Array{Float64, 1}
    kernel = Kernel.gaussian((σ,))
	OffsetArrays.no_offset_view(imfilter(x, kernel, Inner()))
end
