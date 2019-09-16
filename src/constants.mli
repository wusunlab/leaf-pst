(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Physical constants.

    {4 References}

    CODATA 2018 values

    - \[MNT16a\] Mohr, P. J., Newell, D. B., and Taylor, B. N. (2016). CODATA
      recommended values of the fundamental physical constants: 2014. {i Rev.
      Mod. Phys.}, 88, 035009, 1--73.
      {{: https://doi.org/10.1103/RevModPhys.88.035009} \[DOI\]}
    - \[MNT16b\] Mohr, P. J., Newell, D. B., and Taylor, B. N. (2016). CODATA
      recommended values of the fundamental physical constants: 2014. {i J.
      Phys. Chem. Ref. Data}, 45, 043102, 1--74.
      {{: https://doi.org/10.1063/1.4954402} \[DOI\]}
    - \[MNTT18\] Mohr, P. J., Newell, D. B., Taylor, B. N., and Tiesinga, E.
      (2018). Data and analysis for the CODATA 2017 special fundamental
      constants adjustment. {i Metrologia}, 55, 125--146.
      {{: https://doi.org/10.1088/1681-7575/aa99bc} \[DOI\]}

    Molar masses of molecules

    - \[CRC\] Rumble, J. (eds.) (2017). {i CRC Handbook of Chemistry and
      Physics} (98th ed.). CRC Press, Boca Raton, FL, USA. ISBN: 9781498784542.
      {{: http://hbcponline.com/faces/contents/ContentsSearch.xhtml} \[link\]}
 *)

(** Speed of light in the vacuum, $c$ \[m s{^ -1}\]. *)
val speed_of_light : float

(** Planck's constant, $h$ \[J s\]. *)
val planck_constant : float

(** Stefan--Boltzmann constant, $\sigma$ \[W m{^ -2} K{^ -4}\]. *)
val stefan_boltzmann_constant : float

(** Boltzmann constant, $k$ \[J K{^ -1}\]. *)
val boltzmann_constant : float

(** Avogadro constant, $N_\mathrm\{A\}$ \[mol{^ -1}\]. *)
val avogadro_constant : float

(** Molar gas constant, $R := N_\mathrm\{A\}k$ \[J mol{^ -1} K{^ -1}\]. *)
val molar_gas : float

(** Standard atmospheric pressure \[Pa\]. *)
val std_atmosphere : float

(** Standard gravity acceleration, $g$ \[m s{^ -2}\]. *)
val grav_accel : float

(** Zero Celsius in Kelvin \[K\]. *)
val zero_celsius : float

(** Von Karman's constant, $\kappa$ \[-\]. *)
val von_karman_constant : float

(** Molar mass of water, $M_\mathrm\{H_2O\}$ \[kg mol{^ -1}\]. *)
val molar_mass_water : float

(** Molar mass of CO{_ 2}, $M_\mathrm\{CO_2\}$ \[kg mol{^ -1}\]. *)
val molar_mass_co2 : float

(** Molar mass of dry air, $M_\mathrm\{d\}$ \[kg mol{^ -1}\]. *)
val molar_mass_dryair : float
