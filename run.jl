#################################
# Run the simulations from here
#################################

# 1. Go to par.jl and change as needed
# 2. Go to src/initialConditions/defaultInitialConditions and change as needed
# 3. Change the name of the simulation in this file
# 4. Run the simulation from terminal. (julia run.jl)
# 5. Plot results from the scripts folder

#  `export JULIA_NUM_THREADS=2`

using Printf, LinearAlgebra, DelimitedFiles, SparseArrays, JLD2,
    AlgebraicMultigrid, StaticArrays, IterativeSolvers, FEMSparse
using Base.Threads
#  BLAS.set_num_threads(1)

include("$(@__DIR__)/par.jl")	    #	Set Parameters

#  P = setParameters(0e3,1)      # args = fault zone depth, resolution
P = setParameters(48e3,10)      # args = fault zone depth, resolution

include("$(@__DIR__)/src/dtevol.jl")
include("$(@__DIR__)/src/NRsearch_serial.jl")
include("$(@__DIR__)/src/otherFunctions_serial.jl")

include("$(@__DIR__)/main2.jl")

#  # Save output to file dynamically
#  file  = jldopen("$(@__DIR__)/data/test02.jld2", "w")

println(nthreads())
simulation_time = @elapsed @time main(P)

#  description = "homogeneous medium with high resolution"

# Save output to file

println("\n")

@info("Simulation Complete!");
