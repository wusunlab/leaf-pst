open Thermodyn
open Transfercoefs
open Stomcond

let bl_cond_heat ~t_air ~p ~rh ~wind_speed ~d_leaf =
  let nu_a = kin_visc_moistair t_air p rh in
  (* nu_a: kinematic viscosity of moist air [m^2 s^-1] *)
  let pr = prandtl t_air p rh in
  let air_conc = air_molar t_air p in
  (* empirical factors:
   * - 1.4 is an empirical factor for field conditions
   * - 0.664 is an empirical factor for Nusselt number of laminar flow over a
   *   flat plate *)
  1.4 *. 0.664
  *. (pr ** (1. /. 3.))
  *. air_conc
  *. therm_diff_moistair t_air p rh
  *. sqrt (wind_speed /. (d_leaf *. nu_a))

let bl_cond_vapor ~t_air ~p ~rh ~wind_speed ~d_leaf =
  let nu_a = kin_visc_moistair t_air p rh in
  let d_w = diffus_vapor t_air p in
  let sc = nu_a /. d_w in
  (* sc: Schmidt number *)
  let air_conc = air_molar t_air p in
  1.4 *. 0.664
  *. (sc ** (1. /. 3.))
  *. air_conc *. d_w
  *. sqrt (wind_speed /. (d_leaf *. nu_a))

let ppfd_to_shortwave ppfd = (0.495785820525533 *. ppfd) -. 0.08081308874566188

let sensible_heat ~t_leaf ~t_air ~p ~rh ~g_bh =
  let cp_a = heat_cap_moistair t_air p rh in
  2. *. g_bh *. cp_a *. (t_leaf -. t_air)

let leaf_vapor_deficit t_leaf t_air rh = e_sat t_leaf -. (e_sat t_air *. rh)

let water_flux ~vpd_leaf ~p ~g_bw ~g_sw =
  total_cond_h2o g_bw g_sw *. vpd_leaf /. p

let latent_heat ~t_leaf ~vpd_leaf ~p ~g_bw ~g_sw =
  water_flux ~vpd_leaf ~p ~g_bw ~g_sw *. latent_heat_vap t_leaf

let energy_imbalance ~t_leaf ~t_air ~p ~rh ~rad_sw ~wind_speed ~d_leaf ~em_leaf
    ~g_sw =
  let rad_net = rad_sw -. (em_leaf *. stefan_boltzmann t_leaf) in
  let vpd_leaf = leaf_vapor_deficit t_leaf t_air rh in
  let g_bh = bl_cond_heat ~t_air ~p ~rh ~wind_speed ~d_leaf in
  let g_bw = bl_cond_vapor ~t_air ~p ~rh ~wind_speed ~d_leaf in
  let f_sh = sensible_heat ~t_leaf ~t_air ~p ~rh ~g_bh in
  let f_le = latent_heat ~t_leaf ~vpd_leaf ~p ~g_bw ~g_sw in
  rad_net -. f_sh -. f_le
