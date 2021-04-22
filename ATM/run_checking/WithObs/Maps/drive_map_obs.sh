#!/bin/bash -l
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

    # Start/end delimiters for initial conditions

        ystart=2011; yend=2018;  ystep=1
        mstart=1;    mend=12;    mstep=3
        dstart=1;    dend=15;     dstep=14

    # Name and location of experiment and obs (data as 35-day time series in netcdf)

        obs_root=/scratch2/NCEPDEV/climate/Lydia.B.Stefanova/ReferenceData/    # Location of OBS: changing it is not recommended
        exp_root=/scratch2/NCEPDEV/climate/Lydia.B.Stefanova/Models/           # Location of models 
        whereexp=$exp_root
        whereobs=$obs_root

        exp_old=ufs_p4
        exp_new=ufs_p5

        res=1p00

    # Other specitications


        nplots=3      # Valid choices are 9 or 3 or 1; 
                      # "9" plots full fields for obs, exp_old, exp_new AND bias for exp_old, exp_new AND  difference exp_new - exp_old
                      # "3" plots bias for exp_old, exp_new AND  difference exp_new - exp_old
                      # "1" plots difference exp_new - exp_old (and is therefore independent of the choice of reference obs)

        mapscript=map_compare_obs.sh    
        hardcopy=no                # Valid choices are yes no      
        domain=GlobalTropics       # Valid choices see [case "$domain" list] in mapping script
        domain=Global              # Valid choices see [case "$domain" list] in mapping script
        reference=cfsr             # Current valid choudes are era5 and cfsr; currently only used for tmp2m; if omitted, defaults to era5

      # NB: keep in mind that verifying obs for tmpsfc (OSTIA SST) are not valid for ice-covered areas because tmpsfc there is not sst
        declare -a varlist=("tmp2m" "tmpsfc" )  # Current valid choices for comparison with OBS are "tmpsfc" "prate" "ulwrftoa" "tmp2m" "t2min" "t2max" 
        declare -a seasonlist=("JJA" "AllAvailable")     # Valid choices are "DJF" "MAM" "JJA" "SON" "AllAvailable"

        for season in ${seasonlist[@]} ; do
            for varname in ${varlist[@]}; do
                day1=14; day2=28
                echo "using $mapscript $day1 to $day2 for $varname"
                bash $mapscript whereexp=$whereexp  whereobs=$whereobs varModel=$varname reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp_old nameModelB=$exp_new ystart=$ystart yend=$yend ystep=$ystep  mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep d1=`expr $day1 - 1` d2=`expr $day2 - 1`  nplots=$nplots

done
done

