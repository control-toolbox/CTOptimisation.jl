module CommonSolveOptimisation

using ForwardDiff: jacobian, gradient, ForwardDiff # automatic differentiation
using LinearAlgebra # for the norm for instance
using Printf # to print iterations results

# method to compute gradient and Jacobian
∇(f::Function, x) = ForwardDiff.gradient(f, x)
Jac(f::Function, x) = ForwardDiff.jacobian(f, x)

# dev packages
using ControlToolboxTools
#
include("common/callbacks.jl")
include("common/default.jl")
include("common/exceptions.jl")
#
include("OptimisationProblem.jl")
include("Optimisationsolve.jl")
#
include("descent/structs.jl")
include("descent/solver.jl")
include("descent/interface.jl")
#
export solve
export OptimisationProblem, OptimisationInit, OptimisationSolution
export UnconstrainedProblem, UnconstrainedInit, UnconstrainedSolution
#export DescentProblem, DescentInit, DescentSolution
export OptimisationException, InconsistentArgument, IncorrectMethod
export OptimisationCallback, PrintCallback, StopCallback

end # module CommonSolveOptimisation
