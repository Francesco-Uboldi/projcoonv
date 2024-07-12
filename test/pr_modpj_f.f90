! OK 2023-07-26
! 
! La libreria di sistema è proj8 :
!
! $ gfortran projcoonv.c pjcoonv_module.f90 pr_modpj.f90 -lproj -lstdc++ -o pjcoonv
!
! COMPILAZIONE STATICA ANCORA NON FUNZIONA, occorre linkare altre librerie statiche (curl, tiff, jpeg, z, ...?) :
! $ gfortran -static projcoonv.c pjcoonv_module.f90 pr_modpj.f90 -I ~/proj/proj8/include/ -L ~/proj/proj8/lib/ -lproj -lsqlite3 -lpthread -lm -lstdc++ -o pjcoonv
!
! Esempi:
!
! GEO=longlat: "EPSG:4326"
! UTM33N:  "EPSG:32633"
! UTM32N:  "EPSG:32632"

! $ pjcoonv "EPSG:4326" "EPSG:32633" 15.0014057 37.0473493
! EPSG:4326
! EPSG:32633
!  
!  IN:    15.001405699999999        37.047349300000000     
! projcoonv.c: FROM: ./proj.db
! projcoonv.c: FROM: EPSG:4326
! projcoonv.c:  TO : EPSG:32633
! projcoonv.c: input x=15.001406 y=37.047349
! projcoonv.c: output x=500124.996060 y=4100125.004172
!  pjcoonv_module.f90: jret=           0
!  jret=           0
!  OUT:    500124.99605990312        4100125.0041716523 
!
!
! $ pjcoonv "EPSG:32633" "EPSG:4326" 500125 4100125
! EPSG:32633
! EPSG:4326
!  
!  IN:    500125.00000000000        4100125.0000000000     
! projcoonv.c: FROM: ./proj.db
! projcoonv.c: FROM: EPSG:32633
! projcoonv.c:  TO : EPSG:4326
! projcoonv.c: input x=500125.000000 y=4100125.000000
! projcoonv.c: output x=15.001406 y=37.047349
!  pjcoonv_module.f90: jret=           0
!  jret=           0
!  OUT:    15.001405744309453        37.047349262394697     


program pr

! Francesco Uboldi 2023

  use pjcoonv
  implicit none

  ! projcoonv args:
  character(256) :: epsgfrom, epsgto
  real(4) :: x, y
  integer :: jret

  character(40) :: arg


  jret= 0

  call getarg(1, epsgfrom)
  if (epsgfrom == '-h' .or. epsgfrom == '') then
    write (6,'(a)') ''
    write (6,'(a)') '$ projcoonv <epsgStringFrom> <epsgStringTo> <x> <y>'
    write (6,'(a)') '  GEO: "EPSG:4326"'
    write (6,'(a)') 'UTM32N: "EPSG:32632"'
    write (6,'(a)') 'UTM33N: "EPSG:32633"'
    write (6,'(a)') ''
    stop
  end if
  
  call getarg(2, epsgto)

  call getarg(3, arg)
  read (arg,*) x

  call getarg(4, arg)
  read (arg,*) y


  ! write (6,'(a)') trim(epsgfrom)
  ! write (6,'(a)') trim(epsgto)
  ! write (6, *) ''
  write (6,'(a,2f12.5)') ' IN:', x, y

  jret= projcoonv(epsgfrom, epsgto, x, y)
  ! write (6,*) 'jret=', jret

  if (jret /= 0) then
    write (6,'(a)') 'stringa non corretta'
    stop
  end if

  write (6,'(a,2f12.0)') 'OUT:', x, y

  stop
end program pr

