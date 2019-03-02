let test_bool msg expr = Alcotest.(check bool) msg true expr

let test_approx ?(rtol = sqrt Float.epsilon) msg v1 v2 =
  let res =
    if v2 <> 0.0 then abs_float ((v1 -. v2) /. v2) < rtol
    else abs_float v1 < rtol
  in
  Alcotest.(check bool) msg true res
