module CTOptimization

using LinearAlgebra # for the norm for instance
using Printf # to print iterations results
#
using CTBase

# method to compute gradient and Jacobian
∇(f::Function, x) = CTBase.ctgradient(f, x)
Jac(f::Function, x) = CTBase.ctjacobian(f, x)

#
include("default.jl")
#
include("problem.jl")
include("solve.jl")
#
include("descent/structs.jl")
include("descent/solver.jl")
include("descent/interface.jl")
#
export solve
export CTOptimizationProblem, CTOptimizationInit, CTOptimizationSolution
export UnconstrainedProblem, UnconstrainedInit, UnconstrainedSolution

end # module CTOptimization
