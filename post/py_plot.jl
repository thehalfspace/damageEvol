#########################################################
##
##  Plotting templates using Matplotlib and PyPlot
##
#########################################################

using PyPlot
using LaTeXStrings

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
    plt.rc("grid", linestyle="--", color="black", alpha=0.5)
    plt.grid("True")
    
    show()


    figname = string(path, "Vfmax.png")
    fig.savefig(figname, dpi = 300)
end


# Plot Alphaa
function alphaaPlot(alphaa, time_, yr2sec)

    #  Vfmax = maximum(SlipVel, dims = 1)[:]
    
    fig = PyPlot.figure(figsize=(8,6), dpi = 300)
    ax = fig.add_subplot(111)
    
    plt.rc("font",size=12)

    ax.plot(time_./yr2sec, alphaa, lw = 1)
    ax.set_xlabel("Time (years)")
    ax.set_ylabel("Shear Modulus Contrast (%)")
    #  ax.set_title("Max. slip rate on fault")
    #  ax.get_yaxis().set_tick_params(which="both", direction="in")
    #  ax.get_xaxis().set_tick_params(which="both", direction="in")
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
