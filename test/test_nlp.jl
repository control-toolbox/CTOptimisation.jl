# Test NLP function

f(x)  = 2*(x[1]+x[2]+x[3]-3)^2 + (x[1]-x[2])^2 + (x[2]-x[3])^2
∇f(x) = [4*(x[1]+x[2]+x[3]-3) + 2*(x[1]-x[2]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[1]-x[2]) + 2*(x[2]-x[3]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[2]-x[3])]

n=3

@testset "NLP function" begin
    nlp = NLP(f, gradient=∇f, dimension=n); @test typeof(nlp) == UnconstrainedProblem
    nlp = NLP(f, gradient=∇f); @test typeof(nlp) == UnconstrainedProblem
    nlp = NLP(f, dimension=n); @test typeof(nlp) == UnconstrainedProblem
    nlp = NLP(f); @test typeof(nlp) == UnconstrainedProblem
end

# Test solve function
nlp = NLP(f, gradient=∇f, dimension=n)

@testset "solve function" begin
    sol = solve(nlp, display=false); @test typeof(sol) == DescentSol
    @test_throws Exception solve(nlp, :algo_non_existant)
end