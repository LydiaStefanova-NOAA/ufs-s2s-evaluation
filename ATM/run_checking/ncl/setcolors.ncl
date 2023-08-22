procedure setcolors (varname)

begin
  if (isStrSubset(varname,"u200")) then
      res0@cnMinLevelValF  = -40.
      res0@cnMaxLevelValF  = 40.
      res0@cnLevelSpacingF  = 5.

      res1@cnMinLevelValF  = -5.
      res1@cnMaxLevelValF  = 5.
      res1@cnLevelSpacingF  = 0.5
   
      res2=res1

  end if
  if (isStrSubset(varname,"u850")) then
      res0@cnMinLevelValF  = -12.
      res0@cnMaxLevelValF  = 12.
      res0@cnLevelSpacingF  = 2.

      res1@cnMinLevelValF  = -3.
      res1@cnMaxLevelValF  = 3.
      res1@cnLevelSpacingF  = 0.2

      res2=res1
  end if

  if (isStrSubset(varname,"z500")) then

       res0@cnMinLevelValF  = 5000.
       res0@cnMaxLevelValF  = 5800.
       res0@cnLevelSpacingF  = 50.

       res1@cnMinLevelValF  = -50.
       res1@cnMaxLevelValF  = 50.
       res1@cnLevelSpacingF  = 5.

       res2=res1

  end if 
  if (isStrSubset(varname,"CAPE")) then
       res0@cnFillPalette = "precip_diff_12lev"
       res0@cnFillPalette = "amwg256"
       res0@cnFillPalette = "BlGrYeOrReVi200"
       res0@cnMinLevelValF  = 0.
       res0@cnMaxLevelValF  = 1100.
       res0@cnLevelSpacingF  = 100.

       res1@cnFillPalette = "precip_diff_12lev"
;       res1@cnFillPalette = "BrownBlue12"
       res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res1@cnLevels             = (/ -300., -200., -100.,-50.,-10., 10. ,50. ,100. ,200. , 300./)   ; set levels
       res1@cnFillColors         = (/ 11,  10,   9,    8,   7,    6,    5,  4,  3,    2,  1/)  ; set the colors to be used
       res1@cnFillColors         = (/ 1,  2,   3,    4,  5,  6,  7,  8,  9,    10,  11/)  ; set the colors to be used
