using StatsBase
using Statistics

function normalize(x::Array{Array{Float64, 1}, 1}, y::Array{Array{Float64, 1}, }, args...)::Array{Array{Float64, 1}, 1}
	normalize.(x, y)
end

function normalize(x::Array{<:Real, 1}, y::Array{<:Real, 1}, args...)::Array{<:Real, 1}
	if std(y) == 0.
		return zeros(size(x))
	end

	if :mad in args
		return (x .- median(y)) ./ mad(y)
	end

	(x .- mean(y)) ./ std(y)
end

