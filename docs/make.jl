using Documenter
using CTOptimisation

makedocs(
    sitename = "CTOptimisation.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/CTOptimisation.jl.git",
    devbranch = "main"
)