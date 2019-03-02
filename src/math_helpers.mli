(* leaf_pst: A coupled photosynthesis--stomatal conductance--temperature model
 * Copyright (c) 2019 Wu Sun <wusun@protonmail.com>
 * License: MIT
 *)

(** Math helper functions. *)

(** [polyval coefs x] evaluates a polynomial defined by coefficients [coefs] at
    [x] using Horner's method of $O(n)$ time complexity. The coefficients are
    given in ascending order. For example, [polyval [2.; -3.; 1.] 2.0] means to
    evaluate the polynomial $f(x) = 2 - 3x + x^2$ at $x = 2$.

    {4 References}

    - \[H02\] Higham, N. J. (2002). {i Accuracy and Stability of Numerical
      Algorithms} (2nd ed.) (pp. 94--96). Philadelphia, PA: SIAM.
 *)
val polyval : float list -> float -> float
