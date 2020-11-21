unit TaskClass;

interface
type
   CTaskManager = class
   private
      SleepTime: Integer;
      CycleTime: Integer;
      TaskPosition: Integer;
      SleepState: Boolean;
      WorkState: Boolean;
      CurrentTaskTime: Integer;
      CurrentSleepTime: Integer;
      TaskTimes: TArray<Integer>; 
      TaskCost: Integer;
   public
      function IsWork(): Boolean;
      function IsSleep(): Boolean;
      function GetTaskCost(): Integer;
      constructor Create(CycleTime, SleepTime: Integer; TaskTimes: TArray<Integer>);
      procedure Update();
      procedure Process();
     
   end;
   
implementation

procedure CTaskManager.Process;
begin
   if (not SleepState) and (IsWork) then
   begin
      Dec(CurrentTaskTime, CycleTime);
      if (CurrentTaskTime <= 0) then
      begin
         Inc(TaskPosition);
         if (TaskPosition = Length(TaskTimes)) then
         begin
            WorkState := False;
         end
         else
         begin
            CurrentTaskTime := TaskTimes[TaskPosition];
            SleepState := True;
         end;
      end;
   end;   
end;

procedure CTaskManager.Update;
begin
   if (SleepState) and (IsWork) then
   begin
      Dec(CurrentSleepTime, CycleTime);
      if (CurrentSleepTime <= 0) then
      begin
         CurrentSleepTime := SleepTime;
         SleepState := False;
      end;
   end;
end;

function CTaskManager.GetTaskCost(): Integer;
begin
   Result := TaskCost;
end;

function CTaskManager.IsSleep(): Boolean;
begin
   Result := SleepState;
end;

function CTaskManager.IsWork(): Boolean;
begin
   Result := WorkState;
end;

constructor CTaskManager.Create(CycleTime, SleepTime: Integer; TaskTimes: TArray<Integer>);
var
   I: Integer;
begin
   Self.CycleTime := CycleTime;
   Self.SleepTime := SleepTime;
   Self.TaskTimes := TaskTimes;
   TaskPosition := 0;
   CurrentTaskTime := TaskTimes[TaskPosition];
   CurrentSleepTime := SleepTime;
   SleepState := False;
   WorkState := True;
   TaskCost := 0;
   for I := 0 to High(TaskTimes) do
   begin
      Inc(TaskCost, TaskTimes[I]);
   end;   
end;

end.
