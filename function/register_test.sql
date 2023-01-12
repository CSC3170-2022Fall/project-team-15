create procedure register(
    IN _consumer_ID int,
    IN _consumerLocation varchar(40))
begin
    INSERT INTO consumer (consumer_ID, 'location', package_ID, conBankAccount_ID, plant_ID) VALUES
    (_consumer_ID, _consumerLocation, 0,0,0);
end;
