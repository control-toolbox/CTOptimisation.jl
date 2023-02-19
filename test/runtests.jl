# [test/runtests.jl]
using CTOptimization
using Test
using LinearAlgebra
using CTBase

# functions and types that are not exported
const make_descent_init    = CTOptimization.make_descent_init
const make_descent_problem = CTOptimization.make_descent_problem
const descent_solver       = CTOptimization.descent_solver
const DescentInit          = CTOptimization.DescentInit
const DescentProblem       = CTOptimization.DescentProblem
const DescentSolution      = CTOptimization.DescentSolution
const descent_read         = CTOptimization.descent_read

# Test scripts
@testset verbose = true showtiming = true "CTOptimization Solvers" begin
    for name in (
        "optimization",
        "descent"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end