(* Tests for Leaf_pst.Constants *)

open Test_utils
open Leaf_pst.Constants

let test_constants () =
  test_approx "speed of light" speed_of_light 299792458. ;
  test_approx "Planck's constant" planck_constant 6.626e-34 ~rtol:1e-4 ;
  test_approx "Stefan--Boltzmann constant" stefan_boltzmann_constant 5.67e-8
    ~rtol:1e-4 ;
  test_approx "Boltzmann's constant" boltzmann_constant 1.38065e-23 ~rtol:1e-4 ;
  test_approx "Avogadro's constant" avogadro_constant 6.022e23 ~rtol:1e-4 ;
  test_approx "Molar gas constant" molar_gas 8.3145 ~rtol:1e-4 ;
  test_approx "Standard atmosphere" std_atmosphere 101325. ;
  test_approx "Earth's gravity" grav_accel 9.806 ~rtol:1e-4 ;
  test_approx "Zero celsius" zero_celsius 273.15 ;
  test_approx "Von Kármán's constant" von_karman_constant 0.4 ;
  test_approx "Molar mass of water" molar_mass_water 18.016e-3 ~rtol:1e-4 ;
  test_approx "Molar mass of CO2" molar_mass_co2 44.01e-3 ~rtol:1e-4 ;
  test_approx "Molar mass of dry air" molar_mass_dryair 28.97e-3 ~rtol:1e-3

let tests = [("Test Leaf_pst.Constants", `Quick, test_constants)]
