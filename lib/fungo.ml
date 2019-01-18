type 'a predicate =
  'a -> bool

let always x _ = x

let apply_to x f = f x

let both f g x = f x && g x

let complement (f : 'a predicate) (x : 'a) : bool = not (f x)

let compose f g x = f (g x)

let converge f (g, h) x =
  f (g x) (h x)

let either f g x = f x || g x

let flip f first second = f second first

let id x = x

let otherwise _ = true

let pipe f g x = g (f x)

let tap f x =
  f x;
  x

let unless f g x =
  match f x with
  | false -> g x
  | true  -> x

let when_ f g x =
  match f x with
  | true  -> g x
  | false -> x

let whenever predicates ~otherwise x =
  let rec loop pending =
    match pending with
    | (f, g) :: _ when f x -> g x
    | _ :: tl -> loop tl
    | [] -> otherwise x in
  loop predicates

module Infix = struct
  let (<%) = compose
  let (%>) = pipe
end
