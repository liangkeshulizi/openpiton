#!/bin/bash

# This script should be run from the build directory!

# environment var
export PITON_ROOT=~/proj/openpiton/openpiton
source $PITON_ROOT/piton/piton_settings.bash

# perl
export PERL_LOCAL_LIB_ROOT="~/proj/myperl"
export PERL5LIB="$PERL_LOCAL_LIB_ROOT/lib/perl5:$PERL5LIB"
export PATH="$PERL_LOCAL_LIB_ROOT/bin:$PATH"
eval "$(perl -I$PERL_LOCAL_LIB_ROOT/lib/perl5 -Mlocal::lib=$PERL_LOCAL_LIB_ROOT)"

# simulator & other env
module load lic
module load cmake gcc make git tmux anaconda
module load iverilog vcs verdi

# vcs flag
function vcs() {
    command vcs -full64 "$@"
}

# conda env
source /hpc/Edatools/opensource/anaconda3/etc/profile.d/conda.sh
conda activate ~/.conda/envs/py2_env/

# ========================= main script ========================= #

# # Synthesis for U250 FPGA
# protosyn -b alveou250

# # Run Core Simulation
sims -sys=manycore -x_tiles=1 -y_tiles=1 -vcs_run princeton-test-test.s

# # Run Unit Test
# sims -sys=dmbr_test -vcs_build
