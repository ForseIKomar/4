// Служебное слово - 'Const', 'set of', 'Char'
// Служебный символ - "'", "[", ":", "=", ".", ",", "]", ";"
// Идентефикатор - A8sda
// Литерал - '&'
// Const A7867:set of Char = [‘h’..’z’,’a’]; 
// vbg:set of ‘a’..’z’ = []; 

const
  Cword: array of string = ('const', 'set', 'of', 'char');
  Czam: array of string = ('co', 'so', 'oo', 'ch');
  Csymb: set of char = ['''', '[', ']', ':', '=', '.', ',', ';'];
  
  Mword: array of string = ('co', 'id', 'so', 'oo', 'ch', 'dp', 'sy');
  Msymb: array of string = (':', ',', '[', ']', ';');

function id_zam(S: string): boolean;
var
  i: integer;
  S1: string;
begin
  S1 := '';
  while S <> '' do 
  begin
    if S[1] in ['a'..'z', 'A'..'Z'] then begin
      i := 2;
      while S[i] in ['a'..'z', 'A'..'Z', '0'..'9'] do
        i := i + 1;
      i := i - 1;
      if (copy(S, 1, i) in Cword ) then
        S1 := S1 + copy(S, 1, i);
      if not (copy(S, 1, i) in Cword ) then
        S1 := S1 + 'id';
      delete(S, 1, i);
    end
    else
    if S[1] = '''' then begin
      if (S[2] in ['a'..'z', 'A'..'Z', '0'..'9']) and (S[3] = '''') then
        if (copy(S, 4, 3) = '..''') and (s[7] in ['a'..'z', 'A'..'Z', '0'..'9'])
          and (s[8] = '''') then begin
          if (s[2] < s[7]) then begin
            S1 := S1 + 'dp';
            delete(S, 1, 8);
          end
          else begin
            id_zam := false;
            exit;
          end
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
  id_zam := true;
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
    while Pos(Cword[i], S) > 0 do 
    begin
      insert(Czam[i], S, Pos(Cword[i], S));
      delete(S, Pos(Cword[i], S), length(Cword[i]));
    end;
  while Pos(' ', S) <> 0 do
    delete(S, Pos(' ', S), 1);
  
  while Pos('id:soooch=', S) > 0 do 
  begin
    i := Pos('id:soooch=', S);
    delete(S, i, 10);
    insert('im', s, i);
  end;
  while Pos('id:sooodp=', S) > 0 do 
  begin
    i := Pos('id:sooodp=', S);
    delete(S, i, 10);
    insert('im', s, i);
  end;
  if (copy(S, 1, 2) = 'co') then
    delete(S, 1, 2);
  
  S1 := S;
  while S1 <> '' do 
  begin
    if (copy(S1, 1, 3) = 'im[') then
      delete(S1, 1, 3)
    else begin
      scaner := 'Error';
      exit;
    end;
    while (copy(S1, 1, 3) = 'dp,') or (copy(S1, 1, 3) = 'sy,') do
      delete(S1, 1, 3);
    if (copy(S1, 1, 2) = 'dp') or (copy(S1, 1, 2) = 'sy') then
      delete(S1, 1, 2);
    if (copy(S1, 1, 2) = '];') then
      delete(S1, 1, 2)
    else begin
      scaner := 'Error';
      exit;
    end;
  end;
  
  scaner := 'Correct';
  
end;

//  Mword: array of string = ('co', 'id', 'so', 'oo', 'ch', 'dp', 'sy');
//  Msymb: array of string = (':', ',', '[', ']', ';');



var
  S: string;

begin
  readln(S);
  writeln(id_zam(LowerCase(S)));
  writeln(scaner(S));
end.