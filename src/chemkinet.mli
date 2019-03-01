(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Basic functions of chemical kinetics. *)

open Leaf_pst_types

(** [q10_fun q10 t_ref t] calculates the ratio of reaction rate at temperature
    [t] \[K\] to that at a reference temperature [t_ref] \[K\] from the
    {i Q}{_ 10} function defined by [q10].

    {i Formula}

    {%html:
      \[
        \dfrac{k}{k_\mathrm{ref}} = Q_{10}^{\vartheta}\quad\text{where}\quad
        \vartheta = \dfrac{T - T_\mathrm{ref}}{10\ \mathrm{K}}
      \]
    %}
 *)
val q10_fun : float -> float -> float -> float

(** [arrhenius e_act t_ref t] calculates the ratio of reaction rate at
    temperature [t] \[K\] to that at a reference temperature [t_ref] \[K\] from
    the Arrhenius function with an activation energy [e_act].

    {i Formula}

    {%html:
      \[
        \dfrac{k}{k_\mathrm{ref}} = \exp\left[
          -\dfrac{E_\mathrm{act}}{R} \cdot
          \left(\dfrac{1}{T} - \dfrac{1}{T_\mathrm{ref}}\right)\right]
      \]
    %}
 *)
val arrhenius : float -> float -> float -> float

(** [enzyme_temp_dep delta_G_a delta_H_d delta_S_d t_ref t] calculates the
    ratio of reaction rate at temperature [t] \[K\] to that at a reference
    temperature [t_ref] \[K\] for an enzyme reaction with a temperature
    optimum. The temperature dependence of the enzyme reaction is defined by
    the three energetic parameter:

    - [delta_G_a]: The standard Gibbs free energy of activation of the active
      state of the enzyme \[J mol{^ -1}\].
    - [delta_H_d]: The standard enthalpy change when the enzyme switches from
      the active to the deactivated state \[J mol{^ -1}\].
    - [delta_S_d]: The standard entropy change when the enzyme switches from
      the active to the deactivated state \[J mol{^ -1} K{^ -1}\].

    {i Formula}

    {%html:
      \[
        \dfrac{V_\mathrm{max}(T)}{V_\mathrm{max}(T_\mathrm{ref})} =
        \dfrac{f(T)}{f(T_\mathrm{ref})}\quad\text{where}\quad f(T) =
        \dfrac{T \exp\left(-\dfrac{\Delta G_\mathrm{a}}{R T}\right)}{1 +
        \exp\left( -\dfrac{\Delta H_\mathrm{d} - T\Delta
        S_\mathrm{d}}{RT}\right)}
      \]
    %}

    {i References}

    - Johnson, F. H., Eyring, H., and Williams, R. W. (1942). The nature of
      enzyme inhibitions in bacterial luminescence: sulfanilamide, urethane,
      temperature and pressure. {i J. Cellul. Comparat. Physiol.}, 20(3),
      247--268. {{: https://doi.org/10.1002/jcp.1030200302} \[DOI\]}
    - Sharpe, P. J. H. and DeMichele, D. W. (1977). Reaction kinetics of
      poikilotherm development. {i J. Theoret. Biol.}, 64(4), 649--670.
      {{: https://doi.org/10.1016/0022-5193(77)90265-X} \[DOI\]}
    - Peterson, M. E., Eisenthal, R., Danson, M. J., Spence, A., and Daniel, R.
      M. (2004). A new intrinsic thermal parameter for enzymes reveals true
      temperature optima. {i J. Biol. Chem.}, 279(20), 20,717--20,722.
      {{: https://doi.org/10.1074/jbc.m309143200} \[DOI\]}
 *)
val enzyme_temp_dep : float -> float -> float -> float -> float -> float

(** [enzyme_temp_opt delta_G_a delta_H_d delta_S_d] calculates the approximate
    temperature optimum of an enzyme reaction from energetic parameters (see
    {!val: enzyme_temp_dep} for a description of them).

    {i Formula}

    {%html:
      \[
        T_\mathrm{opt} = \dfrac{\Delta H_\mathrm{d}}{
          \Delta S_\mathrm{d}
          + R\ln \left(\Delta H_\mathrm{d} / \Delta G_\mathrm{a} - 1 \right)}
      \]
    %}
 *)
val enzyme_temp_opt : float -> float -> float -> float

(** [eval_temp_dep params t] evaluates the enzyme reaction rate at temperature
    [t] \[K\]. The temperature dependence of the reaction is characterized by
    [params]. *)
val eval_temp_dep : temp_dep -> float -> float
