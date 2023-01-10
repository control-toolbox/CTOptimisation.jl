# --------------------------------------------------------------------------------------------------
# Aliases for types
const Primal = Vector{<:Real}
const Dimension = Integer

# --------------------------------------------------------------------------------------------------
# Optimisation Problem
abstract type OptimisationProblem end

# Unconstrained pb: min f(x), x ∈ Rⁿ
# todo: on pourra laisser au solveur le calcul du gradient si on ne le fournit pas. A voir.
struct UnconstrainedProblem <: OptimisationProblem
    f::Function # function to minimize
    ∇f::Function # gradient of the function
    n::Union{Dimension,Nothing} # f(x), x ∈ Rⁿ
    function UnconstrainedProblem(f::Function, ∇f::Function, n::Union{Dimension,Nothing}=nothing)
        new(f, ∇f, n)
    end
    function UnconstrainedProblem(f::Function, n::Union{Dimension,Nothing}=nothing)
        ∇f(x) = ∇(f, x)
        new(f, ∇f, n)
    end
end

# Creation of an unconstrained problem
function NLP(f::Function, ∇f::Function)
    return UnconstrainedProblem(f, ∇f)
end

function NLP(f::Function)
    return UnconstrainedProblem(f)
end

# --------------------------------------------------------------------------------------------------
# Initialization
abstract type OptimisationInit end

# --------------------------------------------------------------------------------------------------
# Solution
abstract type OptimisationSolution end

# --------------------------------------------------------------------------------------------------
# 
# some texts related to results...
textsStopping = Dict(
    :optimality => "optimality necessary conditions reached up to numerical tolerances", 
    :stagnation => "the step length became too small", 
    :iterations => "maximal number of iterations reached")

# --------------------------------------------------------------------------------------------------
# Resolution

# by order of preference
algorithms = ()

# descent methods
algorithms = add(algorithms, (:descent, :bfgs, :bissection))
algorithms = add(algorithms, (:descent, :bfgs, :backtracking))
algorithms = add(algorithms, (:descent, :bfgs, :fixedstep))
algorithms = add(algorithms, (:descent, :gradient, :bissection))
algorithms = add(algorithms, (:descent, :gradient, :backtracking))
algorithms = add(algorithms, (:descent, :gradient, :fixedstep))

function solve(nlp::OptimisationProblem, description...; kwargs...)
    method = getFullDescription(makeDescription(description...), algorithms)
    # if no error before, then the method is correct: no need of else
    if :descent ∈ method
        return solve_by_descent(nlp, method; kwargs...)
    end
end

# todo: ajouter Base.show, cf. ocp.jl