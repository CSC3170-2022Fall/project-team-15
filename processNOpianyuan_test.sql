create procedure process(In _process int, IN _package int, OUT _plant varchar(10))
begin

    SELECT phm.plant_ID
    FROM plant_holds_machine phm
    WHERE phm.machine_ID = (
        SELECT mao.machine_ID
        FROM machine_ability_operation mao
        WHERE mao.operation_ID = (
            SELECT c.operation_ID
            from chip c
            where c.chip_ID = (
                SELECT pc.chip_ID
                from package_chips pc
                where pc.package_ID = _package
            )
        )
    )
    limit _process,1;
end;
