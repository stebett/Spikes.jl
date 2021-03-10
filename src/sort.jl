using Statistics

function sort_active(n::Matrix, center::Int)
	n = drop(n)
	half = size(n, 1) ÷ 2
	rates = mean(@view(n[half-center:half+center, :]), dims=1)
	p = sortperm(rates[:])
	ordered_n = n[:, p]
end

function sort_peaks(n::Matrix)
	peaks = map(x -> x[1][1], argmax(n, dims=1))
	p = sortperm(peaks[:])
	ordered_n = n[:, p]
end


function sort_agg_peaks!(n::Vector{<:Vector{<:Real}}, binsize::Int)
	agg_n = zeros(length(n[1])÷binsize, length(n))

	for (i, j) in enumerate(1:binsize:length(n[1]))
		agg_n[i, :] = mean.(getindex.(n, Ref(j:j+binsize-1)))
	end
	peaks = map(x -> x[1][1], argmax(agg_n, dims=1))
	p = sortperm(peaks[:])
	n .= n[p]
	for i in unique(peaks)
		idx = peaks[p] .== i
		sort_peaks!(@view n[idx])
	end
end

function sort_peaks!(n::AbstractVector)
	peaks = argmax.(n)
	p = sortperm(peaks)
	n .= n[p]
end

function sort_peaks!(n::Matrix)
	peaks = map(x -> x[1][1], argmax(n, dims=1))
	p = sortperm(peaks[:])
	n .= n[:, p]
end
