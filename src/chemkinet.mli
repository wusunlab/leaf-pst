(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wu.sun@ucla.edu>
 * License: MIT
 *)

(** A collection of basic functions of chemical kinetics. *)

val q10_fun : float -> float -> float
(**
    The {i Q}{_ 10} temperature dependence function of reaction rate.

    {3 Formula}

    {%html:
      \[
        \dfrac{k}{k_\mathrm{ref}} = \exp\left( Q_{10} \cdot
        \dfrac{T - T_\mathrm{ref}}{10\ \mathrm{K}} \right)
      \]
    %}

    {3 Arguments}

    - [temp] - Current temperature \[K\].
    - [temp_ref] - Reference temperature \[K\].
    - [q10] - The {i Q}{_ 10} value \[-\], i.e., enhancement ratio of the
      reaction rate if temperature increases by 10 K.

    {3 Returns}

    Ratio of the reaction rate at current temperature to that at the reference
    temperature [-].
 *)

val arrhenius : float -> float -> float -> float
val f_enzyme_temp_dep : float -> float -> float -> float -> float
val enzyme_temp_dep : float -> float -> float -> float -> float -> float
val enzyme_temp_opt : float -> float -> float -> float
