(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Leaf energy balance module.

    {4 References}

    - \[CN98\] Campbell, G. S. and Norman, J. M. (1998). {i An Introduction to
      Environmental Biophysics} (2nd ed.), pp. 99--101. Springer
      Science+Business Media, New York, NY, USA.
    - \[B08\] Bonan, G. (2008). {i Ecological Climatology: Concepts and
      Applications}, pp. 229--232. Cambridge University Press, New York, NY,
      USA.
    - \[MHH84\] Meek, D. W., Hatfield, J. L., Howell, T. A., Idso, S. B., and
      Reginato, R. J. (1984). A generalized relationship between
      photosynthetically active radiation and solar radiation. {i Agron. J.},
      76(6), 939--945.
      {{: https://doi.org/10.2134/agronj1984.00021962007600060018x} \[DOI\]}
 *)

(** [bl_cond_heat ~t_air ~p ~rh ~wind_speed ~d_leaf] calculates the leaf
    boundary layer conductance for heat transfer \[mol m{^ -2} s{^ -1}\] from:

    - [t_air]: Air temperature \[K\].
    - [p]: Ambient pressure \[Pa\].
    - [rh]: Relative humidity \[0--1\].
    - [wind_speed]: Wind speed \[m s{^ -1}\].
    - [d_leaf]: Characteristic length of leaf size \[m\].

    {4 Formula}

    {%html:
      \[
        g_\mathrm{b,H} = \dfrac{1.4\,\mathrm{Nu} \cdot c_\mathrm{a} \cdot
                                D_\mathrm{H} }{d}
      \]
      where
      \[
        \mathrm{Nu} = 0.664\,\mathrm{Re}^{1/2}\,\mathrm{Pr}^{1/3}
      \]
      is the Nusselt number, $c_\mathrm{a}$ [mol m<sup>-3</sup>] is the molar
      concentration of air, and $D_\mathrm{H}$ [m<sup>2</sup> s<sup>-1</sup>]
      is the thermal diffusivity of air.
    %}
 *)
val bl_cond_heat :
     t_air:float
  -> p:float
  -> rh:float
  -> wind_speed:float
  -> d_leaf:float
  -> float

(** [bl_cond_vapor ~t_air ~p ~rh ~wind_speed ~d_leaf] calculates the leaf
    boundary layer conductance to water vapor \[mol m{^ -2} s{^ -1}\] from:

    - [t_air]: Air temperature \[K\].
    - [p]: Ambient pressure \[Pa\].
    - [rh]: Relative humidity \[0--1\].
    - [wind_speed]: Wind speed \[m s{^ -1}\].
    - [d_leaf]: Characteristic length for leaf size \[m\].

    {4 Formula}

    {%html:
      \[
        g_\mathrm{b,W} = \dfrac{
          1.4\cdot 0.664\,\mathrm{Re}^{1/2}\,\mathrm{Sc}^{1/3}\cdot
          c_\mathrm{a}\cdot D_\mathrm{W}}{d}
      \]
      where
      \[
        \mathrm{Sc} = \nu_\mathrm{a} / D_\mathrm{W}
      \]
      is the Schmidt number, $\nu_\mathrm{a}$ [m<sup>2</sup> s<sup>-1</sup>] is
      the kinematic viscosity of air, $c_\mathrm{a}$ [mol m<sup>-3</sup>] is
      the molar concentration of air, and $D_\mathrm{W}$ [m<sup>2</sup>
      s<sup>-1</sup>] is the diffusivity of water vapor in air.
    %}
 *)
val bl_cond_vapor :
     t_air:float
  -> p:float
  -> rh:float
  -> wind_speed:float
  -> d_leaf:float
  -> float

(** [ppfd_to_shortwave ppfd] calculates the incoming shortwave radiation
    \[W m{^ -2}\] from photosynthetically active radiation flux [ppfd]
    \[µmol m{^ -2} s{^ -1}\] using an empirical relationship calibrated to
    sites in the US. *)
val ppfd_to_shortwave : float -> float

(** [sensible_heat ~t_leaf ~t_air ~p ~rh ~g_bh] calculates the sensible heat
    flux density \[W m{^ -2}\] at the leaf surface from:

    - [t_leaf]: Leaf temperature \[K\].
    - [t_air]: Air temperature \[K\].
    - [p]: Ambient pressure \[Pa\].
    - [rh]: Relative humidity \[0--1\].
    - [g_bh]: Boundary layer conductance for heat transfer \[mol m{^ -2}
      s{^ -1}\].

    {4 Formula}

    {%html:
      \[
        \mathrm{SH} = 2 g_\mathrm{b,H} \cdot c_{p,\mathrm{a}} \cdot
                      \left(T_\mathrm{leaf} - T_\mathrm{air}\right)
      \]
      where $c_{p,\mathrm{a}}$ [J mol<sup>-1</sup> K<sup>-1</sup>] is the
      isobaric specific heat capacity of air.
    %}
 *)
val sensible_heat :
  t_leaf:float -> t_air:float -> p:float -> rh:float -> g_bh:float -> float

(** [leaf_vapor_deficit t_leaf t_air rh] calculates leaf-to-air vapor pressure
    deficit \[Pa\] from leaf temperature [t_leaf] \[K\], air temperature
    [t_air] \[K\], and relative humidity [rh] \[0--1\]. *)
val leaf_vapor_deficit : float -> float -> float -> float

(** [water_flux ~vpd_leaf ~p ~g_bw ~g_sw] calculates leaf water flux density
    \[mol m{^ -2} s{^ -1}\] from:

    - [vpd_leaf]: Leaf-to-air vapor pressure deficit \[Pa\].
    - [p]: Ambient pressure \[Pa\].
    - [g_bw]: Boundary layer conductance to water vapor \[mol m{^ -2}
      s{^ -1}\].
    - [g_sw]: Stomatal conductance of water vapor \[mol m{^ -2} s{^ -1}\].

    {4 Formula}

    {%html:
      \[
        F_\mathrm{H_2O} = g_\mathrm{tot,W} \cdot \dfrac{D_\mathrm{\ell}}{p}
      \]
      where
      \[
        g_\mathrm{tot,W} = \left(
          g_\mathrm{b,W}^{-1} + g_\mathrm{s,W}^{-1}\right)^{-1}
      \]
      and $D_\mathrm{\ell}$ [Pa] is the leaf-to-air water vapor deficit.
    %}
 *)
val water_flux : vpd_leaf:float -> p:float -> g_bw:float -> g_sw:float -> float

(** [latent_heat ~t_leaf ~vpd_leaf ~p ~g_bw ~g_sw] calculates latent heat
    flux density \[W m{^ -2}\] at the leaf surface from:

    - [t_leaf]: Leaf temperature \[K\].
    - [vpd_leaf]: Leaf-to-air vapor pressure deficit \[Pa\].
    - [p]: Ambient pressure \[Pa\].
    - [g_bw]: Boundary layer conductance to water vapor \[mol m{^ -2}
      s{^ -1}\].
    - [g_sw]: Stomatal conductance of water vapor \[mol m{^ -2} s{^ -1}\].

    {4 Formula}

    {%html:
      \[
        \mathrm{LE} = L_\mathrm{v}\cdot g_\mathrm{tot,W}\cdot
          \dfrac{D_\mathrm{\ell}}{p}
      \]
      where $L_\mathrm{v}$ is the latent heat of vaporization of water [J
      mol<sup>-1</sup>], $g_\mathrm{tot,W}$ [mol m<sup>-2</sup> s<sup>-1</sup>]
      is the total conductance to water vapor,
      \[
        g_\mathrm{tot,W} = \left(
          g_\mathrm{b,W}^{-1} + g_\mathrm{s,W}^{-1}\right)^{-1}
      \]
      and $D_\mathrm{\ell}$ [Pa] is the leaf-to-air water vapor deficit.
    %}
 *)
val latent_heat :
     t_leaf:float
  -> vpd_leaf:float
  -> p:float
  -> g_bw:float
  -> g_sw:float
  -> float

(** [energy_imbalance ~t_leaf ~t_air ~p ~rh ~rad_sw ~wind_speed ~d_leaf
    ~em_leaf ~g_sw] calculates the imbalance of energy transfer at the leaf
    surface \[W m{^ -2}\] from:

    - [t_leaf]: Leaf temperature \[K\].
    - [t_air]: Air temperature \[K\].
    - [p]: Ambient pressure \[Pa\].
    - [rh]: Relative humidity \[0--1\].
    - [rad_sw]: Shortwave radiation flux density \[W m{^ -2}\].
    - [wind_speed]: Wind speed \[m s{^ -1}\].

    {4 Formula}

    {%html:
      \[
        \Delta E = R_\mathrm{net} - \mathrm{SH} - \mathrm{LE}
      \]
      where $R_\mathrm{net}$ [W m<sup>-2</sup>] is the net balance of
      radiation, $\mathrm{SH}$ [W m<sup>-2</sup>] is the sensible heat flux
      density, and $\mathrm{LE}$ [W m<sup>-2</sup>] is the latent heat flux
      density.
    %}

    {4 Note}

    This function is used as a constraint for solving the leaf temperature.
 *)
val energy_imbalance :
     t_leaf:float
  -> t_air:float
  -> p:float
  -> rh:float
  -> rad_sw:float
  -> wind_speed:float
  -> d_leaf:float
  -> em_leaf:float
  -> g_sw:float
  -> float
