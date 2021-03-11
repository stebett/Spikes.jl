module Spikes

include("average.jl") 
include("bin.jl")
include("convolve.jl")
include("couple.jl") # Move to project
include("cross-correlation.jl")
include("cut.jl")
include("drop.jl")
include("filter-active.jl")
include("multi-psth.jl")
include("normalize.jl")
include("section-trial.jl")
include("section.jl")
include("sort.jl")


export absolute,
	   absolute!,
	   average,
	   bin,
	   convolve,
	   couple,   
	   crosscor,
	   crosscor_c,
	   cut,
	   deviation,
	   diff,
	   drop,
	   drop!,
	   get_active_trials,
	   get_active_from_merged,
	   merge_trials,
	   multi_psth,
	   normalize,
	   relative,
	   relative!,
	   section,
	   section_trial,
	   sort_active,
	   sort_peaks,
	   sort_agg_peaks!,
	   sort_peaks!
end
