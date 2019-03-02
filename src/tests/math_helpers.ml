(* Tests for Leaf_pst.Math_helpers *)

open Test_utils
open Leaf_pst.Math_helpers

let test_polyval () =
  test_approx "test polyval #1" (polyval [1.; -7.; -4.; 5.] 2.) 11.0 ;
  test_approx "test polyval #2" (polyval [5.; -17.; -3.; 2.] (-3.)) (-25.0) ;
  test_approx "test polyval #3" (polyval [1.0] 5.0) 1.0 ;
  test_approx "test polyval #4" (polyval [] 42.) 0.0

let tests = [("test Leaf_pst.Math_helpers.polyval", `Quick, test_polyval)]
