unit CPU;

interface

uses BlockManager;

type
   Controller = class
      private
         TacktCount: Integer;
         SleepTime: Integer;
         CycleTime: Integer;
         ProcessCost: Integer;
         Lvl1, Lvl2, Lvl3: CBlock;
         procedure Tackt();
      public
         constructor Create(CycleTime, SleepTime: Integer);
         procedure Processing();
         function IsAlive(): Boolean;
         function GetTackCount(): Integer;
         function GetProcessCost(): Integer;
   end;
implementation

uses TaskClass;

procedure Controller.Tackt;
begin
   Inc(TacktCount);
   Lvl1.Update();
   Lvl2.Update();
//   Lvl3.Update();
   if (Lvl1.IsReady) then
   begin
      Lvl1.Tackt();
   end
   else
   begin
      if (Lvl2.IsReady) then
      begin
         Lvl2.Tackt();
      end
      else
      begin
       {  if (Lvl3.IsReady) then
         begin
            Lvl3.Tackt();
         end; }
      end;
   end;
end;

function Controller.IsALive(): Boolean;
begin
   Result := Lvl1.IsWork or Lvl2.IsWork or Lvl3.IsWork;
end;

function GetTaskTime: TArray<TArray<Integer>>;
var
   Matr: TArray<TArray<Integer>>;
begin
   SetLength(Matr, 5);
   SetLength(Matr[0], 10);
   SetLength(Matr[1], 10);
   SetLength(Matr[2], 10);
   SetLength(Matr[3], 10);
   SetLength(Matr[4], 10);

   Matr[0]:=[2,2,3,4,2,1,1,3,3,2];
   Matr[1]:=[4,1,1,1,1,2,2,3,1,1];
   Matr[2]:=[4,5,3,2,1,3,4,5,2,3];
   Matr[3]:=[4,5,3,2,1,1,3,3,3,4];
   Matr[4]:=[6,8,7,5,4,2,3,1,8,5];
   Result := Matr;
end;

function Controller.GetTackCount(): Integer;
begin
   Result := TacktCount;
end;

constructor Controller.Create(CycleTime, SleepTime: Integer);
var
   TasksTime: TArray<TArray<Integer>> ;
   B1, B2, B3: TArray<CTaskManager>;
begin
   Self.CycleTime := CycleTime;
   Self.SleepTime := SleepTime;


   TasksTime := GetTaskTime();
   SetLength(B1 ,4);
   B1[0] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[0]);
   B1[1] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[1]);
   B1[2] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[2]);
   B1[3] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[3]);
   Lvl1 := CBlock.Create(B1);

   SetLength(B2 ,1);
   B2[0] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[4]);
   Lvl2 := CBlock.Create(B2);

   SetLength(B3 ,0);
//
//   B3[1] := CTaskManager.Create(CycleTime, SleepTime, TasksTime[5]);
   Lvl3 := CBlock.Create(B3);

   ProcessCost := Lvl1.GetBlockCost + Lvl2.GetBlockCost + Lvl3.GetBlockCost;

   Processing();
end;

function Controller.GetProcessCost(): Integer;
begin
   Result := ProcessCost;
end;

procedure Controller.Processing();
begin
   while (IsAlive) do
   begin
      Tackt();
   end;
end;

end.
