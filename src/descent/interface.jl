# --------------------------------------------------------------------------------------------------
# Solver of an ocp by descent method
function solve_by_descent(
    nlp::UnconstrainedProblem,
    method::Description;
    init::Union{Nothing,Primal,DescentSolution}=nothing,
    iterations::Integer=__iterations(),
    step_length::Union{Number,Nothing}=__step_length(),
    absoluteTolerance::Number=__absoluteTolerance(),
    optimalityTolerance::Number=__optimalityTolerance(),
    stagnationTolerance::Number=__stagnationTolerance(),
    display::Bool=__display(),
    callbacks::OptimisationCallbacks=__callbacks()
)

    # --------------------------------------------------------------------------------------------------
    # print chosen method
    display ? println("\nMethod = ", method) : nothing

    # we suppose the description of the method is complete
    # we get the direction search and line search methods
    direction, line_search = descent_read(method)

    # --------------------------------------------------------------------------------------------------
    # get the default options for those which depend on the method
    step_length = __step_length(line_search, step_length)

    # --------------------------------------------------------------------------------------------------
    # step 1: transcription from ocp to descent problem and init
    #
    descent_init = make_descent_init(nlp, init)
    descent_problem = make_descent_problem(nlp)

    # --------------------------------------------------------------------------------------------------
    # step 2: resolution of the problem
    cbs_print = get_priority_print_callbacks(callbacks)
    cbs_stop = get_priority_stop_callbacks(callbacks)
    descent_sol = descent_solver(
        descent_problem,
        descent_init,
        direction=direction,
        line_search=line_search,
        iterations=iterations,
        step_length=step_length,
        absoluteTolerance=absoluteTolerance,
        optimalityTolerance=optimalityTolerance,
        stagnationTolerance=stagnationTolerance,
        display=display,
        callbacks=(cbs_print..., cbs_stop...),
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