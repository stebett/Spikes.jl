import Base.diff

diff(x::Tuple) = x[2] - x[1]

function get_active_trials(mpsth, ranges, thr)
	active_trials = []
	for (rng, spiketrain) in zip(ranges, mpsth)
		push!(active_trials, [x[(y .> thr) .& .!isinf.(y)] for (x, y) = zip(rng, spiketrain)])
	end
	active_trials
end

function get_active_from_merged(mpsth, ranges, thr)
	active_trials = []
	for (rng, spiketrain) in zip(ranges, mpsth)
		push!(active_trials, [r[(spiketrain .> thr) .& .!isinf.(spiketrain)] for r = rng])
	end
	active_trials
end

function merge_trials(df, active_trials)
	active_ranges = Dict{Int, Array{Tuple{Float64, Float64}, 1}}()
	for i in eachindex(active_trials)
		active_ranges[df[i, :index]] = vcat(active_trials[i]...)
	end
	active_ranges
end

