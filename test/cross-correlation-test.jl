using StatsBase
using Test


"""
Test using

1. Equal spike trains
2. Slighly different in both directions
3. Repeat for union of distant spiketrains
4. Repeat for binsize smaller and bigger than 1
5. Test normalization after is equal normalization inside
6. Test allocations make sense
7. Test type stability
8. Test NaN returned in the right cases
9. Test that the code doesn't work with wrong lags
"""

# 1.
a = b = [1:5:100;];
@test [0., 0., 20., 0., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

# 2.
a = [1:5:100;];
b = a .+ 1;
@test [0., 0., 0., 20., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

a = [1:5:100;];
b = a .- 1;
@test [0., 20., 0., 0., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

# 3.
a = b = [1:10:100; 1001:10:1100];
@test [0., 0., 20., 0., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

a = [1:10:100; 1001:10:1100];
b = a .+ 1;
@test [0., 0., 0., 20., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

a = [1:10:100; 1001:10:1100];
b = a .- 1;
@test [0., 20., 0., 0., 0.] == crosscor(a, b, false, binsize=1, lags=[-2:1:2;])

# 4.
a = b = [1:5:100;];
@test [0., 0., 20., 0., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

a = [1:5:100.;];
b = a .+ 0.6;
@test [0., 0., 0., 20., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

a = [1:5:100;];
b = a .- 0.3;
@test [0., 20., 0., 0., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

a = b = [1:10:100; 1001:10:1100];
@test [0., 0., 20., 0., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

a = [1:10:100; 1001:10:1100];
b = a .+ 0.6;
@test [0., 0., 0., 20., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

a = [1:10:100; 1001:10:1100];
b = a .- 0.3;
@test [0., 20., 0., 0., 0.] == crosscor(a, b, false, binsize=0.5, lags=[-1:0.5:1;])

# 5.

a = b = [1:5:100;];
@test crosscor(a, b, true, binsize=1.) == zscore(crosscor(a, b, false, binsize=1.))

# 6.
@test (@allocated crosscor(a, b, false, binsize=1.)) <= 400000

# 7. 
@test @inferred [0, 0, 20, 0, 0] ==  crosscor(a, b, false, binsize=1., lags=[-2:2;])

# 8.
a = [1:5:100;]
b = []
@test all(isnan.(crosscor(a, b, false, binsize=1., lags=[-2:2;])))

a = []
b = [1:5:100;]
@test all(isnan.(crosscor(a, b, false, binsize=1., lags=[-2:2;])))

a = []
b = []
@test all(isnan.(crosscor(a, b, false, binsize=1., lags=[-2:2;])))

a = [1:5:95; Inf]
b = [1:5:100;]
@test all(isnan.(crosscor(a, b, false, binsize=1., lags=[-2:2;])))

a = [1:5:95;]
b = [1:5:95; Inf]
@test all(isnan.(crosscor(a, b, false, binsize=1., lags=[-2:2;])))

# 9.
a = b = [1:5:100;];
@test_throws AssertionError crosscor(a, b, false, binsize=2., lags=[-2:0.5:2;])
