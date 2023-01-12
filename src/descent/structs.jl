# --------------------------------------------------------------------------------------------------
# definition of a general descent problem
mutable struct DescentProblem
    f::Function # function to minimize
    ∇f::Function # gradient of the function
end

# --------------------------------------------------------------------------------------------------
# definition of an initialization for the descent method
mutable struct DescentInit
    x::Primal # the optimization variable x of the descent method
end

# --------------------------------------------------------------------------------------------------
# definition of a solution for the descent method
mutable struct DescentSolution
    x::Primal # the optimization variable solution
    stopping::Symbol # the stopping criterion at the end of the descent method
    message::String # the message corresponding to the stopping criterion
    success::Bool # whether or not the method has finished successfully: CN1, stagnation vs iterations max
    iterations::Integer # the number of iterations
end

# --------------------------------------------------------------------------------------------------
#
# todo: gérer le cas pas d'init : soit on a la dimension soit exception à lever
function make_descent_init(nlp::UnconstrainedProblem, init::Nothing)
    if nlp.n === nothing
        throw(InconsistentArgument("you must provide either an initial iterate to the solver or the dimension of x to NLP method."))
    end
    return DescentInit(zeros(nlp.n))
end
function make_descent_init(nlp::UnconstrainedProblem, init::Primal)
    return DescentInit(init)
end
function make_descent_init(nlp::UnconstrainedProblem, init::DescentSolution)
    return DescentInit(init.x)
end

# --------------------------------------------------------------------------------------------------
#
function make_descent_problem(nlp::UnconstrainedProblem)
    return DescentProblem(nlp.f, nlp.∇f)
end