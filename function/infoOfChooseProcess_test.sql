create procedure opInfo(In _plant_ID varchar(10))
    SELECT p.plant_ID, p.location, p.plantOwner_ID, po.plantBankAccount_ID, phm.machine_ID 
    FROM plant_holds_machine phm, plant p, plantOwner po
    WHERE p.plant_ID = _plant_ID AND p.plant_ID = po.plant_ID AND p.plant_ID = phm.plant_ID
    GROUP BY p.plant_ID
    
end;
