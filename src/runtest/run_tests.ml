(* Run all test suites in the project. *)

let test_suites : unit Alcotest.test list =
  [("Constants", Leaf_pst_tests.Constants.tests)]

let () = Alcotest.run "leaf_pst" test_suites
