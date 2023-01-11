# [test/runtests.jl]
using CommonSolveOptimisation
#using CTDescriptions # todo: la compilation ne fonctionne pas si je fais ce using
using Test
using LinearAlgebra

# Test scripts
@testset verbose = true showtiming = true "Optimisation Solvers" begin
    for name in (
        "callbacks", 
        "exceptions",
        "nlp",
        "descent"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end