;       res1@cnFillPalette = "precip4_diff_19lev"
;       res1@cnFillColors         = (/ 17,  16,   15,   14,   13,  -1,  10,  9, 8,   3,  2/)  ; set the colors to be used
;       res1@cnFillColors         = (/ 17,   15,   13, 12, 11, -1, 8,7,6,5,1/)  ; set the colors to be used

       res2@cnFillPalette = "precip_diff_12lev"
       res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res2@cnLevels             = (/ -300., -200., -100.,-50.,-10., 10. ,50. ,100. ,200. , 300./)   ; set levels
       res2@cnFillColors         = (/ 11,  10,   9,    8,   7,  6,  5,  4,  3,    2,  1/)  ; set the colors to be used
  end if

  if (isStrSubset(varname,"cloud").or.isStrSubset(varname,"soilw").or.isStrSubset(varname,"soill")) then
       res0@cnFillPalette = "precip_diff_12lev"
       res0@cnMinLevelValF  = 10.
       res0@cnMaxLevelValF  = 90.
       res0@cnLevelSpacingF  = 10.

       res1@cnFillPalette = "precip_diff_12lev"
       res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res1@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
       res1@cnFillColors         = (/ 11,  10,   9,    8,   7,  6,  5,  4,  3,    2,  1/)  ; set the colors to be used
       res1@cnFillColors         = (/ 1,  2,   3,    4,  5,  6,  7,  8,  9,    10,  11/)  ; set the colors to be used

       res2@cnFillPalette = "precip_diff_12lev"
       res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
       res2@cnFillColors         = (/ 11,  10,   9,    8,   7,  6,  5,  4,  3,    2,  1/)  ; set the colors to be used
  end if

  if (isStrSubset(varname,"shtfl")) then
       res0@cnMinLevelValF  = -40.
       res0@cnMaxLevelValF  = 120.
       res0@cnLevelSpacingF  = 20.

       res1@cnFillPalette        = "temp_diff_18lev"
       res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res1@cnLevels             = (/ -50., -30., -20.,-10.,-5., 5. ,10. ,20. ,30. , 50./)   ; set levels

       res2@cnFillPalette        = "temp_diff_18lev"
       res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if
       
  if (isStrSubset(varname,"u10").or.isStrSubset(varname,"v10")) then
      res0@cnMinLevelValF  = -10.
      res0@cnMaxLevelValF  = 10.
      res0@cnLevelSpacingF  = 2.
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      ;res0@cnLevels             = (/ -10., -5., -3.,-2.,-1., -0.1, 0.1 , 1. ,2. ,3. ,5. , 10./)   ; set levels
      res0@cnLevels             = (/ -8.,-4., -3., -2.,-1.,-0.5, -0.2,  0.2, 0.5 ,1. ,2., 3., 4., 8./)   ; set levels

      ;res1@cnFillPalette        = "temp_diff_18lev"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      ;res1@cnLevels             = (/ -4., -3., -2.,-1.,-0.5, -0.2, -0.1, 0.1, 0.2, 0.5 ,1. ,2., 3., 4./)   ; set levels
      res1@cnLevels             = (/ -8.,-4., -3., -2.,-1.,-0.5, -0.2,  0.2, 0.5 ,1. ,2., 3., 4., 8./)   ; set levels

      res2@cnFillPalette        = "temp_diff_18lev"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if

  if (isStrSubset(varname,"ustar")) then
      ;res0@cnFillPalette = "BlAqGrYeOrRe"
      res0@cnFillPalette = "Cat12"
       
      res0@cnMinLevelValF  = 0.05
      res0@cnMaxLevelValF  = 0.95
      res0@cnLevelSpacingF  = 0.1 

      ;res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      ;res0@cnLevels             = (/ 0.01, 0.05, 0.1, 0.2, 0.4, 0.6, 1/)   ; set levels

      res1@cnFillPalette = "BlueDarkRed18"
      res1@cnFillPalette = "BlueWhiteOrangeRed"
      
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/ -0.4, -0.2, -0.1, -0.05, -0.01, 0.01, 0.05, 0.1, 0.2, 0.4/)   ; set levels
  end if

  if (isStrSubset(varname,"pres")) then
      res0@cnMinLevelValF  = 500.
      res0@cnMaxLevelValF  = 1000.
      res0@cnLevelSpacingF  = 50.

      res1@cnFillPalette        = "temp_diff_18lev"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/ -5., -3., -2.,-1.,-0.5, -0.2, -0.1, 0.1, 0.2, 0.5 ,1. ,2., 3., 5./)   ; set levels

      res2@cnFillPalette        = "temp_diff_18lev"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if

  if (isStrSubset(varname,"tmp").or.isStrSubset(varname,"t2m").or.isStrSubset(varname,"sst")) then

      res0@cnFillPalette        = "wgne15"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res@cnFillColors=         (/7,8,  2,  3,  4,  5,   14, 15,10,11,12 /) 
      res0@cnLevels     := (/230,240,250,260,270,280,290,300,310/)   ; set levels
      res0@cnLevels     := (/260,265,270,275,280,285,290,295,300,305,310/)   ; set levels

      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/ -10., -5., -2.,-1.,-0.5, -0.2, -0.1, 0.1, 0.2, 0.5 ,1. ,2., 5., 10./)   ; set levels

      res2@cnFillPalette        = "temp_diff_18lev"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels

  end if

  if (isStrSubset(varname,"prate").or.isStrSubset(varname,"lhtfl")) then
      res0@cnFillPalette="CBR_wet"
      res0@cnFillPalette="precip3_16lev"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res0@cnLevels             = (/ 0.01, 0.1, 0.2, 0.5,  1,   2, 4,   8, 16, 32  /)   ; set levels

      res1@cnFillPalette="CBR_drywet"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/  -8.,-4., -2.,-1.,-0.5,-0.1, 0.1, 0.5 ,1. ,2., 4., 8. /)   ; set levels

;      res1@cnFillPalette="GreenMagenta16"

;      res1@cnLevels          := (/-32., -16., -4. , -1., 1.,  4.,  16., 32./)   ; set levels
;      res1@cnFillColors      := (/14,12,10,9,7,6,3,2,1/) 


      res2@cnFillPalette="CBR_drywet"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -8., -4., -2.,-1.,-0.5,-0.1, 0.1, 0.5 ,1. ,2., 4. , 8./)   ; set levels

