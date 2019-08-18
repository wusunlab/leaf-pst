open Leaf_pst_types
open Chemkinet

let ratio_gb_co2 = 1.37

let ratio_gs_co2 = 1.60

let ratio_gb_cos = 1.56

let ratio_gs_cos = 1.94

let ball_berry ~assim ~co2 ~rh ~slope ~g_s_min =
  g_s_min +. max (slope *. assim *. rh /. co2) 0.0

let leuning ~assim ~co2 ~vpd ~vpd_0 ~slope ~g_s_min =
  g_s_min +. max (slope *. assim /. co2 /. (1.0 +. (vpd /. vpd_0))) 0.0

let medlyn ~assim ~co2 ~vpd ~slope ~g_s_min =
  g_s_min
  +. max (ratio_gs_co2 *. (1. +. (slope /. sqrt vpd)) *. assim /. co2) 0.0

let mesophyll_cond ~(params : temp_dep) ~t_leaf = eval_temp_dep params t_leaf

let total_cond_h2o g_bw g_sw = g_bw *. g_sw /. (g_bw +. g_sw)

let total_cond_co2 g_bw g_sw g_m =
  let g_bc = g_bw /. ratio_gb_co2 in
  let g_sc = g_sw /. ratio_gs_co2 in
  g_bc *. g_sc *. g_m /. ((g_bc *. g_sc) +. (g_m *. (g_bc +. g_sc)))

let total_cond_cos g_bw g_sw g_m =
  let g_bs = g_bw /. ratio_gb_cos in
  let g_ss = g_sw /. ratio_gs_cos in
  g_bs *. g_ss *. g_m /. ((g_bs *. g_ss) +. (g_m *. (g_bs +. g_ss)))
