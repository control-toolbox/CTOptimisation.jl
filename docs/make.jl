using Documenter
using CTOptimization

makedocs(
    sitename = "CTOptimization.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/CTOptimization.jl.git",
    devbranch = "main"
)