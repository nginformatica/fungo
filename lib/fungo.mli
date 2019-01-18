(** This module provides a set of functions to work with point-free programming
    and function composition in a Haskellish style.
    @author Marcelo Camargo *)

(** A predicate is a function from a value ['a] to a bool. *)
type 'a predicate =
  'a -> bool

(** The [K] combinator. Always returns the first given argument. *)
val always : 'a -> 'b -> 'a

(** Takes a value and applies a function to it.
    This function is also known as the [thrush] combinator. *)
val apply_to : 'a -> ('a -> 'b) -> 'b

(** A function which receives two predicates and a value and returns whether
    the two predicates pass. *)
val both : 'a predicate -> 'a predicate -> 'a -> bool

(** Takes a predicate function [f] and returns its complement (negation). *)
val complement : 'a predicate -> 'a -> bool

(** Function composition. *)
val compose : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c

(** Accepts a converging function and a pair of branching functions and returns
    a new function that receives a value and applies each branching function in
    the pair to it, them applies the converging function. *)
val converge : ('a -> 'b -> 'c) -> (('d -> 'a) * ('d -> 'b)) -> 'd -> 'c

(** A function which receives two predicates and returns whether any of the
    predicates pass. *)
val either : 'a predicate -> 'a predicate -> 'a -> bool

(** Flips the arguments of a binary function. *)
val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c

(** The identity function. *)
val id : 'a -> 'a

(** A function that always returns [true]. Use with {!whenever}. *)
val otherwise : 'a -> bool

(** Reverse function composition, applying from left to right. *)
val pipe : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c

(** Runs the given function with the supplied value, then returns it. *)
val tap : ('a -> unit) -> 'a -> 'a

(** Given a predicate function and a transformation, returns a function that
    receives a value and, if the value does not pass the predicate, returns
    the transformation applied to the value. Returns the identity when the value
    passes the predicate. It is the {!complement} of {!when_}. *)
val unless : 'a predicate -> ('a -> 'a) -> 'a -> 'a

(** Given a predicate function and a transformation, returns a function that
    receives a value and, if the value passe the predicate, returns the
    transformation applied to the value. Returns the identity when the value
    does not pass the predicate. It is the {!complement} of {!unless}. *)
val when_ : 'a predicate -> ('a -> 'a) -> 'a -> 'a

(** Receives a list of pairs of predicates and transformations and applies the
    left side of each pair to the given value until a predicate passes. When
    the predicate passes, returns the value transformed with the second function
    of the given pair. The [~otherwise] parameter specifies the default case
    when there are no matches. *)
val whenever
  :  ('a predicate * ('a -> 'b)) list
  -> otherwise : ('a -> 'b)
  -> 'a
  -> 'b

(** Infix operations over functions. *)
module Infix : sig
  (** Alias for function composition. *)
  val (<%) : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c

  (** Alias for reversed function composition. *)
  val (%>) : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c
end
