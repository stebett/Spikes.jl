import DataFrames.cut

function cut(x::Vector{T}, y::Vector{T}, z::T)::Array{Array{Float64, 1}, 1} where {T <: Vector{<:Real}}
	[(cut.(x, y, Ref(z))...)...]
end

function cut(x::T, y::T, z::T)::Array{Array{Float64, 1}, 1} where {T <: Vector{<:Real}}
	cut.(Ref(x), y, Ref(z))
end

function cut(x::Vector{T}, y::T, z::Vector{T})::Vector{Float64} where {T <: Real}
	@views x[y + z[1] .<= x .<= y + z[2]] .- y .- z[1]
end

@inline function cut(x::Vector{T}, z::Tuple{T, T})::Vector{Float64} where {T <: Real}
	@views x[z[1] .<= x .<= z[2]]  
end

@inline function cut(x::Vector{T}, z::Vector{<:Tuple{T, T}})::Vector{Float64} where {T <: Real}
	vcat(cut.(Ref(x), z)...)
end
