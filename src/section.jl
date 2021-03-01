using Statistics

function section(x, y, z, args...; σ=10, over=[-500., 500.], binsize=1.)
	if :conv in args 
		z = [z[1] - 2σ, z[2] + 2σ]
	end

	if z isa Tuple
		z = [z[1], z[2]]
	end

	if !(eltype(z) isa Float64)
		z .= Array{Float64, 1}(z)
	end

	m = cut(x, y, z) |> k->bin(k, floor(Int, diff(z)...), binsize)

	if :conv in args 
		m = convolve(m, σ/binsize)
	end

	if :norm in args
		n = section(x, y, over) |> k->bin(k, floor(Int, diff(over)...), binsize) 
		m = normalize(m, n)
	end

	if :avg in args && y isa Array{Array{Float64, 1}, 1}
		average(m, y)

	elseif :avg in args && y isa Array{Float64, 1}
		return mean(hcat(m...), dims=2)
	end
	m
end

