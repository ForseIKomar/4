const
  symb: set of char = ['a'..'z', '0'..'9', 'A'..'Z'];


procedure deleteSpaces(var S: string);
begin
  while pos(' ', s) > 0 do
    delete(s, pos(' ', s), 1);
end;

function findConst(var S: string): boolean;
begin
  findConst := Copy(S, 1, 5) = 'const';
end;

function findName(S: string): integer;
var
  hig, i: integer;
  b: boolean;
begin
  hig := Pos(':', S) - 1;
  if hig >= 1 then begin
    b := true;
    for i := 1 to hig do 
      if not (S[i] in symb) then
        b := false;
    if b then
      findName := hig
    else
      findName := -1;
  end
  else
    findName := -1;
end;

function findDw(S: string): boolean;
begin
  findDw := S[1] = ':';
end;

function findSet(S: string): boolean;
begin
  findSet := copy(S, 1, 5) = 'setof';
end;

function findDiap(S: string; var Res: string): boolean;
var
  S1: string;
  b: boolean;
begin
  if copy(S, 1, 4) = 'char' then begin
    findDiap := true;
    Res := 'c';
  end else begin
    S1 := copy(S, 1, 8);
    b := true;
    if not((S[1] = '’') and (S[3] = S[1]) and (S[6] = S[1]) and (S[8] = S[1])) then
      b := false;
    if not((S[4] = S[5]) and (S[4] = '.')) then
      b := false;
    if not ((S[2] in symb) and (s[7] in symb)) then
      b := false;
    if b then begin
      Res := 'd';
      findDiap := true;
    end
    else
      findDiap := false;
  end;
  
end;

procedure checkString(S: string);
var
  i: integer;
  n: integer;
  S1, R: string;
begin
  S1 := '';
  deleteSpaces(S);
  S := LowerCase(S);
  if findConst(S) then delete(S, 1, 5) else exit;
  S1 += 'S';
  
  n := findName(S);
  if (n > 0) then delete(S, 1, n) else exit;
  S1 += 'N';
  
  if findDw(S) then delete(S, 1, 1) else exit;
  S1 += ':';
  
  if findSet(S) then delete(S, 1, 5) else exit;
  S1 += 's';
  
  if findDiap(S, R) then begin
    if (R = 'c') then
      delete(S, 1, 4)
    else
      delete(S, 1, 8);
    S1 += R;
  end else exit;
  
  if Pos('=[', S) = 1 then
    delete(S, 1, 2)
  else
    exit;
  S1 += '=[';
    
  writeln(S);
  writeln(S1);
end;

var
  S, S1: string;
  i: integer;

begin
  S := 'Const A7867:set of Char = [’h’..’z’,’a’];';
  S1 := 'Const vbg:set of ’a’..’z’ = [];';
  writeln(1);
  checkString(S);
  writeln(2);
  checkString(S1);
end.