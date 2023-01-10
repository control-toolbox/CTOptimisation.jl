module CTOptimisation

using ForwardDiff: jacobian, gradient, ForwardDiff # automatic differentiation
using LinearAlgebra # for the norm for instance
using Printf # to print iterations results

# method to compute gradient and Jacobian
∇(f::Function, x) = ForwardDiff.gradient(f, x)
Jac(f::Function, x) = ForwardDiff.jacobian(f, x)

# dev packages
using CTDescriptions
#
include("nlp.jl")
#
include("common/callbacks.jl")
include("common/default.jl")
include("common/exceptions.jl")
#
include("descent/main.jl")
include("descent/solver.jl")
include("descent/structs.jl")
#
#export 

end # module CTOptimisation
