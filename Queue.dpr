program Queue;

{$APPTYPE CONSOLE}
{$R *.res}

uses
   System.SysUtils,
   CPU in 'CPU.pas',
   TaskClass in 'TaskClass.pas',
   BlockManager in 'BlockManager.pas';

procedure Main();
var
   Contr: Controller;
   CycleTime, SleepTime: Integer;
   i: Integer;
   j: Integer;
   percents: array of array of real;
   stagnation: array of array of Integer;
begin
   Setlength(percents, 10, 11);
   Setlength(stagnation, 10, 11);
   for i := 1 to 10 do
   begin
      Writeln('����� �����: ', i);
      Writeln('|||||||||||||||||||||||||||||||||||||||||||||');
      CycleTime := i;
      for j := 0 to 10 do
      begin
         Writeln('����� ���: ', j);
         SleepTime := j;
         Contr := Controller.Create(CycleTime, SleepTime);
         percents[i - 1][j] :=
           (Contr.GetProcessCost / (Contr.GetTackCount * CycleTime) * 100);
         stagnation[i - 1][j] := Contr.GetTackCount * CycleTime -
           Contr.GetProcessCost;
         Writeln('����� ��� �������� - ', Contr.GetProcessCost);
         Writeln('�������� ��������� - ', Contr.GetTackCount * CycleTime);
         Writeln('������� - ', stagnation[i - 1][j]);
         Writeln('��� ', percents[i - 1][j]:3:1, '%');
         Writeln('------------------------------------------');
      end;
   end;
   Writeln(#10#13'������� ');
   Writeln('------------------------------------------');
   for i := 1 to 10 do
   begin
      for j := 0 to 10 do
      begin
         Write(stagnation[i - 1][j], '  ');
      end;
      Writeln;
   end;
   Writeln(#10#13'��� ');
   Writeln('------------------------------------------');
   for i := 1 to 10 do
   begin
      for j := 0 to 10 do
      begin
         Write(percents[i - 1][j]:3:1, '%  ');
      end;
      Writeln;
   end;

   Readln;
end;

begin
   Main;

end.
