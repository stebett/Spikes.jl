using Spikes
using Test

x = [i % 5 for i in 1:100]
X = [x for _ in 1:100]
σ = 10

y = convolve(x, σ)
@test all(isapprox.(y, 2, atol=1e-2))
@test all([i == y for i in convolve(X, σ)])

