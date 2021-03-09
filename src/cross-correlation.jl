using Statistics
using StatsBase
import StatsBase.crosscor
import StatsBase.crosscor!

@inline function crosscor_c(df, c, active_c::Dict, binsize, norm=true) 
	r = zeros(81, length(c))
	lags = -40. * binsize : binsize : 40. * binsize
	@inbounds for i = eachindex(c)
		c1 = abscut(df[df.index .== c[i][1], :t]..., active_c[c[i]]) 
		c2 = abscut(df[df.index .== c[i][2], :t]..., active_c[c[i]])
		crosscor!(view(r, :, i), c1, c2, lags, norm, binsize=binsize)
	end
	r
end

@inline function crosscor_c(df, c, around::Vector, binsize, norm=true) 
	r = zeros(81, length(c))
	lags = -40. * binsize : binsize : 40. * binsize
	@inbounds for i = eachindex(c)
		c1 = abscut(df[df.index .== c[i][1], :t]..., df[df.index .== c[i][1], :cover]..., around) 
		c2 = abscut(df[df.index .== c[i][2], :t]..., df[df.index .== c[i][2], :cover]..., around)
		crosscor!(view(r, :, i), c1, c2, lags, norm, binsize=binsize)
	end
	r
end

@inline function crosscor!(r, x::Vector, y::Vector, lags, norm::Bool; binsize::Real)
	@assert all(diff(lags) .== binsize) 
	if isempty(x) || isempty(y) || any(isinf.(x)) || any(isinf.(y))
		r .= NaN
		return
	end

	@inbounds for k in x
	    r .+= [sum([k+i .<= y .< k+i+binsize]...) for i = lags] # is this faster if y is sorted?
	end
	if norm
		zscore!(r, mean(r), std(r))
	end
end

@inline function crosscor(x::Vector, y::Vector, norm::Bool; binsize::Real, lags=[-40:40;])
	r = zeros(length(lags))
	crosscor!(r, x, y, lags, norm, binsize=binsize)
	r
end
