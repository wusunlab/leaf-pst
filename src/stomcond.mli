(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Stomatal conductance functions. *)

open Leaf_pst_types

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

    {4 Reference}

    Ball_1988

    Collatz_1991
 *)
val ball_berry :
  assim:float -> co2:float -> rh:float -> slope:float -> g_s_min:float -> float

(** Leuning equation of stomatal conductance.

    Calculates stomatal conductance of water vapor \[mol m{^ -2} s{^ -1}\]
    from:

    - [assim]: CO{_ 2} assimilation rate \[µmol m{^ -2} s{^ -1}\].
    - [co2]: Leaf surface CO{_ 2} mixing ratio \[µmol mol{^ -1}\].
    - [vpd]: Leaf-to-air vapor pressure deficit \[Pa\].
    - [vpd_0]: A parameter for vapor pressure deficit dependence \[Pa\].
    - [slope]: Ball--Berry slope \[-\].
    - [g_s_min]: Minimum stomatal conductance \[mol m{^ -2} s{^ -1}\].

    {i Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max \{m \dfrac{A_\mathrm{n}}{c_\mathrm{s}}\cdot
                 \left(1 + \dfrac{D}{D_0}\right)^{-1}, 0\}
        + g_\mathrm{s, min}
      \]
    %}

    {4 Reference}

    Leuning_1995
 *)
val leuning :
     assim:float
  -> co2:float
  -> vpd:float
  -> vpd_0:float
  -> slope:float
  -> g_s_min:float
  -> float

(** [mesophyll_cond params t_leaf] calculates mesophyll conductance
    \[mol m{^ -2} s{^ -1}\] at a given leaf temperature [t_leaf] \[K\]. *)
val mesophyll_cond : params:photosyn_params -> t_leaf:float -> float

(** [total_cond_h2o g_bw g_sw] calculates total conductance of water vapor
    \[mol m{^ -2} s{^ -1}\] from boundary layer conductance [g_bw]
    \[mol m{^ -2} s{^ -1}\] and stomatal conductance [g_sw] \[mol m{^ -2}
    s{^ -1}\]. *)
val total_cond_h2o : float -> float -> float

(** [total_cond_co2 g_bw g_sw g_m] calculates total conductance of CO{_ 2}
    \[mol m{^ -2} s{^ -1}\] from boundary layer conductance of water vapor
    [g_bw] \[mol m{^ -2} s{^ -1}\], stomatal conductance of water vapor [g_sw]
    \[mol m{^ -2} s{^ -1}\], and mesophyll conductance [g_m] \[mol m{^ -2}
    s{^ -1}\]. *)
val total_cond_co2 : float -> float -> float -> float

(** [total_cond_cos g_bw g_sw g_m] calculates total conductance of COS
    \[mol m{^ -2} s{^ -1}\] from boundary layer conductance of water vapor
    [g_bw] \[mol m{^ -2} s{^ -1}\], stomatal conductance of water vapor [g_sw]
    \[mol m{^ -2} s{^ -1}\], and mesophyll conductance [g_m] \[mol m{^ -2}
    s{^ -1}\]. *)
val total_cond_cos : float -> float -> float -> float
