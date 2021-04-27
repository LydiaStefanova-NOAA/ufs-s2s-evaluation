#!/bin/bash -l
#SBATCH -A fv3-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of yesdes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

module load intel
module load ncl

# This is a tiny little package that compares two sets of (exp1 and exp2) for a chosen variable, domain, season
# The data is expected to be in /scratch3/NCEPDEV/marine/noscrub/Lydia.B.Stefanova/Models/$exp/1p00/dailymean/          
    
    hardcopy=yes           # yes | no
hardcopy=no

    exp1=ufs_orion_ctl
    exp2=ufs_orion_nsst


    
    whereexp=$noscrub/Models/
    res=1p00
    nplots=3


# The script is  prepared to handle variables on the list below 
    oknames=(land tmpsfc tmp2m t2min t2max ulwrftoa dlwrf dswrf ulwrf uswrf prate pwat icetk icec cloudbdry cloudlow cloudmid cloudhi snow weasd snod lhtfl shtfl pres u10 v10 uflx vflx soilm02m sfcr speed spfh2m u850 v850 z500 u200 v200 hpbl cprate TAminusTS) 

       #for varname in tmp2m cloudbdry cloudmid cloudhi ; do
       for varname in cloudhi ; do

        case "${oknames[@]}" in 
                *"$varname"*)  ;; 
                *)
             echo "Exiting. To continue, please correct: unknown variable ---> $varname <---"
             exit
        esac
       #for domain in NH ; do
       #     for season in DJF  ; do
       #         echo "Attempting $domain $season $varname "
       #         bash  map_compare_noobs_polar.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=0 d2=34 whereexp=$whereexp
       #     done
       # done
        for domain in Global  ; do    
            #for season in AllAvailable MAM JJA SON DJF; do
            #for season in JJA  DJF ; do
             for season in AllAvailable ; do
                echo "Attempting $domain $season $varname "
                bash  map_compare_noobs.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=0 d2=0 whereexp=$whereexp nplots=$nplots res=$res
                bash  map_compare_noobs.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=1 d2=6 whereexp=$whereexp nplots=$nplots res=$res 
                #bash  map_compare_noobs.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=14 d2=20 whereexp=$whereexp nplots=$nplots res=$res 
                #bash  map_compare_noobs_polar.sh varModel=$varname domain=NH hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=14 d2=27 whereexp=$whereexp nplots=$nplots res=$res 
                bash  map_compare_noobs.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=14 d2=27 whereexp=$whereexp nplots=$nplots res=$res 
                #bash  map_compare_noobs.sh varModel=$varname domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2 d1=0 d2=34 whereexp=$whereexp nplots=$nplots res=$res 
            done
        done
    done

