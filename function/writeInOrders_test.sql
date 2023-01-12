create procedure registOrder(
    IN _consumer_ID int,
    IN _package_ID int,
    IN _packageNum int)
begin
    INSERT INTO orders (`consumer_ID`, `package_ID`, `packageNum`) VALUES
    (_consumer_ID, _package_ID, _packageNum);
end;
