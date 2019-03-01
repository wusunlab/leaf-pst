(** {i Q}{_ 10} temperature dependence parameters.

    - [q10]: The {i Q}{_ 10} parameter in {!Chemkinet.q10_fun}.
    - [t_ref]: Reference temperature \[K\].
    - [v_max_ref]: Reaction rate at the reference temperature, arbitrary unit.
 *)
type temp_dep_q10 = {q10: float; t_ref: float; v_max_ref: float}

(** Arrhenius temperature dependence parameters.

    - [e_act]: The activation energy \[J mol{^ -1}\] in {!Chemkinet.arrhenius}.
    - [t_ref]: Reference temperature \[K\].
    - [v_max_ref]: Reaction rate at the reference temperature, arbitrary unit.
 *)
type temp_dep_arr = {e_act: float; t_ref: float; v_max_ref: float}

(** Enzyme optimum temperature dependence parameters.

    - [delta_G_a], [delta_H_d], [delta_S_d]: Enzyme energetic parameters in
      {!Chemkinet.enzyme_temp_dep}.
    - [t_ref]: Reference temperature \[K\].
    - [v_max_ref]: Reaction rate at the reference temperature, arbitrary unit.
 *)
type temp_dep_opt =
  { delta_G_a: float
  ; delta_H_d: float
  ; delta_S_d: float
  ; t_ref: float
  ; v_max_ref: float }

(** Temperature dependence parameters. *)
type temp_dep =
  | Q10 of temp_dep_q10
  | Arrhenius of temp_dep_arr
  | Optimum of temp_dep_opt

(** Photosynthetic pathways. *)
type photosyn_pathway = C3 | C4 | CAM

(** Photosynthetic parameters. The [temp_dep] type is a set of parameters that
    describe the baseline value and temperature dependence of an enzyme kinetic
    parameter.

    - [v_cmax]: Parameters for RuBisCO carboxylation.
    - [k_c]: Parameters for Michaelis constant for RuBisCO carboxylation.
    - [k_o]: Parameters for Michaelis constant for RuBisCO oxygenation.
    - [co2_comp]: Parameters for CO{_ 2} compensation point.
    - [resp]: Parameters for leaf dark respiration.
    - [j_max]: Parameters for linear electron transport.
    - [v_tpu]: Parameters for triose phosphate utilization (TPU).
    - [f_abs]: Fraction of absorbed photosynthetically active radiation.
    - [f_spec]: A correction factor for light spectral quality. Set to 0.0 if
      no correction is to be applied.
    - [f_psii]: Fraction of absorbed light partitioned to the photosystem II.
    - [theta]: A curvature factor for electron transport rate.
    - [f_glyc]: Non-returned fraction of glycolate.
    - [pathway]: Photosynthetic pathway - [C3], [C4], or [CAM].
    - [enable_tpu]: Enable TPU limitation? [true] or [false].
 *)
type photosyn_params =
  { v_cmax: temp_dep
  ; k_c: temp_dep
  ; k_o: temp_dep
  ; co2_comp: temp_dep
  ; resp: temp_dep
  ; j_max: temp_dep
  ; v_tp: temp_dep
  ; f_abs: float
  ; f_psii: float
  ; theta: float
  ; f_glyc: float
  ; pathway: photosyn_pathway
  ; enable_tpu: bool }
