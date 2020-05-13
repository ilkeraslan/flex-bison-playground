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
