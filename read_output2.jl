using DelimitedFiles

include("post/earthquake_cycles.jl")
include("post/paleoseismic_plots.jl")
include("post/cumulative_slip.jl")

# path to save files
global path = "$(@__DIR__)/plots/vw_test08/"

global out_path = "$(@__DIR__)/data/save_dynamic01/"

# Read data
event_time = readdlm(string(out_path, "event_time.out"), header=false)
tStart = event_time[:,1]
tEnd = event_time[:,2]
hypo = event_time[:,3]

event_stress = readdlm(string(out_path, "event_stress.out"), header=false)
indx = Int(length(event_stress[1,:])/2)
taubefore = event_stress[:,1:indx]
tauafter = event_stress[:,indx+1:end]

delfafter = readdlm(string(out_path, "coseismic_slip.out"), header=false)
#  seas = readdlm(string(out_path, "cumulative_slip.out"), header=false)
stress = readdlm(string(out_path, "stress.out"), header=false)
slip = readdlm(string(out_path, "slip.out"), header=false)
sliprate = readdlm(string(out_path, "sliprate.out"), header=false)

params = readdlm(string(out_path, "params.out"), header=false)

time_vel = readdlm(string(out_path, "time_velocity.out"), header=false)
t = time_vel[:,1]
Vfmax = time_vel[:,2]
Vsurface = time_vel[:,3]
alphaa = time_vel[:,4]


rho1 = 2670
vs1 = 3464
rho2 = 2500
vs2 = 0.6*vs1
mu = rho2*vs2^2

delfsec, delfyr = cumSlip(slip, sliprate, t)

#  start_index = get_index(seismic_stress, taubefore)
#  stressdrops = taubefore .- tauafter

#  Mw, del_sigma, fault_slip, rupture_len =
        #  moment_magnitude_new(mu, P1, P3.FltX, delfafter, stressdrops, time_);
