(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Thermodynamics functions. *)

(** [c2k t] converts Celsius degree to Kelvin. *)
val c2k : float -> float

(** [k2c t] converts Kelvin to Celsius degree. *)
val k2c : float -> float

(** {2 Radiation} *)

(** [stefan_boltzman t] calculates the energy flux density from a blackbody
    \[W m{^ -2}\] of surface temperature [t] \[K\].

    {i Formula}

    {%html:
      \[
        F = \sigma_\text{S--B}\cdot T^4
      \]
    %}
 *)
val stefan_boltzmann : float -> float

(** {2 Air} *)

(** [air_molar t p] calculates the molar concentration of air \[mol m{^ -3}\]
    from temperature [t] \[K\] and pressure [p] \[Pa\]. *)
val air_molar : float -> float -> float

(** {2 Water} *)

(** [e_sat t] calculates saturation vapor pressure \[Pa\] of liquid water at
    temperature [t] \[K\]. *)
val e_sat : float -> float

(** [e_sat_deriv t] calculates the temperature derivative of saturation vapor
    pressure of liquid water \[Pa K{^ -1}\] at temperature [t] \[K\]. *)
val e_sat_deriv : float -> float

(** [vapor_deficit t rh] calculates water vapor pressure deficit \[Pa\] from
    temperature [t] \[K\] and relative humidity [rh] \[0--1\]. *)
val vapor_deficit : float -> float -> float

(** [vapor_mole_frac t p rh] calculates water vapor mole fraction
    \[mol mol{^ -1}\] from temperature [t] \[K\], pressure [p] \[Pa\], and
    relative humidity [rh] \[0--1\]. *)
val vapor_mole_frac : float -> float -> float -> float

(** [vapor_deficit_mole_frac t p rh] calculates water vapor deficit in mole
    fraction \[mol mol{^ -1}\] from temperature [t] \[K\], pressure [p] \[Pa\],
    and relative humidity [rh] \[0--1\]. *)
val vapor_deficit_mole_frac : float -> float -> float -> float
