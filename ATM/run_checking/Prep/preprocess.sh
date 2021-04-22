#!/bin/bash -l               
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

module load intel
module load nco
module load cdo
module load wgrib2


for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)

    case "$KEY" in
            exp)         exp=${VALUE} ;;
            wherefrom)   wherefrom=${VALUE} ;;
            whereto)     whereto=${VALUE} ;;
            varname)     varname=${VALUE} ;;
            res)         res=${VALUE} ;;
            ystart)      ystart=${VALUE} ;;
            yend)        yend=${VALUE} ;;
            ystep)       ystep=${VALUE} ;;
            mstart)      mstart=${VALUE} ;;
            mend)        mend=${VALUE} ;;
            mstep)       mstep=${VALUE} ;;
            dstart)      dstart=${VALUE} ;;
            dend)        dend=${VALUE} ;;
            dstep)       dstep=${VALUE} ;;
            *) ;;
    esac


done


# ------------------ Generally, DO NOT CHANGE BELOW -----------------
myarray=(land tmpsfc tmp2m t2min t2max ulwrftoa dlwrf dswrf ulwrf uswrf prate pwat icetk icec cloudbdry cloudlow cloudmid cloudhi snow weasd snod lhtfl shtfl pres u10 v10 uflx vflx soill01d soill14d soill41m soill12m tsoil01d tsoil14d tsoil41m tsoil12mo soilm02m sfcr u850 u200 z500)

if [ $varname == "u850" ] || [  $varname == "u200" ] || [ $varname == "z500" ] ; then
   ftype=pgrb2
else
   ftype=sfc
fi

