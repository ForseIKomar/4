// Служебное слово - 'Const', 'set of', 'Char'
// Служебный символ - "'", "[", ":", "=", ".", ",", "]", ";"
// Идентефикатор - A8sda
// Литерал - '&'
// Const A7867:set of Char = [‘h’..’z’,’a’]; 
// vbg:set of ‘a’..’z’ = []; 

Const
  Cword: array of string = ('const', 'set of', 'char');
  Czam: array of string = ('co', 'so', 'ch');
  Csymb: set of char = [chr(39), '[', ']', ':', '=', '.', ',', ';'];
  
function scaner(S: string): string;
var
  S1: string;
  i: integer;
begin
  S := LowerCase(S);
  S1 := '';
  for i := 0 to 2 do
    while Pos(Cword[i], S) > 0 do begin
      insert(Czam[i], S, Pos(Cword[i], S));
      delete(S, Pos(Cword[i], S), length(Cword[i]));
    end;
  scaner := S;
end;

var
  S: string;

begin
  S := 'Const A7867:set of Char = [‘h’..’z’,’a’]; vbg:set of ‘a’..’z’ = []; ';
  writeln(scaner(S));
end.