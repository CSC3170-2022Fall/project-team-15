create procedure register(
    IN _consumer_ID int,
    IN _consumerLocation varchar(40), 
    IN _package_ID int,
    IN _conBankAccount_ID int,
    IN _plant_ID varchar(20))
begin
    INSERT INTO consumer (consumer_ID, location, package_ID, conBankAccount_ID, plant_ID) VALUES
    (_consumer_ID, _consumerLocation, _package_ID, _conBankAccount_ID, _plant_ID);
end;
