module CommonSolveOptimisation

using ForwardDiff: jacobian, gradient, ForwardDiff # automatic differentiation
using LinearAlgebra # for the norm for instance
using Printf # to print iterations results

# method to compute gradient and Jacobian
∇(f::Function, x) = ForwardDiff.gradient(f, x)
Jac(f::Function, x) = ForwardDiff.jacobian(f, x)

# dev packages
using ControlToolboxTools
const ControlToolboxCallbacks = Tuple{Vararg{ControlToolboxCallback}}
#
include("./default.jl")
#
include("OptimisationProblem.jl")
include("OptimisationSolve.jl")
#
include("descent/structs.jl")
include("descent/solver.jl")
include("descent/interface.jl")
#
export solve
export OptimisationProblem, OptimisationInit, OptimisationSolution
export UnconstrainedProblem, UnconstrainedInit, UnconstrainedSolution

end # module CommonSolveOptimisation
