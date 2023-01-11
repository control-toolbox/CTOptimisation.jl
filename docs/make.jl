using Documenter
using CommonSolveOptimisation

makedocs(
    sitename = "CommonSolveOptimisation.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/CommonSolveOptimisation.jl.git",
    devbranch = "main"
)