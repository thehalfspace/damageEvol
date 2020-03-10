####
#   Damage and healing parameter function in time
####

using JLD2
using Plots
using LaTeXStrings
pyplot()

function healing2(t,tStart,dam)
    #=
        hmax: the max amount of healing
        r: healing rate (0.05 => 80 years to heal completely)
                        (0.8 => 8 years to heal completely)
    =#

    hmax = 0.1
    r = 0.1

    hmax*(1 .- exp.(-r*(t .- tStart))) .+ dam
end

function αD(t, tStart, dam)
    # First working version of healing
    aa = 0.12*(log10.(0.5*(t.- tStart) .+ 1.0)./log10.(1.0e3 .- (t.-tStart))) .+ dam

    aa
end

function aa_orig(t,tStart,dam)
        0.12*(log10.((t.- tStart) .+ 1.0)./log10.(1.0e3 .- (t.-tStart))) .+ dam
end


tStart1 = 0.0
t1 = [0.001, 0.002, 0.04 ,0.1, 0.5, 0.7, 0.8, 0.9, 1, 10, 12, 13, 14, 15, 20, 30, 50]
tStart2 = 50.0
t2 = [50.001, 50.002, 50.3, 50.4, 50.6, 50.9, 52, 54, 59, 62, 64, 80]

alph1 = αD(t1, tStart1, 0.0)

aa = healing2(t1, tStart1,0.0)
aa2 = healing2(t2, tStart2,0.0)

function graph_alpha(alph, aa, t)

    plt = plot(framestyle=[:box], grid=false,dpi=200)

    plot!(t, aa, lc=:darkgreen, label=:"",lw=2)
    #  plot!(t, alph, lc=:darkblue, label=:"",lw=2)

    xaxis!(L"Time\ (yr)") #xminorgrid=true
    yaxis!(L"\alpha_D")
    plt

end
