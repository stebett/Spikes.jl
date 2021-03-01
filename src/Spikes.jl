module Spikes

include("bin.jl")
include("convolve.jl")
include("couple.jl")
include("cross-correlation.jl")
include("cut.jl")
include("drop.jl")
include("filter-active.jl")
include("normalize.jl")
include("section.jl")
include("section-trial.jl")
include("sectionTrial.jl")
include("sort.jl")
include("average.jl")


export bin,
	   average,
	   relative!,
	   convolve,
	   couple,   
	   crosscor,
	   crosscor_c,
	   cut,
	   drop,
	   get_active_trials,
	   merge_trials,
	   normalize,
	   section,
	   section_trial,
	   sectionTrial,
	   sort_active,
	   sort_peaks
end
