create procedure choosePa(In _package_ID int)
begin
    SELECT c.operation_ID
    FROM chip c
    WHERE c.chip_ID = (
        SELECT pc.chip_ID
        from package_chips pc
        WHERE pc.package_ID = _package_ID
    )
end;
