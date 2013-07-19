UNIT FastTrig;

(*******************************************************************

  Turbo-Pascal Unit for super fast trigonometric functions.
  (c) copyright 1990,91 by Klaus Hartnegg,
      H.v.Kleist-Str. 7, D-79331 Teningen, Germany.
      hartnegg@einstein.freinet.de
      Free for non-commercial use.


  SuperFastSin determines function value by lookup in tables (arrays)
  that get initialized on the first call to the function or by a
  explicit call to the initialization procedure.

  Accuracy is a function of memory that you allow to be used
  for the table.

  FastSin is 5 times faster than Turbo's sin.
  SuperFastSin is even 9.5 times faster but less accurate.
  (times measured with FTRIGDEM on a 25 MHz 80386)

  SuperFastSin simply looks up the nearest value in a table.
  FastSin uses taylor series of first order around 0.

***********************************************************************)


INTERFACE

type
  FPtr_1r_1r = function (x:real) : real;

var
  FastSin, SuperFastSin : FPtr_1r_1r;

{ the variable FastSin behaves like
Function FastSin          (x : real) : real; }

Function FastCos          (x : real) : real;
Function SuperFastCos     (x : real) : real;
Function FastTan          (x : real) : real;
Function FastCot          (x : real) : real;

Procedure Init;
{ this initialization will be called automatically upon the first
  use of one of the functions but can be called explicitely to prevent
  unexpected delay in the middle of your program. }


IMPLEMENTATION


const
  Resolution = 256;
  pi         = 3.1415926535897932385;
  Step       = pi / resolution;


var
  Sinus       : array[0..Resolution] of real;
  EndOfTaylor : integer;



const
  initialized : boolean = false;


{$F+}
Function FastSin1 (x : real) : real;
var i  : integer;
    s  : real;
    negativ : boolean;
begin
  negativ := (x < 0);
  s := abs (x * (Resolution / pi));
  i := trunc (s);
  if odd(i div Resolution) then negativ := not negativ;
  i := i mod Resolution;

  if ((i <= EndOfTaylor) or (i >= Resolution - EndOfTaylor))
{  and (abs (frac(s) - 0.5) > 0.25) } then begin
     x := abs (pi * frac (x / pi));
     if x > pi/2 then x := abs(pi - x);
     if negativ then FastSin1 := -X else FastSin1 := X;
  end
  else if negativ then FastSin1 := - Sinus[i]
  else Fastsin1 := Sinus[i];
end;



Function SuperFastSin1 (x : real) : real;
var i  : integer;
    s  : real;
    negativ : boolean;
begin
  i := trunc (x * ( Resolution / pi) );
  negativ := false;
  if i < 0 then begin
     negativ := true;
     i := -i;
  end;
  i := i mod (2 * Resolution);

  if i > Resolution then begin
     negativ := not negativ;
     i := i - Resolution;
  end;
  if negativ then SuperFastSin1 := - Sinus[i]
  else SuperFastSin1 := Sinus[i];
end;



Function FastCos (x:real) : real;
begin
  Fastcos := Fastsin (x + pi/2);
end;


Function SuperFastCos (x:real) : real;
begin
  SuperFastcos := SuperFastsin (x + pi/2);
end;


Function FastTan (x:real) : real;
begin
  FastTan := FastSin(x) / FastCos(x);
end;


Function FastCot (x:real) : real;
begin
  FastCot := FastCos(x) / FastSin(x);
end;



Procedure Init;
var x : real;
    i : integer;
begin
  if @FastSin = @FastSin1 then exit; { is already installed }

  x := Step / 2;
  for i := 0 to Resolution do begin
     Sinus[i] := sin (x);
     x := x + Step;
  end;

  EndOfTaylor := 0;
  x := Step / 2;
  while abs( x - sin(x)) < Step / 2 do begin
     inc (EndOfTaylor);
     x := x + Step;
  end;
  dec (EndOfTaylor,2);

  FastSin := FastSin1;
  SuperFastSin := SuperFastSin1;
end;



Function FastSin_Init (x:real) : real;
begin
  Init;
  FastSin_Init := FastSin(x);
end;


Function SuperFastSin_Init (x:real) : real;
begin
  Init;
  SuperFastSin_Init := SuperFastSin(x);
end;



BEGIN
  FastSin := FastSin_Init;
  SuperFastSin := SuperFastSin_init;
END.
