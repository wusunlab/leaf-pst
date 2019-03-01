(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Stomatal conductance functions. *)

(** Ratio between boundary layer conductances of CO{_ 2} and H{_ 2}O. *)
val ratio_gb_co2_water : float

(** Ratio between stomatal conductances of CO{_ 2} and H{_ 2}O. *)
val ratio_gs_co2_water : float

(** Ratio between boundary layer conductances of COS and H{_ 2}O. *)
val ratio_gb_cos_water : float

(** Ratio between stomatal conductances of COS and H{_ 2}O. *)
val ratio_gs_cos_water : float

(** Ball--Berry equation of stomatal conductance.

    Calculates stomatal conductance of water vapor \[mol m{^ -2} s{^ -1}\]
    from:

    - [assim]: CO{_ 2} assimilation rate \[µmol m{^ -2} s{^ -1}\].
    - [co2]: Leaf surface CO{_ 2} mixing ratio \[µmol mol{^ -1}\].
    - [rh]: Leaf surface relative humidity, 0--1 \[-\].
    - [slope]: Ball--Berry slope \[-\].
    - [g_s_min]: Minimum stomatal conductance \[mol m{^ -2} s{^ -1}\].

    {i Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max \{m \dfrac{A_\mathrm{n} h_\mathrm{s}}{c_\mathrm{s}}, 0\}
        + g_\mathrm{s, min}
      \]
    %}

    {i Reference}

    Ball_1988

    Collatz_1991
 *)
val ball_berry :
  assim:float -> co2:float -> rh:float -> slope:float -> g_s_min:float -> float

val leuning : float -> float -> float -> float -> float -> float -> float

val total_cond_h2o : float -> float -> float

val total_cond_co2 : float -> float -> float -> float

val total_cond_cos : float -> float -> float -> float
