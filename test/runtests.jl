# [test/runtests.jl]
using CTOptimisation
using Test

# Test scripts

# [test/foo_test.jl]
@testset "Foo test" begin
    v = CTOptimisation.foo(10,5)
    @test v == 10+5
    @test typeof(v) == Int
    v = CTOptimisation.foo(10.0, 5)
    @test v == 10.0+5
    @test typeof(v) == Float64
end