using CairoMakie

let
    x = range(0, 4π; length = 400)
    fig = Figure(size = (800, 450))
    ax = Axis(fig[1, 1]; title = "CairoMakie demo", xlabel = "x", ylabel = "y")
    lines!(ax, x, sin.(x); label = "sin(x)")
    lines!(ax, x, cos.(x); label = "cos(x)")
    lines!(ax, x, exp.(-x ./ 4) .* sin.(2x); label = "e^(-x/4) sin(2x)")
    axislegend(ax; position = :rt)

    out = joinpath(@__DIR__, "cairomakie_demo.png")
    save(out, fig; px_per_unit = 2)
    out
end
