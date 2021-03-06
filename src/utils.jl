# Utility functions, not dependent on special types, used throughout the package

function as_Float64_Array(x::Union{Real, AbstractArray}, n::Integer)
    if isa(x, AbstractArray)
        return convert(Array{Float64}, x)
    end
    return fill(convert(Float64, x), n)
end

function mean(x, dim)
    sum(x, dims = dim) ./ size(x, dim)
end

function mean(x)
    sum(x) ./ length(x)
end

function slices_approx_equal(array, dim, atol, rtol)
    all(
        isapprox(
            selectdim(array, dim, 1), selectdim(array, dim, i),
            atol = atol, rtol = rtol
        )
        for i in 2:size(array, dim)
    )
end

function is_napprox_greater(a, b; rtol = EPSILON)
    a > b && !isapprox(a, b, rtol = rtol)
end
