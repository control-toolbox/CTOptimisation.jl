# --------------------------------------------------------------------------------------------------
# Aliases for types
const Primal = Vector{<:Real}
const Dimension = Integer

# --------------------------------------------------------------------------------------------------
# Abstract CTOptimization Problem, init and solution
abstract type CTOptimizationProblem end
abstract type CTOptimizationInit end
abstract type CTOptimizationSolution end

# --------------------------------------------------------------------------------------------------
# Unconstrained pb: min f(x), x ∈ Rⁿ
# Problem
struct UnconstrainedProblem <: CTOptimizationProblem
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
function CTOptimizationProblem(f::Function; gradient::Function=x->∇(f, x), dimension::Union{Dimension,Nothing}=nothing)
    return UnconstrainedProblem(f, gradient, dimension)
end

# init
struct UnconstrainedInit <: CTOptimizationInit
    x::Primal
end

# solution
struct UnconstrainedSolution <: CTOptimizationSolution
    x::Primal
    stopping::Symbol
    message::String
    success::Bool
    iterations::Integer
end
