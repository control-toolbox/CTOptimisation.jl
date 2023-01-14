# --------------------------------------------------------------------------------------------------
# descent problem, init and solution
mutable struct DescentProblem
    f::Function # function to minimize
    ∇f::Function # gradient of the function
end

mutable struct DescentInit
    x::Primal # the optimization variable x of the descent method
end

mutable struct DescentSolution
    x::Primal # the optimization variable solution
    stopping::Symbol # the stopping criterion at the end of the descent method
    message::String # the message corresponding to the stopping criterion
    success::Bool # whether or not the method has finished successfully: CN1, stagnation vs iterations max
    iterations::Integer # the number of iterations
end

# --------------------------------------------------------------------------------------------------
# make problem
function make_descent_problem(nlp::UnconstrainedProblem)
    return DescentProblem(nlp.f, nlp.∇f)
end

# --------------------------------------------------------------------------------------------------
# make init
function make_descent_init(nlp::UnconstrainedProblem, init::Nothing)
    if nlp.n === nothing
        throw(InconsistentArgument("you must provide either an initial iterate to the solver or the dimension of x to NLP method."))
    end
    return DescentInit(zeros(nlp.n))
end
function make_descent_init(nlp::UnconstrainedProblem, init::Primal)
    return DescentInit(init)
end
function make_descent_init(nlp::UnconstrainedProblem, init::UnconstrainedSolution)
    return DescentInit(init.x)
end
function make_descent_init(nlp::UnconstrainedProblem, init::UnconstrainedInit)
    return DescentInit(init.x)
end

# --------------------------------------------------------------------------------------------------
# make unconstrained problem from descent problem
function make_unconstrained_solution(sol::DescentSolution)
    return UnconstrainedSolution(sol.x, sol.stopping, sol.message, sol.iterations)
end