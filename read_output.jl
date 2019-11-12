using JLD2

include("output.jl")

include("post/earthquake_cycles.jl")
include("post/basic_plotting.jl")
#  include("post/plots.jl")
#  include("post/cumulative_slip.jl")

# path to save files
global path = "$(@__DIR__)/plots/test02/"

file = jldopen("$(@__DIR__)/data/test02.jld2", "r")

#  O = file["O"]
seismic_stress = file["seismic_stress"]  
seismic_slipvel = file["seismic_slipvel"]
seismic_slip = file["seismic_slip"]     
index_eq = file["index_eq"]          
is_stress = file["is_stress"]        
is_slipvel = file["is_slipvel"]      
is_slip = file["is_slip"]        
dSeis = file["dSeis"]          
vSeis = file["vSeis"]          
aSeis = file["aSeis"]           
tStart = file["tStart"]         
tEnd = file["tEnd"]             
taubefore = file["taubefore"]        
tauafter = file["tauafter"]        
delfafter = file["delfafter"]        
hypo = file["hypo"]           
time_ = file["time_"]          
Vfmax = file["Vfmax"]           
P1 = file["P1"]
P2 = file["P2"]
P3 = file["P3"]
P4 = file["P4"]

close(file)

# time-index of start of rupture
start_index = get_index(seismic_stress, taubefore)
stressdrops = taubefore .- tauafter

rho1 = 2670
vs1 = 3464
rho2 = 2500
vs2 = 0.6*vs1
mu = rho2*vs2^2

Mw, del_sigma, fault_slip = moment_magnitude_new(mu, P1, P3.FltX, delfafter, stressdrops, time_);


# Temporary
function reccurrence(tStart, yr2sec, id)
    plot(framestyle=[:box :grid])

    scatter!(range(1,6,step=1), diff(tStart[id]./P1.yr2sec), label=:"")
    xaxis!("Intervent number"); xlims!(1,7)
    yaxis!("Recurrence Interval (yr)"); ylims!(100,120)

    savefig(string(path, "recint.png"))
    savefig(string(path, "recint.pdf"))

end
