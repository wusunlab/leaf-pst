(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Photosynthesis functions.

    {4 References}

    - \[FvCB80\] Farquhar, G. D., von Caemmerer, S., and Berry, J. A. (1980). A
      biochemical model of photosynthetic CO{_ 2} assimilation in leaves of
      C{_ 3} species. {i Planta}, 149, 78--90.
      {{: https://doi.org/10.1007/bf00386231} \[DOI\]}
    - \[VCFB09\] Von Caemmerer, S., Farquhar, G., and Berry, J. (2009).
      Biochemical model of C{_ 3} photosynthesis. In Laisk, A., Nedbal, L. and
      Govindjee (eds.) {i Photosynthesis in silico} (pp. 209--230). Springer.
      {{: https://doi.org/10.1007/978-1-4020-9237-4_9} \[DOI\]}
 *)

open Leaf_pst_types

(** [electron_transport ~params ~ppfd ~t_leaf] calculates the potential
    electron transport rate \[µmol electrons m{^ -2} s{^ -1}\] from
    photosynthetic parameters [params], photosynthetically active radiation
    [ppfd] \[µmol photons m{^ -2} s{^ -1}\], and leaf temperature [t_leaf]
    \[K\].

    {4 Formula}

    {%html:
      \[
        I_\mathrm{PSII} = f_\mathrm{PSII}\cdot
          (1 - f_\mathrm{spec})\cdot f_\mathrm{abs}\cdot I_\mathrm{PAR}
      \]
      \[
        J = \dfrac{I_\mathrm{PSII} + J_\mathrm{max} -
                   \sqrt{\left(I_\mathrm{PSII} + J_\mathrm{max}\right)^2 -
                         4\theta\cdot I_\mathrm{PSII}\cdot J_\mathrm{max}}
                   }{2\theta}
      \]
    %}
 *)
val electron_transport :
  params:photosyn_params -> ppfd:float -> t_leaf:float -> float

(** [assim_C3 ~params ~co2_c ~ppfd ~t_leaf ~o2 ~p] calculates the actual
    photosynthetic assimilation rate \[µmol m{^ -2} s{^ -1}\] from
    photosynthetic parameters [params] and environmental variables:

    - [co2_c]: CO{_ 2} concentration at the RuBisCO carboxylation site
      \[µmol mol{^ -1}\].
    - [ppfd]: Photosynthetically active radiation
      \[µmol photons m{^ -2} s{^ -1}\].
    - [t_leaf]: Leaf temperature \[K\].
    - [o2]: O{_ 2} ambient concentration \[µmol mol{^ -1}\].
    - [p]: Ambient pressure \[Pa\]. *)
val assim_C3 :
     params:photosyn_params
  -> co2_c:float
  -> ppfd:float
  -> t_leaf:float
  -> o2:float
  -> p:float
  -> float
