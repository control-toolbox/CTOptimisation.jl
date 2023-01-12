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