open Constants

let c2k = ( +. ) zero_celsius

let k2c t = t -. zero_celsius

let stefan_boltzmann t = stefan_boltzmann_constant *. (t ** 4.0)

(* Goff--Gratch equation, 1946 *)
let e_sat t =
  let u = 373.16 /. t in
  let v = t /. 373.16 in
  let log10_esat =
    (-7.90298 *. (u -. 1.))
    +. (5.02808 *. log10 u)
    -. (1.3816e-7 *. ((10. ** (11.344 *. (1. -. v))) -. 1.))
    +. (8.1328e-3 *. ((10. ** (-3.49149 *. (u -. 1.))) -. 1.))
    +. log10 1013.246 +. 2.
    (* add 2 to convert from hPa to Pa *)
  in
  10. ** log10_esat

(* from Goff--Gratch equation, 1946 *)
let e_sat_deriv t =
  let log_e_sat_deriv =
    ( 6790.4984743899386
    +. exp (12.068003566856145 -. (3000.0022166762069 /. t)) )
    /. (t *. t)
    -. (5.02808 /. t)
    +. exp (8.5004184700093912 -. (0.069998191914793798 *. t))
  in
  e_sat t *. log_e_sat_deriv

let vapor_deficit t rh = e_sat t *. (1. -. rh)

let vapor_mole_frac t p rh = e_sat t *. rh /. p

let vapor_deficit_mole_frac t p rh = vapor_deficit t rh /. p

let latent_heat_vap t =
  let x = t /. (t -. 33.91) in
  1.91846e6 *. x *. x *. molar_mass_water

let air_molar t p = p /. (molar_gas *. t)

let air_density t p rh =
  let x_v = e_sat t *. rh /. p in
  (((1. -. x_v) *. molar_mass_dryair) +. (x_v *. molar_mass_water))
  *. air_molar t p
