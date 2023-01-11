module CommonSolveOptimisation

using ForwardDiff: jacobian, gradient, ForwardDiff # automatic differentiation
using LinearAlgebra # for the norm for instance
using Printf # to print iterations results

# method to compute gradient and Jacobian
∇(f::Function, x) = ForwardDiff.gradient(f, x)
Jac(f::Function, x) = ForwardDiff.jacobian(f, x)

# dev packages
using CTDescriptions
#
include("common/callbacks.jl")
include("common/default.jl")
include("common/exceptions.jl")
#
include("nlp.jl")
#
include("descent/structs.jl")
include("descent/solver.jl")
include("descent/main.jl")
#
export NLP, solve
export OptimisationProblem, OptimisationInit, OptimisationSolution
export UnconstrainedProblem
export DescentProblem, DescentInit, DescentSol
export OptimisationException, InconsistentArgument, IncorrectMethod
export OptimisationCallback, PrintCallback, StopCallback

end # module CommonSolveOptimisation
