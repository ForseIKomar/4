uses
GraphAbc;

const
  dx: array[0..7] of integer = (1, 2, 2, 1, -1, -2, -2, -1);
  dy: array[0..7] of integer = (2, 1, -1, -2, -2, -1, 1, 2);
  size = 50;
  length = 12;

var
  Kx, Ky: integer;
  count: integer = 0;
  mas: array[0..length - 1, 0..length - 1] of integer;
  win1: boolean = false;
  lose1: boolean = false;
  

procedure DrawX(x, y: integer);
begin
  Pen.Color := clRed;
  Pen.Width := 3;
  Line(x * size, (y + 1) * size, (x + 1) * size, y * size);
  Line(x * size, y * size, (x + 1) * size, (y + 1) * size);
  Pen.Color := clBlack; 
  Pen.Width := 1;
end;

procedure Lighting();
begin
  Pen.Color := rgb(0, 255, 0);
  Pen.Width := 4;
  for i: byte := 0 to 7 do 
  begin
    if (Kx + dx[i] < length) and (Kx + dx[i] >= 0) and 
         (Ky + dy[i] < length) and (Ky + dy[i] >= 0) then
      if mas[Kx + dx[i], Ky + dy[i]] = 0 then
        DrawEllipse((Kx + dx[i]) * size + 5, (Ky + dy[i]) * size + 5, 
        (Kx + dx[i] + 1) * size - 5, (Ky + dy[i] + 1) * size - 5);
  end;
  Pen.Color := clBlack;
  Pen.Width := 1;
end;

procedure Redraw();
begin
  ClearWindow();
  Pen.Color := clBlack;
  for i: byte := 0 to length - 1 do
    for j: byte := 0 to length - 1 do 
    begin
      if ((i + j) mod 2 = 0) then
        Brush.Color := clGray
      else
        Brush.Color := clWhite;
      FillRect(i * size, j * size, (i + 1) * size, (j + 1) * size);
    end;
  Font.Size := 16;
  for i: byte := 0 to length - 1 do
    for j: byte := 0 to length - 1 do 
    begin
      if mas[i, j] > 0 then begin
        if ((i + j) mod 2 = 0) then
          Brush.Color := clGray
        else
          Brush.Color := clWhite;
        if mas[i, j] < 10 then
          textout(i * size + (size - 12) div 2, j * size + (size - 16) div 2, mas[i, j])
        else
          textout(i * size + (size - 16) div 2, j * size + (size - 16) div 2, mas[i, j]);
      end;
    end;
  Font.Size := 12;
  Pen.Color := clBlack;
  Brush.Color := clWhite;
  textout(size * length + 50, size, 'Количество: ');
  textout(size * length + 50, size + 50, count);
end;

procedure CheckWin();
begin
  if (Kx = 0) and (Ky = length - 1) and (count = 63) then begin
    Brush.Color := clwhite;
    textout(100, 200, 'Ты выиграл, нажми на надпись чтобы сыграть еще раз');
    win1 := true;
  end;
end;

procedure CheckLose();
var
  c: byte;
begin
  if not win1 then begin
    c := 0;
    for i: byte := 0 to 7 do
      if (Kx + dx[i] < length) and (Kx + dx[i] >= 0) and 
         (Ky + dy[i] < length) and (Ky + dy[i] >= 0) then
        if mas[Kx + dx[i], Ky + dy[i]] = 0 then
          inc(c);
    if c = 0 then begin
      Brush.Color := clwhite;
      textout(100, 200, 'Ты проиграл, нажми на надпись чтобы сыграть еще раз');
      Lose1 := true;
    end;
  end;
end;

procedure NewGame();
begin
  Pen.Color := clBlack;
  count := 0;
  for i: byte := 0 to length - 1 do
    for j: byte := 0 to length - 1 do 
    begin
      mas[i, j] := 0;
    end;
  Kx := 0;
  Ky := 0;
  Lose1 := false;
  Win1 := false;
  Redraw();
  DrawX(Kx, Ky);
  Lighting();
end;

procedure MouseDown(x, y, mb: integer);
var
  h: byte;
begin
  if lose1 or win1 then
    NewGame()
  else begin
    h := -1;
    for i: byte := 0 to 7 do
      if (x div size = Kx + dx[i]) and (y div size = Ky + dy[i]) and
        (x < size * length) and (y < size * length) then
        h := i;
    if (h >= 0) and (mas[x div size, y div size] = 0) then begin
      mas[Kx, Ky] := count + 1;
      inc(count);
      Redraw();
      Kx := x div size;
      Ky := y div size;
      DrawX(Kx, Ky);
      CheckWin();
      CheckLose();
      Lighting();
    end;
  end;
end;

begin
  OnMouseDown := MouseDown;
  SetWindowSize(size * length + 200, size * length);
  NewGame();
end.