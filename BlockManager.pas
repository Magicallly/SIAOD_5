unit BlockManager;

interface
uses TaskClass;

type

   CBlock = class
      private
         TaskList: TArray<CTaskManager>;   
         BlockCost: Integer;
         CurrentTaskPosition: Integer;          
      public
         procedure Tackt();
         procedure Update();
         constructor Create(Tasks: TArray<CTaskManager>);
         function IsWork: Boolean;
         function IsSleep: Boolean;
         function IsReady: Boolean;
         function GetBlockCost(): Integer;
   end;

   
implementation


procedure CBlock.Update();
var
   I: Integer;
begin
   for I := 0 to High(TaskList) do
   begin
      TaskList[I].Update();
   end;
end;

procedure CBlock.Tackt();
begin
   while (not TaskList[CurrentTaskPosition].IsWork) or
      (TaskList[CurrentTaskPosition].IsSleep) do
   begin
      CurrentTaskPosition := (CurrentTaskPosition + 1) mod Length(TaskList);
   end;
   TaskList[CurrentTaskPosition].Process();
   CurrentTaskPosition := (CurrentTaskPosition + 1) mod Length(TaskList);
end;

function CBlock.IsSleep(): Boolean;
var
   I: Integer;
begin
   Result := True;
   for I := 0 to High(TaskList) do
   begin
      Result := Result and TaskList[I].IsSleep;
   end;      
end;                       

function CBlock.IsWork(): Boolean;
var
   I: Integer;
begin
   Result := False;;
   for I := 0 to High(TaskList) do
   begin
      Result := Result or TaskList[I].IsWork;
   end;      
end;

function CBlock.GetBlockCost: Integer;
begin
   Result := BlockCost;
end;

constructor CBlock.Create(Tasks: TArray<CTaskManager>);
var
   I: Integer;
begin
   TaskList := Tasks;
   CurrentTaskPosition := 0;
   BlockCost := 0;
   for I := 0 to High(Tasks) do
   begin
      Inc(BlockCost, Tasks[I].GetTaskCost);
   end;   
end;

function CBlock.IsReady(): Boolean;
var
   I: Integer;
begin
   Result := False;
   for I := 0 to High(TaskList) do
   begin
      Result := Result or ((not TaskList[I].IsSleep) and TaskList[I].IsWork)
   end;
end;
end.
