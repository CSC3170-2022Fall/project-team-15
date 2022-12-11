create procedure process(In _process int, IN _consumer int, IN _package int, OUT _plant varchar(10))
    SELECT phm.plant_ID
    FROM plant_holds_machine phm
    WHERE phm.plant_ID = 
    (
        SELECT p.plant_ID
        from plant p
        where (p.location != 'Longgang') 
        OR 
        (
            (p.location == 'Longgang') AND p.location = 
                (
                    SELECT c.location
                    from consumer c
                    where c.consumer_ID = _consumer
                )
        ) 
        AND
        phm.machine_ID = 
        (
            SELECT mao.machine_ID
            FROM machine_ability_operation mao
            WHERE mao.operation_ID = 
            (
                SELECT c.operation_ID
                from chip c
                where c.chip_ID = 
                (
                    SELECT pc.chip_ID
                    from package_chips pc
                    where pc.package_ID = _package
                )
            )
        )
    )
    limit _process,1;
end;
