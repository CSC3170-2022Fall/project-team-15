create procedure cusLo(In _consumer_ID int)
begin
    SELECT consumerLocation
    FROM consumer
    WHERE consumer_ID = _consumer_ID
end;
