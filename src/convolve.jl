using ImageFiltering
using OffsetArrays

function convolve(x::Vector{<:Vector{<:Real}}, σ::Real=10)::Array{Array{Float64, 1}, 1}
	convolve.(x, σ)
end

function convolve(x::Vector{<:Real}, σ::Real=10)::Array{Float64, 1}
    kernel = Kernel.gaussian((σ,))
	OffsetArrays.no_offset_view(imfilter(x, kernel, Inner()))
end