for (( yyyy=$ystart; yyyy<=$yend; yyyy+=$ystep )); do
    for (( mm1=$mstart; mm1<=$mend; mm1+=$mstep )); do
        for (( dd1=$dstart; dd1<=$dend; dd1+=$dstep )); do
            mm=$(printf "%02d" $mm1)
            dd=$(printf "%02d" $dd1)
            tag=${yyyy}${mm}${dd}
            indir=${wherefrom}/${tag}00/gfs.$tag/00/atmos    # directory with model output files for given start date
            if [ ! -d $indir ] ; then
               indir=${wherefrom}/${tag}/gfs.$tag/00/atmos
            fi
            if [ ! -d $indir ] ; then
               indir=${wherefrom}/${tag}00/gfs.$tag/00
            fi
            if [ ! -d $indir ] ; then
               indir=${wherefrom}/${tag}/gfs.$tag/00
            fi

            if [ ! -d $indir ] ; then
               echo " indir $indir does not exist"
            else

            if [ ! -d $whereto/6hrly/${tag} ] ; then mkdir -p $whereto/6hrly/${tag} ; fi
            if [ ! -d $whereto/dailymean/${tag} ] ; then mkdir -p $whereto/dailymean/${tag} ; fi

            case "${myarray[@]}" in
                *"$varname"*)  ;;
                *)
                echo "Exiting. To continue, please correct: unknown variable ---> $varname <---"
                exit
            esac

            aggregate="-daymean"
            tomatch2=""
            if [ $varname == "u200" ] ; then
               tomatch="UGRD:200"; aggregate="-daymean"
            fi
            if [ $varname == "u850" ] ; then
               tomatch="UGRD:850"; aggregate="-daymean"
            fi
            if [ $varname == "z500" ] ; then
               tomatch="HGT:500"; aggregate="-daymean"
            fi
            if [ $varname == "sfcr" ] ; then
               tomatch="SFCR:surface"; aggregate="-daymean"
            fi
            if [ $varname == "land" ] ; then
               tomatch="LAND:surface"; aggregate="-daymean"
            fi
               #-- Temperature
            if [ $varname == "tmpsfc" ] ; then
               tomatch="TMP:surface:"; aggregate="-daymean"
            fi
            if [ $varname == "tmp2m" ] ; then
               tomatch="TMP:2 m above ground:"; aggregate="-daymean"
            fi
            if [ $varname == "t2max" ] ; then
               tomatch="TMAX:2 m above ground:"; aggregate="-daymax"
            fi
            if [ $varname == "t2min" ] ; then
               tomatch="TMIN:2 m above ground:"; aggregate="-daymin"
            fi
               #-- Precipitation
            if [ $varname == "prate" ] ; then
               tomatch="PRATE:surface:"; aggregate="-daymean"
            fi
            if [ $varname == pwat ] ; then
               tomatch="PWAT"; aggregate="-daymean"
            fi
               #-- Clouds
            if [ $varname == cloudbdry ] ; then
               tomatch="CDC:boundary"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == cloudlow ] ; then
               tomatch="CDC:low"; aggregate="-daymean"
            fi
            if [ $varname == cloudmid ] ; then
               tomatch="CDC:mid"; aggregate="-daymean"
            fi
            if [ $varname == cloudhi ] ; then
               tomatch="CDC:hi"; aggregate="-daymean"
            fi
               #-- Radiation
            if [ $varname == dswrf ] ; then
               tomatch="DSWRF:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == dlwrf ] ; then
               tomatch="DLWRF:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == ulwrf ] ; then
               tomatch="ULWRF:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == uswrf ] ; then
               tomatch="USWRF:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == "ulwrftoa" ] ; then
               tomatch="ULWRF:top of atmosphere:"; aggregate="-daymean"
            fi
               #-- Fluxes
            if [ $varname == lhtfl ] ; then
               tomatch="LHTFL:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == shtfl ] ; then
               tomatch="SHTFL:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == uflx ] ; then
               tomatch="UFLX"; aggregate="-daymean"
            fi
            if [ $varname == vflx ] ; then
               tomatch="VFLX"; aggregate="-daymean"
            fi
               #-- Winds
            if [ $varname == u10 ] ; then
               tomatch="UGRD:10"; aggregate="-daymean"
            fi
            if [ $varname == v10 ] ; then
               tomatch="VGRD:10"; aggregate="-daymean"
            fi
               #-- Pressure
            if [ $varname == pres ] ; then
               tomatch="PRES:surface"; aggregate="-daymean"
            fi
               #-- Snow and ice-related
            if [ $varname == weasd ] ; then
               tomatch="WEASD:surface"; aggregate="-daymean"
            fi
            if [ $varname == snod ] ; then
               tomatch="SNOD:surface"; aggregate="-daymean"
            fi
            if [ $varname == snow ] ; then
               tomatch="SNOWC:surface"; tomatch2="ave"; aggregate="-daymean"
            fi
            if [ $varname == "icetk" ] ; then
               tomatch="ICETK:surface:"; aggregate="-daymean"
            fi
            if [ $varname == "icec" ] ; then
               tomatch="ICEC:surface:";  aggregate="-daymean"
            fi

            # SOIL MOISTURE AND TEMPERATURE
            if [ $varname == "soilm02m" ] ; then
               tomatch="SOIL_M:0-2 m"; aggregate="-daymean"
            fi

            if [ -d ${indir} ] ; then
            if [ ! -f ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.grib2 ] ; then

                     echo "aggregating $exp $tag $varname from $ftype file"
                     #--  Extract target variable as grib2 file

                      for hhh1 in {6..840..6} ; do
                          hhh=$(printf "%03d" $hhh1)
                          if [ $res == "Orig" ] ; then
                             if [ $ftype == "pgrb2" ] ; then
                                infile=${indir}/gfs.t00z.pgrb2.0p25.f${hhh}
                             else
                                infile=${indir}/gfs.t00z.sfluxgrbf${hhh}.grib2
                             fi
                             outfile=${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.Orig.f${hhh}
                          else
                             if [ $ftype == "pgrb2" ] ; then
                                infile=${indir}/gfs.t00z.pgrb2.${res}.f${hhh}
                             else
                                infile=${indir}/gfs.t00z.flux.${res}.f${hhh}
                             fi
                             outfile=${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.f${hhh}
                          fi
                          if [ -f $infile ] ; then
                              wgrib2 -match "$tomatch" $infile -match "$tomatch2" -grib $outfile > /dev/null
                          else
                              echo " missing $infile : cannot continue"
                              exit
                          fi
                      done

                     #--  String up all hours into one file

                      cat ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.f??? > ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.grib2

                     #--  Clean up

                      rm ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.f???

                     #--  Convert grib2 to nc:

                      wgrib2 ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.grib2 -netcdf ${whereto}/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.nc > /dev/null
                   else
                   echo "$exp $tag $varname already processed"

                   fi
                   if [ ! -f $whereto/dailymean/${tag}/${varname}.${exp}.${tag}.dailymean.${res}.nc ] ; then

                     #--  Convert 6-hourly to daily nc:
                      cdo shifttime,1sec "$aggregate" -shifttime,-1sec \
                          $whereto/6hrly/${tag}/${varname}.${exp}.${tag}.${res}.nc \
                          $whereto/dailymean/${tag}/${varname}.${exp}.${tag}.dailymean.${res}.nc > /dev/null
                   fi

            fi
            fi
done
done
done



