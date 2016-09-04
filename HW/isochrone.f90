!Programmer(s):         Laurel Farris
!Course:                ASTR 555; hw04(2,3)
!Files:                 isochrone.dat
!Functions:             N/A
!Last modified:         09 November 2014
!Description:           This program  calculates the cumulative contributions
!                       to the total luminosity and to the total integrated
!                       mass as a function of stellar mass

program isochrone

real,dimension(215) :: Z,age,M_ini,M_act,L,Te,G,mbol,U,B,V,R,I,J
real,dimension(215) :: H,K,IMF,stage
real,dimension(18)  :: dummy
real,dimension(215) :: num, integrated_mass, integrated_lum, array
real*8              :: totalMass,totalLuminosity,totalNumber
real*8              :: a

open(unit=1, file='isochrone2.dat',status='old',action='read')
do a=1,215
  read(1,*)dummy
   Z(a)=dummy(1)
   age(a)=dummy(2)
   M_ini(a)=dummy(3)
   M_act(a)=dummy(4)
   L(a)=10**(dummy(5))
   Te(a)=dummy(6)
   G(a)=dummy(7)
   mbol(a)=dummy(8)
   U(a)=dummy(9)
   B(a)=dummy(10)
   V(a)=dummy(11)
   R(a)=dummy(12)
   I(a)=dummy(13)
   J(a)=dummy(14)
   H(a)=dummy(15)
   K(a)=dummy(16)
   IMF(a)=dummy(17)
   stage(a)=dummy(18)
end do
close(unit=1)

! Find the number of stars at each mass/luminosity by 
! subtracting each IMF from the IMF on the following row.
! Then add these values to get the total number of stars
totalNumber=0
do a=1,214
  num(a)=IMF(a+1) - IMF(a)
  totalNumber=totalNumber+num(a)
end do

! Find the total mass
totalMass=0
do a=1,215
  totalMass=totalMass+(num(a)*M_act(a))
end do

! Find the total luminosity
totalLuminosity=0
do a=1,215
  totalLuminosity=totalLuminosity+(num(a)*L(a))
end do

!Calculate the integrated mass

integrated_mass(1)=(m_act(1)*num(1))
do a=2,215
  integrated_mass(a)=integrated_mass(a-1)+(m_act(a)*num(a))
end do
integrated_mass=integrated_mass/totalMass

!Calculate the integrated luminosity
do a=2,215
  integrated_lum(a)=integrated_lum(a-1)+(L(a)*num(a))
end do
integrated_lum=integrated_lum/totalLuminosity

! Write data to a file to be plotted
open(unit=2,file='M_act.txt')
write(2,*) M_act
close(unit=2)
open(unit=3,file='integrated_mass.txt')
write(3,*)integrated_mass
close(unit=3)
open(unit=4,file='integrated_luminosity.txt')
write(4,*)integrated_lum
close(unit=4)

end program isochrone


