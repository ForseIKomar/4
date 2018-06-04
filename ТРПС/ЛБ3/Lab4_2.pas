{Для теста
 3  -1   -2       2
 4  -2   -3       1
 2   2    5       3   Результат: X1=1; X2=3; X3=-1
}
program V13;

uses
Timers;
  
var
  x1: integer;

procedure add;
begin
  inc(x1);
end;

var
  i, j, k, o, l: word;
  max, n: integer;
  eps, sw, s: real;
  x, b: array of real;
  a: array of array of real;

begin
  // Ввод n и max
  write('Количество уравнений : ');
  readln(n);
  SetLength(a, n);
  SetLength(b, n);
  SetLength(x, n);
  for i := 0 to n - 1 do
    SetLength(a[i], n);
  write('Введите максимальное количество итераций: ');
  readln(max);
  writeln('Введите числа в матрицу и свободные члены: ');
  // Ввод матрицы
  eps := 0.01;
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do 
    begin
      write('a', i + 1, j + 1, '=');
      readln(a[i, j]);
    end;
  writeln;
  // Ввод массива b
  for i := 0 to n - 1 do 
  begin
    write('b', i, '=');
    readln(b[i]); 
  end;
  
  var t := new Timer(20, add);
  for o := 1 to 20 do
  for l := 1 to 50000 do 
  begin
    for i := 0 to n - 1 do 
      x[i] := 0;
    k := 0;
    
    t.Start;
    repeat
      k := k + 1;
      sw := 0;
      for i := 0 to n - 1 do 
      begin
        s := b[i];
        for j := 0 to n - 1 do 
          s := s - a[i, j] * x[j];
        s := s / a[i, i];
        x[i] := s + x[i];
        sw := sw + abs(s);
      end;
    until (k >= max) or (sw < eps);
  end;
  
  writeln('Time = ', x1*20, 'ms ');
  for i := 0 to n - 1 do 
    write('  x[', i, '] = ', x[i]:4:4);
  writeln;
  
  if k < max then 
    writeln('  k=', k)
  else 
    writeln('Сходимости нет');
  
  writeln(' x=', x);
  
end.