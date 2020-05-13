- let
	  val x = 3
  in
	  (fn x => x + 1) x
  end;
> val it = 4 : int

- val foo = 1;
> val foo = 1 : int
- val bar = foo + 1;
> val bar = 2 : int
- val foo = bar + 1 and bar = foo + 1;
> val foo = 3 : int
  val bar = 2 : int
  
(* Static values are crystalized when the function is defined *)
- val foobar = 10;
> val foobar = 10 : int
- val barbaz = 20;
> val barbaz = 20 : int
- fun f foobar = foobar + barbaz;
> val f = fn : int -> int
- f 3;
> val it = 23 : int
- val barbaz = 999;
> val barbaz = 999 : int
- f 3;
> val it = 23 : int

(* Operator priority *)
- infix 6 + -;
> infix 6 +
  infix 6 -
- infix 7 * / ;
> infix 7 *
  infix 7 /
- infix 8 Power;
> infix 8 Power
- 2 Power 3 + 8;
> val it = 17 : int
- op Power (2,3);
> val it = 9 : int
