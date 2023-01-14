# [test/runtests.jl]
using CommonSolveOptimisation
using Test
using LinearAlgebra
using ControlToolboxTools

# functions and types that are not exported
const make_descent_init    = CommonSolveOptimisation.make_descent_init
const make_descent_problem = CommonSolveOptimisation.make_descent_problem
const descent_solver       = CommonSolveOptimisation.descent_solver
const DescentInit          = CommonSolveOptimisation.DescentInit
const DescentProblem       = CommonSolveOptimisation.DescentProblem
const DescentSolution      = CommonSolveOptimisation.DescentSolution
const descent_read         = CommonSolveOptimisation.descent_read

# Test scripts
@testset verbose = true showtiming = true "Optimisation Solvers" begin
    for name in (
        "optimisation",
        "descent"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end