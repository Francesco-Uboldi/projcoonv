module pjcoonv
!-----------------------------------------------------------------------------------
! Francesco Uboldi 2023
! 
! OK 2023-07-26
! 
! La libreria di sistema è proj8 :
!
! $ gfortran projcoonv.c pjcoonv_module.f90 pr_modpj.f90 -lproj -lstdc++ -o pjcoonv
!
!-----------------------------------------------------------------------------------
  use, intrinsic :: iso_c_binding
  implicit none

  interface
    function projcoonvc(epsgfrom, epsgto, x, y) bind (C, name= "projcoonv") result(jret)
      import c_char, c_int, c_double
      implicit none
      character(c_char), intent(in) :: epsgfrom, epsgto
      real(c_double), intent(inout) :: x, y
      integer(c_int) :: jret
    end function projcoonvc
  end interface

  interface projcoonv
    module procedure projcoonv_f, projcoonv_d
  end interface projcoonv

contains

  function projcoonv_f(epsgfrom, epsgto, fx, fy) result(jret)
    implicit none
    character(*), intent(in) :: epsgfrom, epsgto
    real(c_float), intent(inout) :: fx, fy
    real(c_double) :: x, y
    integer(c_int) :: jret
    jret= 0
    x= dble(fx)
    y= dble(fy)
    jret= projcoonvc(trim(epsgfrom)//C_NULL_CHAR, trim(epsgto)//C_NULL_CHAR, x, y)
    ! write (6,*) 'pjcoonv_module.f90: jret=', jret
    fx= sngl(x)
    fy= sngl(y)
    return
  end function projcoonv_f

  function projcoonv_d(epsgfrom, epsgto, x, y) result(jret)
    implicit none
    character(*), intent(in) :: epsgfrom, epsgto
    real(c_double), intent(inout) :: x, y
    integer(c_int) :: jret
    jret= 0
    jret= projcoonvc(trim(epsgfrom)//C_NULL_CHAR, trim(epsgto)//C_NULL_CHAR, x, y)
    ! write (6,*) 'pjcoonv_module.f90: jret=', jret
    return
  end function projcoonv_d

end module pjcoonv
