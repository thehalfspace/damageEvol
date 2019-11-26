# Plot damage multiplier
function plot_alpha(alphaa, time_)
    """Input parameters
        alphaa: damage multiplier parameter
        time_: time in years"""

    y = alphaa#[alphaa .< 1.0 ]
    x = time_#[alphaa .< 1.0]

    plt = plot(framestyle=[:box], size=(600,400), grid=false, dpi=200)

    plot!(x, y, lc=:darkblue, label=:"",lw=0.5)
    scatter!(x, y, mc=:darkblue, ms=5, label=:"")

    xaxis!(L"Time\ (yr)") #xminorgrid=true
    #  xticks!(0:100:maximum(time_));
    yaxis!(L"Damage Multiplier ($\alpha_D$)")
    #  savefig(string(path, "Vfmax.svg"))
    savefig(string(path, "alpha.pdf"))

    plt
end

# Plot recurrence
function plot_reccurrence(tStart, yr2sec)
    plt = plot(framestyle=[:box :grid])
    
    len = length(tStart) - 1

    scatter!(range(1,len-1,step=1), diff(tStart./P1.yr2sec)[2:end], ms=10, label=:"")
    xaxis!("Intervent number"); #xlims!(1,7)
    yaxis!("Recurrence Interval (yr)"); #ylims!(100,120)

    #  savefig(string(path, "recint.png"))
    savefig(string(path, "recint.pdf"))

    plt
end
