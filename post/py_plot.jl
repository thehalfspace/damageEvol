#########################################################
##
##  Plotting templates using Matplotlib and PyPlot
##
#########################################################

using PyPlot
using StatsBase
using LaTeXStrings
using PyCall

# Plot Vfmax
function VfmaxPlot(Vfmax, time_, yr2sec)

    #  Vfmax = maximum(SlipVel, dims = 1)[:]
    
    fig = PyPlot.figure(figsize=(8,6), dpi = 300)
    ax = fig.add_subplot(111)
    
    plt.rc("font",size=12)
    ax.plot(time_./yr2sec, Vfmax, lw = 1)
    ax.set_xlabel("Time (years)")
    ax.set_ylabel("Max. Slip rate (m/s)")
    ax.set_title("Max. slip rate on fault")
    ax.set_yscale("log")
    ax.get_yaxis().set_tick_params(which="both", direction="in")
    ax.get_xaxis().set_tick_params(which="both", direction="in")
    #  plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    #  plt.grid("True")
    
    show()


    figname = string(path, "Vfmax.png")
    fig.savefig(figname, dpi = 300)
end

# Plot slip vs event number
function slipPlot(delfafter, FltX, Mw, tStart)

    indx_10 = findall(abs.(FltX) .<= 10e3)[1]
    
    fig = PyPlot.figure(figsize=(1.5,8), dpi = 300)
    ax = fig.add_subplot(111)

    xaxis = tStart[Mw .>4.8]   #collect(1:length(delfafter[1,:]))

    offset = 4
    plt.rc("font",size=3)
    #ax.barh(xaxis.-offset, delfafter[end-1,:], label="At trench: 60 m depth", height=8)
    #ax.barh(xaxis.+offset, delfafter[631,:], label="At 6 km depth", height=8)
    
    ax.barh(xaxis, Mw[Mw .> 4.8], height=8, align="center"); ax.set_xlim([5,6.4])
    
    ax.set_xlabel("Magnitude")
    #ax.set_xlabel("Coseismic slip (m)")
    ax.set_ylabel("Time (yr)")
    ax.get_yaxis().set_tick_params(which="both", direction="in")
    ax.get_xaxis().set_tick_params(which="both", direction="in")
    ax.set_yticks(round.(xaxis, digits = 0))
    ax.invert_yaxis()
    #  plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    #  plt.grid("True")
    #plt.legend()
    
    show()


    figname = string(path, "mw2_time.png")
    fig.savefig(figname, dpi = 300)
end

# Plot Alphaa
function alphaaPlot(alphaa, time_, yr2sec)

    #  Vfmax = maximum(SlipVel, dims = 1)[:]
    
    fig = PyPlot.figure(figsize=(8,2), dpi = 300)
    ax = fig.add_subplot(111)
    
    plt.rc("font",size=8)

    ax.plot(time_./yr2sec, alphaa, lw = 1)
    ax.set_xlabel("Time (years)")
    ax.set_ylabel("Shear Modulus Contrast (%)")
    ax.get_yaxis().set_tick_params(which="both", direction="in")
    ax.get_xaxis().set_tick_params(which="both", direction="in")
    #  plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    #  plt.grid("True")
    
    show()


    figname = string(path, "alphaa.png")
    fig.savefig(figname, dpi = 300)
end

# Plot recurrence
function recurrencePlot(tStart, Mw, yr2sec)

    #  Vfmax = maximum(SlipVel, dims = 1)[:]
    
    rec2 = diff(tStart)./yr2sec
    rec = rec2[rec2 .> 0.1]
    xa = collect(1:length(rec))
    Mw = Mw[2:end]

    Mw2 = Mw[rec2 .> 0.1]

    fig = PyPlot.figure(figsize=(8,6), dpi = 300)
    ax = fig.add_subplot(111)
    
    plt.rc("font",size=12)

    ax.scatter(xa, rec, s=Mw.^2)
    ax.set_xlabel("Interevent Number")
    ax.set_ylabel("Reccurence Interval (yr)")
    #  ax.set_title("Max. slip rate on fault")
    #  ax.get_yaxis().set_tick_params(which="both", direction="in")
    #  ax.get_xaxis().set_tick_params(which="both", direction="in")
    #  plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    #  plt.grid("True")
    
    show()


    figname = string(path, "recurrence.png")
    fig.savefig(figname, dpi = 300)
end

# Plot cumulative slip
function cumSlipPlot(delfsec, delf5yr, FltX)
    
    FZ = -8

    indx = findall(abs.(FltX) .<= 18e3)[1]

    delfsec2 = delfsec[indx:end, :]

    fig = PyPlot.figure(figsize=(10,7), dpi=300)
    ax = fig.add_subplot(111)
    plt.rc("font",size=12)

    ax.plot(delf5yr, -FltX/1e3, color="royalblue", lw=0.5, alpha=1.0)
    ax.plot(delfsec2, -FltX[indx:end]/1e3, "-", color="chocolate", lw=0.5, alpha=1.0)
    ax.set_xlabel("Accumulated Slip (m)")
    ax.set_ylabel("Depth (km)")
    ax.set_ylim([0,24])
    #  ax.set_xlim([1,20])
    
    ax.invert_yaxis()
    #  ax.get_yaxis().set_tick_params(which="both", direction="in")
    #  ax.get_xaxis().set_tick_params(which="both", direction="in")
    #  plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    
    show()
    
    figname = string(path, "cumslip.png")
    fig.savefig(figname, dpi = 300)

