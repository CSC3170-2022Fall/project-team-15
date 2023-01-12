create procedure writeInPR(
    IN _operation_ID varchar(20),
    IN _plant_ID varchar(10),
    IN _machine_ID varchar(10),
    IN _planStartTime time,
    IN _planEndTime time,
    IN _processExpense int
    )
begin
    INSERT INTO planRecord(
   operation_ID,
   plant_ID,
   machine_ID,
   planStartTime, 
   planEndTime, 
   processExpense) VALUES
    (_operation_ID, _plant_ID, _machine_ID, _planStartTime, _planEndTime, _processExpense);
end;
