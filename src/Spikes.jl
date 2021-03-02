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
	   drop,
	   get_active_trials,
	   merge_trials,
	   normalize,
	   relative!,
	   section,
	   sectionTrial,
	   section_trial,
	   sort_active,
	   sort_peaks
end