end

function MwPlot(Mw)

    hist = fit(Histogram, Mw, nbins = 15)

    # Cumulative
    cum = cumsum(hist.weights[end:-1:1])[end:-1:1]

    fig = PyPlot.figure(figsize=(8,7))
    ax = fig.add_subplot(111)
    plt.rc("font",size=12)

    #  ax.plot](hist.edges[1][1:end-1], hist.weights, ".", label="Non-cumulative")
    ax.plot(hist.edges[1][1:end-1], cum, ".", markersize=20) #, label="Cumulative")
    ax.set_xlabel("Moment Magnitude (Mw)")
    ax.set_ylabel("Number of Earthquakes")
    ax.set_yscale("log")
    show()

    figname = string(path, "mfd.png")
    fig.savefig(figname, dpi = 300)
end


## Plot paleoseismic record (Depth vs event no)
function paleoRecordPlot(FltX, Mw, delfafter, tStart, yr2sec)
    """
        Parameters should be scaled with Mw
    """

    depth = -FltX./1e3
    coseismic_slip = delfafter  #[:,Mw .> 4.6] 
    evno = length(Mw[Mw .> 4.6])
    
    x_axis = tStart./yr2sec

    sampling_depth = [0, 2, 4, 6, 8, 10]
    sampling_index = Int.(zeros(length(sampling_depth)))

    for i=1:length(sampling_depth)
        sampling_index[i] = findall(depth .> sampling_depth[i])[end]
    end

    fig = PyPlot.figure(figsize=(12,2), dpi = 300)
    ax = fig.add_subplot(111)
    
    plt.rc("font",size=4)

    for i = 1:length(sampling_depth)
        _size = coseismic_slip[sampling_index[i],:]
        ax.scatter(x_axis, sampling_depth[i]*ones(evno), color="k", s = 20*_size.^2)
    end
    ax.set_xlabel("Time (yr)")
    ax.set_ylabel("Depth (km)")
    ax.set_xticks(round.(x_axis, digits = 0))
    ax.invert_yaxis()
    ax.get_yaxis().set_tick_params(which="both", direction="in")
    ax.get_xaxis().set_tick_params(which="both", direction="in")
    plt.rc("grid", linestyle="--", color="black", alpha=0.3)
    plt.grid("True", axis="x")
    
    show()
    figname = string(path, "paleo_record.png")
    fig.savefig(figname, dpi = 300)
end

# spatiotemporal imshow
function sptempPlot(seismic_slipvel2, FltX)
    
    indx = findall(abs.(FltX) .<= 18e3)[1]
    value = seismic_slipvel2[indx:end,:]
    
    depth = -FltX[indx:end]./1e3


    fig = PyPlot.figure(figsize=(7,6), dpi=100)
    plt.rc("font",size=12)
    ax = fig.add_subplot(111)

    c = ax.imshow(value, cmap="viridis", aspect="auto", 
                  norm=matplotlib.colors.LogNorm(vmin=1e-2, vmax=1e0), 
                         interpolation="bicubic",
                         extent=[0,length(seismic_slipvel2[1,:])/10, 0,18])

    #   ax.set_yticks(ax.get_yticks()[1:2:end])
    #   ax.set_xticks(ax.get_yticks()[1:2:end])

    #   ax.get_yaxis().set_tick_params(which="both", direction="in")
    #   ax.get_xaxis().set_tick_params(which="both", direction="in")
    
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Depth (km)")

    ax.invert_yaxis()
    cbar = fig.colorbar(c)
    #   cbar.set_ticks(cbar.get_ticks()[1:2:end])

    
    show()
    figname = string(path, "spatiotemporal.png")
    fig.savefig(figname, dpi = 300)
end


# Spatiotemporal Slip Rate evolution
function spatiotemporalPlot(seismic_sliprate, FltX)
    
    indx = findall(abs.(FltX) .<= 18e3)[1]
    value = seismic_slipvel[indx:end,:]
    
    depth = -FltX[indx:end]./1e3

    x = range(0, length(value[1,:])/1, length=length(value[1,:]))

    fig = PyPlot.figure(figsize=(7,6), dpi=100)
    ax = fig.add_subplot(111)

    c = ax.pcolormesh(x, depth[end:-1:1], value, vmin=0, vmax=1, 
                      cmap="inferno")
    ax.set_yticks(ax.get_yticks()[1:2:end])
    ax.set_xticks(ax.get_yticks()[1:2:end])

    ax.get_yaxis().set_tick_params(which="both", direction="in")
    ax.get_xaxis().set_tick_params(which="both", direction="in")

    ax.invert_yaxis()
    cbar = fig.colorbar(c)
    cbar.set_ticks(cbar.get_ticks()[1:2:end])
    
    show()
    figname = string(path, "spatiotemporal.png")
    fig.savefig(figname, dpi = 300)


end
