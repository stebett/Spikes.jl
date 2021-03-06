using Statistics
using DataFrames

function average(x::Vector, df::DataFrame)
	average(x, df.lift)
end

function average(x::Vector, y::Vector{<:Vector{<:Real}})
	a = cumsum(length.(y))
	b = pushfirst!(a[1:end-1] .+ 1, 1)
	c = UnitRange.(b, a) 
	[mean(x[r]) for r in c]
end

function deviation(x::Vector, y::Vector{<:Vector{<:Real}})
	a = cumsum(length.(y))
	b = pushfirst!(a[1:end-1] .+ 1, 1)
	c = UnitRange.(b, a) 
	[std(x[r]) for r in c]
end
