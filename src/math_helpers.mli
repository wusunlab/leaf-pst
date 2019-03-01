(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Math helper functions. *)

(** [polyval coefs x] evaluate a polynomial defined by coefficients [coefs] at
    [x]. The coefficients are given in ascending order. *)
val polyval : float list -> float -> float
