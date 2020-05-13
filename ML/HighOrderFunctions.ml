- fun Power(m,n) = if m = 0 then 1 else n * Power(m-1,n);
> val Power = fn : int * int -> int
- Power(4,3);
> val it = 81 : int
- fun power m n = if m = 0 then 1 else n * power (m - 1) n;
> val power = fn : int -> int -> int
- power 4 3;
> val it = 81 : int
- power 3;           
> val it = fn : int -> int
- val cube = power 3;
> val cube = fn : int -> int
- cube 4;
> val it = 64 : int
- fun summation f n = if n = 1 then f 1 else f n + summation f (n - 1);
> val summation = fn : (int -> int) -> int -> int
- val newSumOfCube = summation cube;
> val newSumOfCube = fn : int -> int
- newSumOfCube 3;
> val it = 36 : int
- val sumOfSquare = summation (power 2);
> val sumOfSquare = fn : int -> int
- sumOfSquare 3;
> val it = 14 : int
- summation (power 4) 3;
> val it = 98 : int
- fn x => x = 1;
> val it = fn : int -> bool
- (fn x => x + 1) 3 * 10;
> val it = 40 : int
- fun f n m = (fib n) mod m = 0;
