let test_bool msg expr = Alcotest.(check bool) msg true expr

let test_approx ?(rtol = sqrt Float.epsilon) msg v1 v2 =
  Alcotest.(check bool) msg true (abs_float ((v1 -. v2) /. v2) < rtol)
