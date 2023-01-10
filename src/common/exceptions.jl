# --------------------------------------------------------------------------------------------------
# General abstract type for exceptions
abstract type OptimisationException <: Exception end

# incorrect method
struct IncorrectMethod <: OptimisationException
    var::Symbol
end

"""
	Base.showerror(io::IO, e::IncorrectMethod)

TBW
"""
Base.showerror(io::IO, e::IncorrectMethod) = print(io, e.var, " is not an existing method")