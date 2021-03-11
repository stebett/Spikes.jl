
function bin(x::Array{Array{Float64, 1}, 1}, len::Int, binsize::Float64=1.; binary=false)::Array{Array{Float64,1 }, 1}
	if binary
		return binary_bin.(x, len, binsize)
	end
	bin.(x, len, binsize)
end

function bin(x::Array{Float64, 1}, len::Int, binsize::Float64=1.)::Array{Float64, 1}
	[sum([i .<= x .< i+binsize][1]) for i = 1:binsize:len+1-binsize]
end

function binary_bin(x::Array{Float64, 1}, len::Int, binsize::Float64=1.)::Array{Float64, 1}
	[any(i .<= x .< i+binsize) for i = 1:binsize:len+1-binsize]
end
