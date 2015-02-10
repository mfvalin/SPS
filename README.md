# SPS
# surface only model
# environement variable storage_model MUST be defined

. ./.setenv.dot        # basic setup, create .exper_cour if needed
                       # needed to compile and run

rde mklink             # create links to compile sps
rde mkdep              # create Makefile and dependencies
make obj               # compile
make sps               # build executable
linkit                 # create links to run sps
sps.ksh                # run sps

