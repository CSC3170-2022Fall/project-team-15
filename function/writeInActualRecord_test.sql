create procedure writeInAR(
    IN _operation_ID varchar(20),
    IN _plant_ID varchar(10),
    IN _machine_ID varchar(10),
    IN _actStartTime time,
    IN _actEndTime time,
    IN _processExpense int
    )
begin
    INSERT INTO actualRecord(
   operation_ID,
   plant_ID,
   machine_ID,
   actStartTime, 
   actEndTime, 
   processExpense) VALUES
    (_operation_ID, _plant_ID, _machine_ID, _actStartTime, _actEndTime, _processExpense);
end;
