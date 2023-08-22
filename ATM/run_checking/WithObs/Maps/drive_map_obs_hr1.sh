#!/bin/bash -l
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
##SBATCH -q batch             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
##SBATCH -t 2:00:00               # -t specifies walltime in minutes; if in debug, cannot be more than 30
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

    # Start/end delimiters for initial conditions


startdate=20171203
enddate=20200830

    # Name and location of experiment and obs (data as 35-day time series in netcdf)

        obs_root=/scratch1/NCEPDEV/climate/Lydia.B.Stefanova/ReferenceData/    # Location of OBS: changing it is not recommended
        exp_root=/scratch1/NCEPDEV/climate/Lydia.B.Stefanova/Models/           # Location of models 
        whereexp=$exp_root
        whereobs=$obs_root

        exp_old=GFSv16
        exp_new=ufs_hr1

        exp_old=ufs_p7
        exp_new=ufs_p8

        res=1p00  # this is the only available resolution for bias comparisons

    # Other specitications

        hardcopy=yes              # Valid choices are yes no      
        hardcopy=no              # Valid choices are yes no     

        nplots=3      # Valid choices are 9 or 3 or 1; 
                      # "9" plots full fields for obs, exp_old, exp_new AND bias for exp_old, exp_new AND  difference exp_new - exp_old
                      # "3" plots bias for exp_old, exp_new AND  difference exp_new - exp_old
                      # "1" plots difference exp_new - exp_old (and is therefore independent of the choice of reference obs)

        mapscript=map_compare_obs_hr1.sh    
        #mapscript=map_compare_single.sh    

        domain=Global       # Valid choices see [case "$domain" list] in mapping script
        plotdomain=Global       # Valid choices see [case "$domain" list] in mapping script
        #domain=NAM      # Valid choices see [case "$domain" list] in mapping script
        #plotdomain=NAM       # Valid choices see [case "$domain" list] in mapping script
        reference=gefs12r          # for tmp2m, z500, u200, u850, the current valid choudes are era5, cfsr, gefs12r; if omitted, defaults to era5
        reference=era5          # for tmp2m, z500, u200, u850, the current valid choudes are era5, cfsr, gefs12r; if omitted, defaults to era5
                                   # the setting of 'reference' is ignored for other variables

      # NB: keep in mind that verifying obs for tmpsfc (OSTIA SST) are not valid for ice-covered areas because tmpsfc there is not sst

#  Current valid choices for comparison with OBS are "tmpsfc" "prate" "ulwrftoa" "tmp2m" "t2min" "t2max" 
 
#"z500" "cloudtot" "dswrf" "uswrf" "dlwrf" "ulwrf" 


        declare -a seasonlist=( "AllAvailable" )                    # Valid choices are "DJF" "MAM" "JJA" "SON" "AllAvailable"
        declare -a seasonlist=( "DJF" "JJA" )                    # Valid choices are "DJF" "MAM" "JJA" "SON" "AllAvailable"

        declare -a varlist=("sst" "u10" "u850" "u200" "ustar" "tmp2m" "t2min" "t2max" "prate" "ulwrftoa" "cloudtot" "dswrf" "uswrf" "dlwrf" "ulwrf" "ulwrftoa" "z500" "CAPE")
        declare -a varlist=("sst" "u10" "ustar" "tmp2m" "t2min" "t2max" "prate" "ulwrftoa" "cloudtot" "dswrf" "uswrf" "dlwrf" "ulwrf" "ulwrftoa")
        declare -a varlist=("cloudtot" "t2min" "t2max" "ulwrf" "dlwrf" "uswrf" "dswrf" )
        declare -a varlist=("ulwrftoa")
        declare -a varlist=("cloudtot" "t2min" "t2max" "ulwrf" "dlwrf" "uswrf" "dswrf" "prate" "ulwrftoa" )
        declare -a varlist=("t2min" "t2max")

        for season in ${seasonlist[@]} ; do
            for varname in ${varlist[@]}; do

                day1=1; day2=16
                echo "using $mapscript $day1 to $day2 for $varname"
                bash $mapscript whereexp=$whereexp  whereobs=$whereobs varModel=$varname reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp_old nameModelB=$exp_new startdate=$startdate enddate=$enddate  d1=`expr $day1 - 1` d2=`expr $day2 - 1`  nplots=$nplots plotdomain=$plotdomain

                #day1=8; day2=14
                #echo "using $mapscript $day1 to $day2 for $varname"
                #bash $mapscript whereexp=$whereexp  whereobs=$whereobs varModel=$varname reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp_old nameModelB=$exp_new startdate=$startdate enddate=$enddate  d1=`expr $day1 - 1` d2=`expr $day2 - 1`  nplots=$nplots plotdomain=$plotdomain

done
 
done

