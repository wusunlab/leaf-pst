open Owl
open Algodiff.D
open Leaf_pst_types

(* open Constants *)
open Stomcond
open Photosyn
open Ebal

let rec desc ?(eta = F 0.01) ?(eps = 1e-6) f x =
  let g = (diff f) x in
  if unpack_flt g < eps then x else desc ~eta ~eps f Maths.(x - (eta * g))

let assim_imbalance ~(params : photosyn_params) ~slope ~g_s_min ~t_air ~p ~rh
    ~ppfd ~o2 ~co2 ~wind_speed ~d_leaf ~t_leaf ~co2_c =
  match params.pathway with
  | C3 ->
      let assim = assim_c3 ~params ~co2_c ~ppfd ~t_leaf ~o2 ~p in
      let g_bw = bl_cond_vapor ~t_air ~p ~rh ~wind_speed ~d_leaf in
      let co2_l = co2 -. (assim /. g_bw) in
      (* co2_l: leaf boundary layer co2 concentration *)
      let g_sw = ball_berry ~assim ~co2:co2_l ~rh ~slope ~g_s_min in
      let g_m = mesophyll_cond ~params:params.g_m ~t_leaf in
      let assim_hat = total_cond_co2 g_bw g_sw g_m *. (co2 -. co2_c) in
      assim -. assim_hat
  | C4 ->
      raise Not_implemented
  | CAM ->
      raise Not_implemented

let find_co2_c ~(params : photosyn_params) ~slope ~g_s_min ~t_air ~p ~rh ~ppfd
    ~o2 ~co2 ~wind_speed ~d_leaf ~t_leaf =
  let f x =
    assim_imbalance ~params ~slope ~g_s_min ~t_air ~p ~rh ~ppfd ~o2 ~co2
      ~wind_speed ~d_leaf ~t_leaf ~co2_c:x
  in
  let f_packed x = unpack_flt x |> f |> pack_flt in
  desc f_packed (pack_flt co2) |> unpack_flt

(* let find_t_leaf ~(params : photosyn_params) ~slope ~g_s_min ~t_air ~p ~rh
    ~ppfd ~o2 ~co2 ~wind_speed ~d_leaf = 0.0 *)

(* let solver_clm = 0.0 *)
