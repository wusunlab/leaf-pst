(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Transfer coefficients for momentum, heat, and mass.

    {4 References}

    - \[T08\] Tsilingiris, P. T. (2008). Thermophysical and transport
      properties of humid air at temperature range between 0 and 100°C.
      {i Energy Conversion and Management}, 49(5), 1098--1110.
      {{: https://doi.org/10.1016/j.enconman.2007.09.015} \[DOI\]}
    - \[M98\] Massman, W. J. (1998). A review of the molecular diffusivities of
      H{_ 2}O, CO{_ 2}, CH{_ 4}, CO, O{_ 3}, SO{_ 2}, NH{_ 3}, N{_ 2}O, NO, and
      NO{_ 2} in air, O{_ 2} and N{_ 2} near STP. {i Atmos. Environ.}, 32(6),
      1111--1127. {{: https://doi.org/10.1016/S1352-2310(97)00391-9} \[DOI\]}
 *)

(** {2 Momentum} *)

(** [dyn_visc_dryair t] calculates the dynamic viscosity of dry air
    \[kg m{^ -1} s{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 250 and 600 K.

    {4 Note}

    The influence of pressure is not considered because it is negligible when
    the pressure is smaller than a few MPa.
 *)
val dyn_visc_dryair : float -> float

(** [dyn_visc_vapor t] calculates the dynamic viscosity of water vapor
    \[kg m{^ -1} s{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 250 and 600 K.

    {4 Note}

    The influence of pressure is not considered because it is negligible when
    the pressure is smaller than a few MPa.
 *)
val dyn_visc_vapor : float -> float

(** [dyn_visc_moistair t p rh] calculates the dynamic viscosity of moist air
    \[kg m{^ -1} s{^ -1}\] from temperature [t] \[K\], pressure [p] \[Pa\], and
    relative humidity [rh] \[0--1\]. *)
val dyn_visc_moistair : float -> float -> float -> float

(** {2 Heat} *)

(** [therm_cond_dryair t] calculates the thermal conductivity of dry air
    \[W m{^ -1} K{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 250 and 1050 K. *)
val therm_cond_dryair : float -> float

(** [heat_cap_dryair t] calculates the isobaric heat capacity of dry air
    \[J mol{^ -1} K{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 250 and 1050 K. *)
val heat_cap_dryair : float -> float

(** [therm_cond_vapor t] calculates the themal conductivity of water vapor
    \[W m{^ -1} K{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 273 and 393 K. *)
val therm_cond_vapor : float -> float

(** [heat_cap_vapor t] calculates the isobaric heat capacity of water vapor
    \[J mol{^ -1} K{^ -1}\] from temperature [t] \[K\]. The applicable range is
    between 273 and 393 K. *)
val heat_cap_vapor : float -> float

(** [therm_cond_moistair t p rh] calculates the thermal conductivity of moist
    air \[W m{^ -1} K{^ -1}\] from temperature [t] \[K\], pressure [p] \[Pa\],
    and relative humidity [rh] \[0--1\]. *)
val therm_cond_moistair : float -> float -> float -> float

(** [heat_cap_moistair t p rh] calculates the isobaric heat capacity of moist
    air \[J mol{^ -1} K{^ -1}\] from temperature [t] \[K\], pressure [p]
    \[Pa\], and relative humidity [rh] \[0--1\]. *)
val heat_cap_moistair : float -> float -> float -> float

(** [heat_cap_mass_moistair t p rh] calculates the isobaric heat capacity
    (per unit mass) of moist air \[J kg{^ -1} K{^ -1}\] from temperature [t]
    \[K\], pressure [p] \[Pa\], and relative humidity [rh] \[0--1\]. *)
val heat_cap_mass_moistair : float -> float -> float -> float

(** [therm_diff_moistair t p rh] calculates the thermal diffusivity of moist
    air \[m{^ 2} s{^ -1}\] from temperature [t] \[K\], pressure [p] \[Pa\], and
    relative humidity [rh] \[0--1\]. *)
val therm_diff_moistair : float -> float -> float -> float

(** [prandtl t p rh] calculates the Prandtl number of moist air from
    temperature [t] \[K\], pressure [p] \[Pa\], and relative humidity [rh]
    \[0--1\]. *)
val prandtl : float -> float -> float -> float

(** {2 Mass} *)

(** [diffus_vapor t p] calculate the diffusivity of water vapor in air
    \[m{^ 2} s{^ -1}\] from temperature [t] \[K\] and pressure [p] \[Pa\]. *)
val diffus_vapor : float -> float -> float
