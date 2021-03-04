using StatsBase
using Statistics

function normalize(x::Vector{<:Vector{<:Real}}, y::Vector{<:Vector{<:Real}}, args...)::Array{Array{Float64, 1}, 1}
	normalize.(x, y, args...)
end

function normalize(x::Vector{<:Real}, y::Vector{<:Real}, args...)::Array{Float64, 1}
	if :mad in args
		return (x .- median(y)) ./ mad(y)
	end

	(x .- mean(y)) ./ std(y)
end

# Array{Array{Float64, 1}, 1}(undef, length(m))
# for i in eachindex(m)
# 	    m_mad[i] = (m[i] .- median(m[i][1:8])) ./ (mad(m[i][1:8]))
# 	end

# 	m_z = Array{Array{Float64, 1}, 1}(undef, length(m))
# 	for i in eachindex(m)
# 		    m_z[i] = zscore(m[i], mean(m[i][1:8]), std(m[i][1:8]))
# 		end
		
