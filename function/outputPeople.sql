create procedure outputP(In _machine_ID int, IN _plant_ID varchar(10), OUT _people varchar(10))
begin
    SELECT COUNT(*) 
    FROM planRecord
    WHERE machine_ID = _machine_ID
    AND   plant_ID = _plant_ID
    
end;
