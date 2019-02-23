open Constants

(* Note: putting q10 and t_ref before t is more convenient for currying. *)
let q10_fun q10 t_ref t = q10 ** (0.1 *. (t -. t_ref))

let arrhenius e_act t_ref t =
  exp (e_act *. (t -. t_ref) /. (molar_gas *. t_ref *. t))

let enzyme_temp_dep delta_G_a delta_H_d delta_S_d t_ref t =
  let f_enzyme_temp_dep delta_G_a delta_H_d delta_S_d t =
    t
    *. exp (-.delta_G_a /. (molar_gas *. t))
    /. (1.0 +. exp ((delta_S_d -. (delta_H_d /. t)) /. molar_gas))
  in
  f_enzyme_temp_dep delta_G_a delta_H_d delta_S_d t
  /. f_enzyme_temp_dep delta_G_a delta_H_d delta_S_d t_ref

let enzyme_temp_opt delta_G_a delta_H_d delta_S_d =
  let t_eq = delta_H_d /. delta_S_d in
  let alpha =
    molar_gas /. delta_H_d *. log ((delta_H_d /. delta_G_a) -. 1.0)
  in
  t_eq *. (1.0 -. (alpha *. t_eq))