;      res2@cnFillPalette="GreenMagenta16"
;      res2@cnLevels          := (/-32., -16., -8.,-4., -2., -1., 1., 2., 4., 8., 16., 32./)   ; set levels
;      res2@cnFillColors       = (/14,13,12,11,10,9, 7, 6,5,4,3,2,1/) ;13


  end if

  if (isStrSubset(varname,"snod")) then

      res0@cnFillPalette="CBR_wet"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res0@cnLevels             = (/ 0.01, 0.1, 0.2, 0.3, 0.5,  1,  1.5 /)   ; set levels

      res1@cnFillPalette="CBR_drywet"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/   -1.,-0.5, -0.2,-0.1,-0.05, 0.05, 0.1, 0.2, 0.5 ,1.  /)   ; set levels

      res2@cnFillPalette="CBR_drywet"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if

  if (isStrSubset(varname,"pwat")) then
      res0@cnFillPalette="CBR_wet"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res0@cnLevels             = (/ 1, 2, 4, 8, 16, 32, 64  /)   ; set levels

      res1@cnFillPalette="CBR_drywet"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/  -4, -2.,-1.,-0.5,-0.1, 0.1, 0.5 ,1. ,2., 4 /)   ; set levels

      res2@cnFillPalette="CBR_drywet"
      res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if
  if (isStrSubset(varname,"weasd")) then
      res0@cnFillPalette="CBR_wet"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      ;res0@cnLevels             = (/ 0.01, 10., 20., 30., 50.,  100.,  150. /)   ; set levels
      ;res0@cnLevels             = (/ 0.001, 0.01, 0.02, 0.05,  0.10,  0.50, 1. /)   ; set levels
      res0@cnLevels             = (/ 0.005, 0.01, 0.02, 0.05,  0.10,  0.50 /)*10   ; set levels
 
       res1@cnFillPalette="CBR_drywet"
       res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       ;res1@cnLevels             = (/ -50., -30., -20.,-10.,-5., 5. ,10. ,20. ,30. , 50./)   ; set levels
       ;res1@cnLevels             = (/ -0.5, -0.1, -0.05,-0.01,-0.001, 0.001 ,0.01 ,0.05 ,0.1 , 0.5/)   ; set levels
       ;res1@cnLevels             = (/ -0.2, -0.1, -0.05,-0.01, 0.01 ,0.05 ,0.1, 0.2/)   ; set levels
       res1@cnLevels             = (/ -0.1, -0.05,-0.01, 0.01 ,0.05 ,0.1 /)*10   ; set levels

 
       res2@cnFillPalette="CBR_drywet"
       res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       ;res2@cnLevels             = (/ -50., -30., -20.,-10.,-5., 5. ,10. ,20. ,30. , 50./)   ; set levels
       ;res2@cnLevels             = (/ -0.50, -0.10, -0.05,-0.01,-0.001, 0.001 ,0.01 ,0.05 ,0.10 , 0.50/)   ; set levels
       ;res1@cnLevels             = (/ -0.5, -0.1, -0.05,-0.01,-0.001, 0.001 ,0.01 ,0.05 ,0.1 , 0.5/)   ; set levels

   end if

  if (isStrSubset(varname,"snow")) then
      res0@cnFillPalette="GMT_drywet"
      res0@cnFillPalette="CBR_wet"
      res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res0@cnLevels             = (/ 0.5,  1, 5, 10, 20, 40, 60, 95/)   ; set levels

      res1@cnFillPalette="CBR_drywet"
      res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
      res1@cnLevels             = (/ -50., -25., -10., -5.,-1., 1.,5., 10., 25., 50. /)   ; set levels

      res2@cnFillPalette="CBR_drywet"
      res2@cnMinLevelValF  = -100.
      res2@cnMaxLevelValF  = 100.
      res2@cnLevelSpacingF  = 20.
  end if

  if (isStrSubset(varname,"wrf")) then
       cmap=read_colormap_file("MPL_gnuplot")
       res0@cnFillPalette = cmap
       res0@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res0@cnLevels             = (/20., 40., 80., 100., 150., 200., 300., 400.,500. /)   ; set levels
       if (isStrSubset(varname,"ulwrftoa")) then
           res0@cnLevels         = (/120., 140., 180., 200., 220., 240., 260., 280.,300. /)   ; set levels
       end if

       res1@cnFillPalette        = "sunshine_diff_12lev"
       res1@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res1@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels

       res2=res1
       res2@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
       res2@cnLevels             = (/ -40., -20., -10.,-5.,-2., 2. ,5. ,10. ,20. , 40./)   ; set levels
  end if 

  return ( [/res0,res1,res2/])
end
