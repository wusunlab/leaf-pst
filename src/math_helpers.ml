(* Horner method for evaluation of polynomials *)
(* note: prefer fold_left for the benefit of tail recursion *)
let polyval coefs x =
  match coefs with
  | [] ->
      0.0
  | [c] ->
      c
  | _ ->
      let f c1 c2 = (c1 *. x) +. c2 in
      List.fold_left f 0.0 (List.rev coefs)
