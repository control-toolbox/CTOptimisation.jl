# --------------------------------------------------------------------------------------------------
# Aliases for types
const Primal = Vector{<:Real}
const Dimension = Integer

# --------------------------------------------------------------------------------------------------
# Abstract Optimisation Problem, init and solution
abstract type OptimisationProblem end
abstract type OptimisationInit end
abstract type OptimisationSolution end

# --------------------------------------------------------------------------------------------------
# Unconstrained pb: min f(x), x ∈ Rⁿ
# Problem
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

# init
struct UnconstrainedInit <: OptimisationInit
    x::Primal
end

# solution
struct UnconstrainedSolution <: OptimisationSolution
    x::Primal
    stopping::Symbol
    message::String
    iterations::Integer
end
