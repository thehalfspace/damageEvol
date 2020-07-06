using JLD2

include("output.jl")

include("post/earthquake_cycles.jl")
#  include("post/basic_plotting.jl")
#  include("post/py_plot.jl")
#  include("post/cumulative_slip.jl")

# path to save files
global path = "$(@__DIR__)/plots/vw_test08/"
#  global path = "$(@__DIR__)/plots/par_study/A20_H01_P0/"

file = jldopen("$(@__DIR__)/data/vw_test/vw_test_08.jld2", "r")
#  file = jldopen("$(@__DIR__)/data/par_study/A20_H01_P0.jld2", "r")

O = file["O"]
seismic_stress = O.seismic_stress  
seismic_slipvel = O.seismic_slipvel
seismic_slip = O.seismic_slip     
index_eq = O.index_eq          
is_stress = O.is_stress        
is_slipvel = O.is_slipvel      
is_slip = O.is_slip        
dSeis = O.dSeis          
vSeis = O.vSeis          
aSeis = O.aSeis           
tStart = O.tStart         
tEnd = O.tEnd             
taubefore = O.taubefore        
tauafter = O.tauafter        
delfafter = O.delfafter        
hypo = O.hypo           
time_ = O.time_          
Vfmax = O.Vfmax           
P1 = file["P1"]
P2 = file["P2"]
P3 = file["P3"]
P4 = file["P4"]
alphaa = file["alphaa"]

close(file)

# time-index of start of rupture
start_index = get_index(seismic_stress, taubefore)
stressdrops = taubefore .- tauafter

rho1 = 2670
vs1 = 3464
rho2 = 2500
vs2 = 0.6*vs1
mu = rho2*vs2^2

Mw, del_sigma, fault_slip, rupture_len = moment_magnitude_new(mu, P1, P3.FltX, delfafter, stressdrops, time_);


# Temporary
