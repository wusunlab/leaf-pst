open Constants

let q10_fun temp_diff q10 = q10 ** (0.1 *. temp_diff)

let arrhenius temp temp_ref e_act =
  exp (e_act *. (temp -. temp_ref) /. (molar_gas *. temp_ref *. temp))

let f_enzyme_temp_dep temp delta_G_a delta_H_d delta_S_d =
  exp (-.delta_G_a /. (molar_gas *. temp))
  /. (1.0 +. exp ((delta_S_d -. (delta_H_d /. temp)) /. molar_gas))

let enzyme_temp_dep temp temp_ref delta_G_a delta_H_d delta_S_d =
  f_enzyme_temp_dep temp delta_G_a delta_H_d delta_S_d
  /. f_enzyme_temp_dep temp_ref delta_G_a delta_H_d delta_S_d

let enzyme_temp_opt delta_G_a delta_H_d delta_S_d =
  delta_H_d
  /. (delta_S_d +. (molar_gas *. log ((delta_H_d /. delta_G_a) -. 1.0)))
