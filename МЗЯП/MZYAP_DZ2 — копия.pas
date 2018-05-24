// Служебное слово - 'Const', 'set of', 'Char'
// Служебный символ - "'", "[", ":", "=", ".", ",", "]", ";"
// Идентефикатор - A8sda
// Литерал - '&'
// Const A7867:set of Char = [‘h’..’z’,’a’]; 
// vbg:set of ‘a’..’z’ = []; 

Const
  Cword: array of string = ('const', 'set', 'of', 'char');
  Czam: array of string = ('co', 'so', 'oo', 'ch');
  Csymb: set of char = ['''', '[', ']', ':', '=', '.', ',', ';'];

function id_zam(S: string): string;
var
  i: integer;
  S1: string;
begin
  S1 := '';
  while S <> '' do begin
    if S[1] in ['a'..'z', 'A'..'Z'] then begin
      i := 2;
      while S[i] in ['a'..'z', 'A'..'Z', '0'..'9'] do
        i := i + 1;
      i := i - 1;
      if (copy(S, 1, i) in Cword )then
        S1 := S1 + copy(S, 1, i);
      if not (copy(S, 1, i) in Cword )then
        S1 := S1 + 'id';
      delete(S, 1, i);
    end
    else
      if S[1] = '''' then begin
        if (S[2] in ['a'..'z', 'A'..'Z', '0'..'9']) and (S[3] = '''') then
          if (copy(S, 4, 3) = '..''') and (s[7] in ['a'..'z', 'A'..'Z', '0'..'9'])
          and (s[8] = '''') then begin
            S1 := S1 + 'dp';
            delete(S, 1, 8);
          end
          else begin
            s1 := s1 + 'sy';
            delete(s, 1, 3);
        end;
      end
      else begin
        S1 := S1 + S[1];
        delete(S, 1, 1);
      end;
    end; 
  id_zam := S1;
end;

function scaner(S: string): string;
var
  S1: string;
  i: integer;
begin
  S := LowerCase(S);
  S := id_zam(S);
  S1 := '';
  for i := 0 to 3 do
    while Pos(Cword[i], S) > 0 do begin
      insert(Czam[i], S, Pos(Cword[i], S));
      delete(S, Pos(Cword[i], S), length(Cword[i]));
    end;
  while Pos(' ', S) <> 0 do
    delete(S, Pos(' ', S), 1);
  scaner := S;
end;

var
  S: string;

begin
  S := 'Const A7867:set of Char = [''h''..''z'',''a'']; vbg:set of ''a''..''z'' = []; ';
  writeln(id_zam(LowerCase(S)));
  writeln(scaner(S));
end.