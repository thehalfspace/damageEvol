function plot_alpha(alphaa, time_)
    """Input parameters
        alphaa: damage multiplier parameter
        time_: time in years"""

    plt = plot(framestyle=[:box], size=(600,400), grid=false, dpi=200)

    plot!(time_, alphaa, lc=:darkblue, label=:"",lw=0.5)
    scatter!(time_, alphaa, mc=:darkblue, label=:"",lw=0.5)

    xaxis!(L"Time\ (yr)") #xminorgrid=true
    #  xticks!(0:100:maximum(time_));
    yaxis!(L"Damage Multiplier ($\alpha_D$)")
    #  savefig(string(path, "Vfmax.svg"))
    savefig(string(path, "alpha.pdf"))

    plt
end
