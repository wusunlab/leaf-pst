(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** A collection of physical constants.

    {i References}

    - \[MNT16a\] Mohr, P. J., Newell, D. B., and Taylor, B. N. (2016). CODATA
      recommended values of the fundamental physical constants: 2014. {i Rev.
      Mod. Phys.}, 88, 035009, 1--73.
      {{: https://doi.org/10.1103/RevModPhys.88.035009} \[DOI\]}
    - \[MNT16b\] Mohr, P. J., Newell, D. B., and Taylor, B. N. (2016). CODATA
      recommended values of the fundamental physical constants: 2014. {i J.
      Phys. Chem. Ref. Data}, 45, 043102, 1--74.
      {{: https://doi.org/10.1063/1.4954402} \[DOI\]}
*)

(** Speed of light in the vacuum \[m s{^ -1}\]. *)
val speed_of_light : float

(** Planck's constant \[J s\]. *)
val planck_constant : float

(** Stefan--Boltzmann constant \[W m{^ -2} K{^ -4}\]. *)
val stefan_boltzmann_constant : float

(** Boltzmann constant \[J K{^ -1}\]. *)
val boltzmann_constant : float

(** Avogadro constant \[mol{^ -1}\]. *)
val avogadro_constant : float

(** Molar gas constant \[J mol{^ -1} K{^ -1}\]. *)
val molar_gas : float

(** Standard atmospheric pressure \[Pa\]. *)
val std_atmosphere : float

(** Standard gravity acceleration \[m s{^ -2}\]. *)
val grav_accel : float

(** Zero Celsius in Kelvin \[K\]. *)
val zero_celsius : float

(** Von Karman's constant \[-\]. *)
val von_karman_constant : float

(** Molar mass of water \[kg mol{^ -1}\]. *)
val molar_mass_water : float

(** Molar mass of CO{_ 2} \[kg mol{^ -1}\]. *)
val molar_mass_co2 : float

(** Molar mass of dry air \[kg mol{^ -1}\]. *)
val molar_mass_dryair : float
