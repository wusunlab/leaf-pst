open Constants

let c2k = ( +. ) zero_celsius

let k2c t = t -. zero_celsius

let stefan_boltzmann t =
  let t2 = t *. t in
  stefan_boltzmann_constant *. t2 *. t2

(* Hardy 1998 equation *)
let e_sat t =
  let t2 = t *. t in
  let log_esat =
    ( ( ( ( ( (((-1.868_000_9e-13 *. t) +. 7.022_905_6e-10) *. t)
            +. 1.626_169_8e-5 )
            *. t
          -. 2.737_830_188e-2 )
          *. t
        +. 1.954_263_612e1 )
        *. t
      -. 6.028_076_559e3 )
      *. t
    -. 2.836_574_4e3 )
    /. t2
    +. (2.715_030_5 *. log t)
  in
  exp log_esat

let e_sat_deriv t =
  let t3 = t *. t *. t in
  let log_e_sat_deriv =
    ( ( ( ( ( (((-7.4720036e-13 *. t) +. 2.106_871_68e-9) *. t)
            +. 3.252_339_6e-5 )
            *. t
          -. 2.737_830_188e-2 )
          *. t
        +. 2.715_030_5 )
        *. t
      +. 6.028_076_559e3 )
      *. t
    +. 5.673_148_8e3 )
    /. t3
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
