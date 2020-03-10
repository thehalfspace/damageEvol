#############################
# PLOT SLIP AT VARIOUS DEPTHS 
#############################

function plot_trench_slip(delfsec, delf5yr, FltX)
    """Input parameters:
        delfsec: slip contours every 0.5 seconds during
        the seismic period

        delf5yr: slip contours every 2 years during
        the interseismic period

        FltX: Location of nodes on the fault"""


    plt = plot(framestyle=[:box],grid=false, size=(600,300), dpi=300)

    plot!(delfsec[end-0,:], lc=:peru, label=:"0 m depth", lw=2)
    plot!(delfsec[end-5,:], lc=:steelblue, label=:"160 m depth", lw=2)
    plot!(delfsec[end-10,:], lc=:green, label=:"320 m depth", lw=2)
    plot!(delfsec[end-20,:], lc=:black, label=:"640 m depth", lw=2)
    plot!(delfsec[1001,:], lc=:crimson, label=:"8 km depth", lw=2)
    plot!(delfsec[951,:], lc=:deepskyblue, label=:"10 km depth", lw=2)

    xaxis!(L"Timestep"); #xlims!(10,30); #xticks!(-1:0.2:1)
    yaxis!(L"Accumulated Slip\ (m)"); #yticks!(0:0.1:1)
    savefig(string(path, "trench_slip.png"))
    plt
end
