
function multi_psth(r::Vector{T}, x::Vector{T}, around::Vector{<:Tuple}, binsizes::Vector{T}) where {T <:Real}
	r .= abscut.(Ref(x), around) |> k->(length.(k)) |> k->vcat(k...)
end

function multi_psth(r::Vector{T}, ranges::Vector{<:Tuple}, bins::Vector{T}, 
	x::Vector{T}, lift::T, cover::T, grasp::T, 
	pad::Int, n::Int, b1::Int) where {T <: Real}
	binSizes!(bins, lift, cover, grasp, pad, n, b1)
	tupleRanges!(ranges, lift-pad, bins)
	multi_psth(r, x, ranges, bins)
end
	
function multi_psth(r::Vector{Vector{T}}, ranges::Vector{<:Vector{<:Tuple}}, bins::Vector{T}, row, pad::Int, n::Int, b1::Int) where {T <: Real}
	multi_psth.(r, ranges, Ref(bins), Ref(row.t), row.lift, row.cover, row.grasp, pad, n, b1)
end

function multi_psth(r::Vector{Vector{Vector{T}}}, ranges::Vector{<:Vector{<:Vector{<:Tuple}}}, bins::Vector{T}, df, pad::Int, n::Int, b1::Int) where {T <: Real}
	multi_psth.(r, ranges, Ref(bins), eachrow(df), pad, n, b1)
end
															 
function multi_psth(df, pad::Int, n::Int, b1::Int)
	T = Tuple{Float64, Float64}
	l = 2n + 2pad÷b1

	# Prealloactions
	bins = zeros(l)
	r = [[zeros(l) for _ in 1:length(i)] for i in df.lift]
	ranges = [[Array{T, 1}(undef, l) for _ in 1:length(i)] for i in df.lift]

	multi_psth(r, ranges, bins, df, pad, n, b1)
	return r, ranges
end

