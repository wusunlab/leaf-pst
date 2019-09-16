open Leaf_pst_types
open Constants
open Chemkinet

let electron_transport ~(params : photosyn_params) ~ppfd ~t_leaf =
  let i_psii =
    ppfd *. params.f_apar *. (1. -. params.f_spec) *. params.f_psii
  in
  let j_max = eval_temp_dep params.j_max t_leaf in
  let x = i_psii +. j_max in
  (x -. sqrt ((x *. x) -. (4. *. params.theta *. i_psii *. j_max)))
  /. (2. *. params.theta)

let assim_c3 ~(params : photosyn_params) ~co2_c ~ppfd ~t_leaf ~o2 ~p =
  (* evaluate biochemical parameters at the current leaf temperature *)
  (* note: pressure correction is needed for Michaelis constants because they
     must be converted to equivalent mixing ratios: [mol L^-1] -> [Pa] -> [µmol
     mol^-1]. *)
  let v_cmax = eval_temp_dep params.v_cmax t_leaf in
  let k_c = eval_temp_dep params.k_c t_leaf *. (std_atmosphere /. p) in
  let k_o = eval_temp_dep params.k_o t_leaf *. (std_atmosphere /. p) in
  let co2_comp = eval_temp_dep params.co2_comp t_leaf in
  let resp = eval_temp_dep params.resp t_leaf in
  let j = electron_transport ~params ~ppfd ~t_leaf in
  let assim_j =
    (co2_c -. co2_comp) /. ((4. *. co2_c) +. (8. *. co2_comp)) *. j
  in
  let assim_c =
    (co2_c -. co2_comp) *. v_cmax /. (co2_c +. (k_c *. (1. +. (o2 /. k_o))))
  in
  let assim_g = min assim_j assim_c in
  if params.enable_tpu then
    let v_tpu = eval_temp_dep params.v_tpu t_leaf in
    let assim_p =
      3. *. v_tpu *. (co2_c -. co2_comp)
      /. (co2_c -. ((1. +. (1.5 *. params.f_glyc)) *. co2_comp))
    in
    min assim_g assim_p -. resp
  else assim_g -. resp
