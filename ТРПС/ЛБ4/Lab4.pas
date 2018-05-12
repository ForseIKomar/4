
{Для теста
 3  -1   -2       2
 4  -2   -3       1
 2   2    5       3   Результат: X1=1; X2=3; X3=-1
}
program V13;

uses
Timers;

const
  Nmax = 10;
var
  x1: integer;

procedure add;
begin
  inc(x1);
end;
var
  i, j, k, max, kx, ky, n, y, l, o: integer;
  eps: real;
  x, b, sw, s: array [1..Nmax] of real;
  a: array [1..Nmax, 1..Nmax] of real;

begin
  // Ввод n и max
  write('Количество уравнений : ');
  readln(n);
  write('Введите максимальное количество итераций: ');
  readln(max);
  writeln('Введите числа в матрицу и свободные члены: ');
  // Ввод матрицы
  eps := 0.01;
  for i := 1 to n do
    for j := 1 to n do
      read(a[i, j]);
  writeln;
  // Ввод массива b
  for i := 1 to n do 
  begin
    write('b', i, '=');
    readln(b[i]); 
  end;
  
  var t := new Timer(20, add);
  t.Start;
  for o := 1 to 20 do
  for l := 1 to 50000 do 
  begin
    for i := 1 to n do 
      x[i] := 0;
    k := 0;
    
    repeat
    k := k + 1;
    sw[1] := 0;
    for i := 1 to n do begin
      s[i] := b[i];
      for j := 1 to n do 
        s[i] := s[i] - a[i, j] * x[j];
      s[i] := s[i] / a[i, i];
      x[i] := s[i] + x[i];
      sw[1] := sw[1] + abs(s[i]);
    end;
    until (k >= max) or (sw[1] < eps);
  end;
  
  writeln('Time = ', x1*20, 'ms ');
  for i := 1 to n do 
    write('  x[', i, '] = ', x[i]:4:4);
  writeln;
  
  if k < max then 
    writeln('  k=', k)
  else 
    writeln('Сходимости нет');
  
end.