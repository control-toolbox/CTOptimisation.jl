# --------------------------------------------------------------------------------------------------
# Aliases for types
const Primal = Vector{<:Real}
const Dimension = Integer

# --------------------------------------------------------------------------------------------------
# Optimisation Problem
abstract type OptimisationProblem end

# Unconstrained pb: min f(x), x ∈ Rⁿ
struct UnconstrainedProblem <: OptimisationProblem
    f::Function # function to minimize
    ∇f::Function # gradient of the function
    n::Union{Dimension,Nothing} # f(x), x ∈ Rⁿ
    function UnconstrainedProblem(f::Function, ∇f::Function, n::Union{Dimension,Nothing})
        new(f, ∇f, n)
    end
end

# Creation of an unconstrained problem
# the optional arguments are keywords
# todo: on pourra laisser au solveur le calcul du gradient si on ne le fournit pas. A voir.
function OptimisationProblem(f::Function; gradient::Function=x->∇(f, x), dimension::Union{Dimension,Nothing}=nothing)
    return UnconstrainedProblem(f, gradient, dimension)
end

# --------------------------------------------------------------------------------------------------
# Initialization
abstract type OptimisationInit end

# --------------------------------------------------------------------------------------------------
# Solution
abstract type OptimisationSolution end

