open Constants
open Math_helpers
open Thermodyn

let dyn_visc_dryair t =
  polyval
    [-9.8601e-7; 9.080125e-8; -1.17635575e-10; 1.2349703e-13; -5.7971299e-17]
    t

let dyn_visc_vapor t = -2.869368957406498e-06 +. (4.000549451e-8 *. t)

(* Calculate viscosity interaction terms from temperature \[K\]. This is a
   private helper function for calculating moist air properties. *)
let viscosity_interaction_terms t =
  (* `_d` - dry air; `_w` - water vapor *)
  let m_dw = molar_mass_dryair /. molar_mass_water in
  let m_wd = molar_mass_water /. molar_mass_dryair in
  let mu_d = dyn_visc_dryair t in
  let mu_w = dyn_visc_vapor t in
  let phi_dw =
    sqrt 2. *. 0.25
    *. ((1. +. m_dw) ** -0.5)
    *. ((1. +. (sqrt (mu_d /. mu_w) *. (m_wd ** 0.25))) ** 2.)
  in
  let phi_wd =
    sqrt 2. *. 0.25
    *. ((1. +. m_wd) ** -0.5)
    *. ((1. +. (sqrt (mu_w /. mu_d) *. (m_dw ** 0.25))) ** 2.)
  in
  (phi_dw, phi_wd, mu_d, mu_w)

let dyn_visc_moistair t p rh =
  let x_w = vapor_mole_frac t p rh in
  let x_d = 1. -. x_w in
  let phi_dw, phi_wd, mu_d, mu_w = viscosity_interaction_terms t in
  (x_d *. mu_d /. (x_d +. (x_w *. phi_dw)))
  +. (x_w *. mu_w /. (x_w +. (x_d *. phi_wd)))

let kin_visc_moistair t p rh = dyn_visc_moistair t p rh /. air_density t p rh

let therm_cond_dryair t =
  polyval
    [ -2.276501e-3
    ; 1.2598485e-4
    ; -1.4815235e-7
    ; 1.73550646e-10
    ; -1.066657e-13
    ; 2.47663035e-17 ]
    t

let heat_cap_dryair t =
  polyval [1.03409e3; -0.284887; 0.7816818e-3; -0.4970786e-6; 0.1077024e-9] t
  *. molar_mass_dryair

let therm_cond_vapor t =
  (* note: the empirical equation takes Celsius values *)
  polyval [1.761758242e-2; 5.558941059e-5; 1.663336663e-7] (k2c t)

let heat_cap_vapor t =
  polyval [1.86910989e3; -2.578421578e-1; 1.941058941e-2] (k2c t)
  *. molar_mass_water

let therm_cond_moistair t p rh =
  let x_w = vapor_mole_frac t p rh in
  let x_d = 1. -. x_w in
  let kappa_d = therm_cond_dryair t in
  let kappa_w = therm_cond_vapor t in
  let phi_dw, phi_wd, _, _ = viscosity_interaction_terms t in
  (x_d *. kappa_d /. (x_d +. (x_w *. phi_dw)))
  +. (x_w *. kappa_w /. (x_w +. (x_d *. phi_wd)))

let heat_cap_moistair t p rh =
  let x_w = vapor_mole_frac t p rh in
  let cp_d = heat_cap_dryair t in
  let cp_w = heat_cap_vapor t in
  ((1. -. x_w) *. cp_d) +. (x_w *. cp_w)

let heat_cap_mass_moistair t p rh =
  let x_w = vapor_mole_frac t p rh in
  let x_d = 1. -. x_w in
  let cp_d = heat_cap_dryair t in
  let cp_w = heat_cap_vapor t in
  ((x_d *. cp_d) +. (x_w *. cp_w))
  /. ((x_d *. molar_mass_dryair) +. (x_w *. molar_mass_water))

let therm_diff_moistair t p rh =
  let rho_a = air_density t p rh in
  let cpm_a = heat_cap_mass_moistair t p rh in
  therm_cond_moistair t p rh /. (rho_a *. cpm_a)

let prandtl t p rh =
  dyn_visc_moistair t p rh
  *. heat_cap_mass_moistair t p rh
  /. therm_cond_moistair t p rh

let diffus_vapor t p =
  2.178e-5 *. (std_atmosphere /. p) *. ((t /. zero_celsius) ** 1.81)
