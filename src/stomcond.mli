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

    {4 Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max \{m \dfrac{A_\mathrm{n} h_\mathrm{s}}{\chi_\mathrm{s, CO_2}} +
                 g_\mathrm{s, min},\ g_\mathrm{s, min}\}
      \]
      where $A_\mathrm{n}$ is the CO<sub>2</sub> assimilation rate,
      $h_\mathrm{s}$ is the leaf surface relative humidity,
      $\chi_\mathrm{s, CO_2}$ is the leaf surface CO<sub>2</sub> mixing ratio,
      and $g_\mathrm{s, min}$ is the minimum stomatal conductance.
    %}

    {4 References}

    - \[B88\] Ball, J. T. (1988). {i An analysis of stomatal conductance}. PhD
      thesis, Stanford University, Stanford, CA, USA.
      {{: https://www-legacy.dge.carnegiescience.edu/publications/berry/AnnRev2012/1988%20Ball.pdf} \[link\]}
    - \[CBGB91\] Collatz, G. J., Ball, J. T., Grivet, C., and Berry, J. A.
      (1991). Physiological and environmental regulation of stomatal
      conductance, photosynthesis and transpiration: a model that includes a
      laminar boundary layer. {i Agric. Forest Meteorol.}, 54, 107--136.
      {{: https://doi.org/10.1016/0168-1923(91)90002-8} \[DOI\]}
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

    {4 Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max \{m \dfrac{A_\mathrm{n}}{\chi_\mathrm{s, CO_2}}\cdot
                 \left(1 + \dfrac{D}{D_0}\right)^{-1} +
                 g_\mathrm{s, min},\ g_\mathrm{s, min}\}
      \]
      where $A_\mathrm{n}$ is the CO<sub>2</sub> assimilation rate,
      $D$ is the leaf-to-air vapor pressure deficit,
      $D_0$ is a parameter for vapor pressure deficit dependence,
      $\chi_\mathrm{s, CO_2}$ is the leaf surface CO<sub>2</sub> mixing ratio,
      and $g_\mathrm{s, min}$ is the minimum stomatal conductance.
    %}

    {4 References}

    - \[L95\] Leuning, R. (1995). A critical appraisal of a combined
      stomatal--photosynthesis model for C{_ 3} plants. {i Plant Cell
      Environ.}, 18, 339--355.
      {{: https://doi.org/10.1111/j.1365-3040.1995.tb00370.x} \[DOI\]}
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
    \[mol m{^ -2} s{^ -1}\] at a given leaf temperature [t_leaf] \[K\].
    [params] defines the baseline value and the temperature dependence of
    mesophyll conductance, which can be one of the three types: [Q10],
    [Arrhenius], and [Optimum] (see {!type:Types.temp_dep}).

    {4 References}

    - \[BPN02\] Bernacchi, C. J., Portis, A. R., Nakano, H., von Caemmerer, S.,
      and Long, S. P. (2002). Temperature response of mesophyll conductance.
      Implications for the determination of Rubisco enzyme kinetics and for
      limitations to photosynthesis in vivo. {i Plant Physiol.}, 130(4),
      1992--1998. {{: https://doi.org/10.1104/pp.008250} \[DOI\]}
 *)
val mesophyll_cond : params:temp_dep -> t_leaf:float -> float

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
