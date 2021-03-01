using Statistics

function sort_active(n, center)
	n = drop(n)
	half = size(n, 1) ÷ 2
	rates = mean(@view(n[half-center:half+center, :]), dims=1)
	p = sortperm(rates[:])
	ordered_n = n[:, p]
end

function sort_peaks(n)
	peaks = map(x -> x[1][1], argmax(n, dims=1))
	p = sortperm(peaks[:])
	ordered_n = n[:, p]
end
