#
direction, line_search = descent_read((:gradient, :bissection, :tata))
@test direction === :gradient
@test line_search === :bissection

# problem and solution
f(x)  = 2*(x[1]+x[2]+x[3]-3)^2 + (x[1]-x[2])^2 + (x[2]-x[3])^2
∇f(x) = [4*(x[1]+x[2]+x[3]-3) + 2*(x[1]-x[2]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[1]-x[2]) + 2*(x[2]-x[3]),
         4*(x[1]+x[2]+x[3]-3) - 2*(x[2]-x[3])]

n=3

prob = OptimisationProblem(f, gradient=∇f, dimension=n)
x0  = [0.9; 0.9; 0.9]
x⁺  = [1; 1; 1]
sol = solve(prob, display=false)

# tolerances for the tests
atol_strong = 1e-8
atol_weak   = 1e-4

# test structs
@testset "make descent init" begin
    init = make_descent_init(prob, nothing) 
    @test typeof(init) == DescentInit
    @test init.x ≈ [0; 0; 0] atol=atol_strong

    init = make_descent_init(prob, x0)
    @test typeof(init) == DescentInit
    @test init.x ≈ x0 atol=atol_strong

    init = make_descent_init(prob, UnconstrainedInit(x0))
    @test typeof(init) == DescentInit
    @test init.x ≈ x0 atol=atol_strong

    init = make_descent_init(prob, sol)
    @test typeof(init) == DescentInit
    @test init.x ≈ x⁺ atol=atol_strong # compare to the solution
end

@testset "make descent problem" begin
    dp = make_descent_problem(prob); @test typeof(dp) == DescentProblem
end

# test solver
@testset "solve descent problem" begin

    # 
    struct DummyProblem <: OptimisationProblem
    end
    dummy_prob = DummyProblem()
    @test_throws InconsistentArgument solve(dummy_prob)

    #
    init = make_descent_init(prob, x0)
    dp   = make_descent_problem(prob)

    N = 100

    #
    common_args = (iterations=N, display=false)

    # basic
    sol = descent_solver(dp, init) # just for covering
    sol = descent_solver(dp, init; common_args...)
    @test typeof(sol) == DescentSolution
    @test sol.x ≈ x⁺ atol=atol_strong # compare to the solution

    # direction
    sol = descent_solver(dp, init, direction=:bfgs; common_args...)
    @test sol.x ≈ x⁺ atol=atol_strong # compare to the solution
    sol = descent_solver(dp, init, direction=:gradient; common_args...)
    @test sol.x ≈ x⁺ atol=atol_weak # compare to the solution
    @test_throws Exception descent_solver(dp, init, direction=:wrong; common_args...)

    # line search
    sol = descent_solver(dp, init, line_search=:backtracking; common_args...)
    @test sol.x ≈ x⁺ atol=atol_strong # compare to the solution
    sol = descent_solver(dp, init, line_search=:fixedstep; common_args...)
    @test sol.x ≈ x⁺ atol=atol_weak # compare to the solution
    sol = descent_solver(dp, init, line_search=:bissection; common_args...)
    @test sol.x ≈ x⁺ atol=atol_strong # compare to the solution
    @test_throws Exception descent_solver(dp, init, line_search=:wrong; common_args...)

    # iterations
    sol = descent_solver(dp, init, iterations=0, direction=:gradient, line_search=:fixedstep, display=false)
    @test sol.iterations == 0
    @test !sol.success
    @test sol.stopping == :iterations
    sol = descent_solver(dp, init, iterations=5, direction=:gradient, line_search=:fixedstep, display=false)
    @test sol.iterations == 5
    @test !sol.success
    @test sol.stopping == :iterations

    # step_length
    sol = descent_solver(dp, init, step_length=1.0; iterations=1, direction=:gradient, line_search=:fixedstep, display=false)
    @test norm(sol.x-init.x)/norm(∇f(init.x)) ≈ 1.0 atol=atol_strong

    # stopping criterion: optimality vs stagnation
    sol = descent_solver(dp, init, optimalityTolerance=1e-3, stagnationTolerance=0.0, absoluteTolerance=0.0, direction=:gradient; common_args...)
    @test sol.stopping == :optimality
    @test sol.success
    sol = descent_solver(dp, init, optimalityTolerance=0.0, stagnationTolerance=1e-3, absoluteTolerance=0.0, direction=:gradient; common_args...)
    @test sol.stopping == :stagnation
    @test sol.success

end