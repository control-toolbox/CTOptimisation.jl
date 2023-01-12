# todo :
# - doit retourner un OptimisationSolution, ie ici un UnconstrainedSolution
# - on met les valeurs par défaut à l'appel au solveur avec un kwargs bien placé pour la priorité
# - l'init est gérée différemment car on donne plusieurs possibilité :
#   • remplacer DescentSolution par UnconstrainedSolution
#   • ajouter la possibilité de donner une UnconstrainedInit

# --------------------------------------------------------------------------------------------------
# Solver of an ocp by descent method
function solve_by_descent(
    prob::UnconstrainedProblem,
    method::Description;
    init::Union{Nothing,Primal,DescentSolution}=nothing,
    display::Bool=__display(),
    kwargs...
)

    # --------------------------------------------------------------------------------------------------
    # print chosen method
    display ? println("\nMethod = ", method) : nothing

    # we suppose the description of the method is complete
    # we get the direction search and line search methods
    direction, line_search = descent_read(method)

    # --------------------------------------------------------------------------------------------------
    # transcription from ocp to descent problem and init
    #
    descent_init = make_descent_init(prob, init)
    descent_problem = make_descent_problem(prob)

    # --------------------------------------------------------------------------------------------------
    # resolution of the problem
    descent_sol = descent_solver(
        descent_problem,
        descent_init,
        direction=direction,
        line_search=line_search,
        iterations=__iterations(),
        step_length=__step_length(),
        absoluteTolerance=__absoluteTolerance(),
        optimalityTolerance=__optimalityTolerance(),
        stagnationTolerance=__stagnationTolerance(),
        callbacks=__callbacks(),
        display=display,
        kwargs...
    )

    return descent_sol

end

# --------------------------------------------------------------------------------------------------
# read the description to get the chosen methods
# we assume the description is complete
update(e::Union{Nothing, Symbol}, s::Symbol, d::Description) = s ∈ d ? s : e
"""
	read(method::Description)

TBW
"""
function descent_read(method::Description)
    #
    direction = nothing
    direction = update(direction, :gradient, method)
    direction = update(direction, :bfgs, method)
    #
    line_search = nothing
    line_search = update(line_search, :fixedstep, method)
    line_search = update(line_search, :backtracking, method)
    line_search = update(line_search, :bissection, method)
    #
    return direction, line_search
end