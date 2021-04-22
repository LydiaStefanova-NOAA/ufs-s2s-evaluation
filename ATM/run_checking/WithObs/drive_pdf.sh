#!/bin/bash -l
#SBATCH -A fv3-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30
#
#
# This is a tiny little package that compares two sets of (exp1 and exp2) for a chosen variable, domain, season
# top directory with preprocessed files 

    whereexp=$noscrub/Models
    whereobs=$noscrub/ReferenceData
    
    hardcopy=yes                        # yes | no

    ystart=2011; yend=2018
    mstart=1; mend=12; mstep=1
    dstart=1; dend=15; dstep=100

    exp1=ufs_p5
    exp2=ufs_p6
    reference=cfsr

# The scripts are prepared to handle variables on the list below 
    oknames=(land tmpsfc tmp2m t2min t2max ulwrftoa dlwrf dswrf ulwrf uswrf prate pwat icetk icec cloudbdry cloudlow cloudmid cloudhi snow weasd snod lhtfl shtfl pres u10 v10 uflx vflx )

 domain=Global20 
 #for season in MAM JJA SON DJF AllAvailable ; do
 for domain in Maritime ; do #Nino34 GlobalTropics Global ; do
 for season in AllAvailable; do
     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=z500 reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=u850 reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=u200 reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
#     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=tmp2m reference=$reference domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
#     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=ulwrftoa domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
#     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=tmpsfc domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=oceanonly
#     bash pdf.sh whereexp=$whereexp whereobs=$whereobs varModel=prate domain=$domain hardcopy=$hardcopy season=$season nameModelA=$exp1 nameModelB=$exp2  ystart=$ystart yend=$yend mstart=$mstart mend=$mend mstep=$mstep dstart=$dstart dend=$dend dstep=$dstep mask=nomask
 done
 done


