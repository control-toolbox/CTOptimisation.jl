# Test CTOptimizationProblem function

f(x)  = 2*(x[1]+x[2]+x[3]-3)^2 + (x[1]-x[2])^2 + (x[2]-x[3])^2
∇f(x) = [4*(x[1]+x[2]+x[3]-3) + 2*(x[1]-x[2]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[1]-x[2]) + 2*(x[2]-x[3]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[2]-x[3])]

n=3

@testset "CTOptimizationProblem function" begin
    prob = CTOptimizationProblem(f, gradient=∇f, dimension=n); @test typeof(prob) == UnconstrainedProblem
    prob = CTOptimizationProblem(f, gradient=∇f); @test typeof(prob) == UnconstrainedProblem
    prob = CTOptimizationProblem(f, dimension=n); @test typeof(prob) == UnconstrainedProblem
    prob = CTOptimizationProblem(f); @test typeof(prob) == UnconstrainedProblem
end

# Test CTOptimizationSolve function
prob = CTOptimizationProblem(f, gradient=∇f, dimension=n)

@testset "solve function" begin
    sol = solve(prob, display=false); @test typeof(sol) == UnconstrainedSolution
    @test_throws Exception solve(prob, :algo_non_existant)
end