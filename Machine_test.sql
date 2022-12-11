create procedure machine(In _process int, IN _plant varchar(10), OUT _machine varchar(10))
begin

    SELECT phm.machine_ID
    FROM plant_holds_machine phm
    WHERE phm.plant_ID = _plant
    AND   phm.machine_ID =
    (
        SELECT mao.machine_ID
        FROM machine_ability_operation mao
        WHERE mao.operation_ID = _process
    )
end;
