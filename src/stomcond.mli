(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Stomatal conductance functions. *)

open Leaf_pst_types

(** Ratio between boundary layer conductances of H{_ 2}O and CO{_ 2}. *)
val ratio_gb_co2 : float

(** Ratio between stomatal conductances of H{_ 2}O and CO{_ 2}. *)
val ratio_gs_co2 : float

(** Ratio between boundary layer conductances of H{_ 2}O and COS. *)
val ratio_gb_cos : float

(** Ratio between stomatal conductances of H{_ 2}O and COS. *)
val ratio_gs_cos : float

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
        = \max\left\{
          m \dfrac{A_\mathrm{n} h_\mathrm{s}}{\chi_\mathrm{s, CO_2}} +
          g_\mathrm{s, min},\ g_\mathrm{s, min}\right\}
      \]
      where $A_\mathrm{n}$ [µmol m<sup>-2</sup> s<sup>-1</sup>] is the net
      CO<sub>2</sub> assimilation rate, $\chi_\mathrm{s, CO_2}$
      [µmol mol<sup>-1</sup>] is the leaf surface CO<sub>2</sub> mixing ratio,
      $h_\mathrm{s}$ (dimensionless) is the leaf surface relative humidity, $m$
      is the dimensionless Ball--Berry slope, and $g_\mathrm{s, min}$
      [mol m<sup>-2</sup> s<sup>-1</sup>] is the minimum stomatal conductance.
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
    - [slope]: A slope parameter \[-\].
    - [g_s_min]: Minimum stomatal conductance \[mol m{^ -2} s{^ -1}\].

    {4 Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max\left\{
          m \dfrac{A_\mathrm{n}}{\chi_\mathrm{s, CO_2}}\cdot
          \left(1 + \dfrac{D}{D_0}\right)^{-1} +
          g_\mathrm{s, min},\ g_\mathrm{s, min}\right\}
      \]
      where $A_\mathrm{n}$ [µmol m<sup>-2</sup> s<sup>-1</sup>] is the net
      CO<sub>2</sub> assimilation rate, $\chi_\mathrm{s, CO_2}$
      [µmol mol<sup>-1</sup>] is the leaf surface CO<sub>2</sub> mixing ratio,
      $D$ [Pa] is the leaf-to-air vapor pressure deficit,
      $D_0$ [Pa] is a parameter for vapor pressure deficit dependence,
      $m$ is a dimensionless slope parameter, and $g_\mathrm{s, min}$
      [mol m<sup>-2</sup> s<sup>-1</sup>] is the minimum stomatal conductance.
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

(** Medlyn equation of stomatal conductance.

    Calculates stomatal conductance of water vapor \[mol m{^ -2} s{^ -1}\]
    from:

    - [assim]: CO{_ 2} assimilation rate \[µmol m{^ -2} s{^ -1}\].
    - [co2]: Leaf surface CO{_ 2} mixing ratio \[µmol mol{^ -1}\].
    - [vpd]: Leaf-to-air vapor pressure deficit \[Pa\].
    - [slope]: A slope parameter \[Pa{^ 1/2}\].
    - [g_s_min]: Minimum stomatal conductance \[mol m{^ -2} s{^ -1}\].

    Compared with Ball--Berry and Leuning equations, the Medlyn equation is
    more consistent with the optimality-based theory of stomatal conductance.

    {4 Formula}

    {%html:
      \[
        g_\mathrm{s}
        = \max\left\{
          R_\mathrm{W-S}\left(1 + \dfrac{m}{\sqrt{D}}\right)
          \dfrac{A_\mathrm{n}}{\chi_\mathrm{s, CO_2}} +
          g_\mathrm{s, min},\ g_\mathrm{s, min}\right\}
      \]
      where $R_\mathrm{W-S} = 1.6$ is the ratio of diffusivities of water and
      CO<sub>2</sub>, $A_\mathrm{n}$ [µmol m<sup>-2</sup> s<sup>-1</sup>] is
      the net CO<sub>2</sub> assimilation rate, $\chi_\mathrm{s, CO_2}$
      [µmol mol<sup>-1</sup>] is the leaf surface CO<sub>2</sub> mixing ratio,
      $D$ [Pa] is the leaf-to-air vapor pressure deficit, $m$
      [Pa<sup>1/2</sup>] is a slope parameter, and $g_\mathrm{s, min}$
      [mol m<sup>-2</sup> s<sup>-1</sup>] is the minimum stomatal conductance.
    %}

    {4 References}

    - \[MDE11\] Medlyn, B. E., Duursma, R. A., Eamus, D., Ellsworth, D. S.,
      Prentice, I. C., Barton, C. V. M., Crous, K. Y., De Angelis, P., Freeman,
      M., and Wingate, L. (2011). Reconciling the optimal and empirical
      approaches to modelling stomatal conductance: {i Glob. Change Biol.},
      17(6), 2134--2144.
      {{: https://doi.org/10.1111/j.1365-2486.2010.02375.x} \[DOI\]}
 *)
val medlyn :
     assim:float
  -> co2:float
  -> vpd:float
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
