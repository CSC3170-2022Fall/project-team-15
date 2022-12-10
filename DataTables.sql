SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- ---------------------------------------------------------------------
-- The following content would be regarding the tables in this project
-- 
-- ** ALL FOREIGN KEY CONSTRAINT ARE REMOVED FOR SIMPLE ACCESS **
-- ---------------------------------------------------------------------

-- Consumer table
CREATE TABLE consumer(
   consumer_ID numeric(3, 0),
   consumerLocation varchar(40) not null,
   package_ID numeric(3, 0) not null,
   conBankAccount_ID numeric(5, 0) not null,
   plant_ID varchar(20), -- Changed the name to differentiate between plantLocation and consumerLocation
   primary key(consumer_ID)
);

-- Package table
CREATE TABLE package(
   package_ID numeric(3,0),
   timeRequired decimal(10, 0) not null, -- STORED IN SECONDS
   budget decimal(10, 0) not null,
   primary key(package_ID)
);

-- Chip table
CREATE TABLE chip(
   chip_ID varchar(7),
   chipType_ID char(2) not null,
   machine_ID varchar(20) not null,
   primary key(chip_ID)
);

-- Plant table
CREATE TABLE plant(
   plant_ID varchar(10),
   plantLocation varchar(20) not null, -- Changed the name to differentiate between plantLocation and consumerLocation
   plantOwner_ID varchar(40) not null,
   primary key(plant_ID)

);

-- PlantOwner table
CREATE TABLE plantOwner(
   plantOwner_ID varchar(20),
   plantBankAccount_ID numeric(6) not null,
   primary key(plantOwner)
);

-- Machine table
CREATE TABLE machine(
   machine_ID varchar(10),
   machineType_ID varchar(20) not null,
   primary key(machine_ID)
);

-- Operation table
CREATE TABLE operation(
   operation_ID varchar(20),
   operationType_ID varchar(20) not null,
   primary key(operation_ID)
);

-- PlanRecord table
CREATE TABLE planRecord(
   operation_ID varchar(20),
   machine_ID varchar(10),
   planStartTime time not null, -- Assume won't take one day
   planEndTime time not null, -- Assume won't take one day
   processExpense decimal(10,0) not null,
   primary key(operation_ID, machine_ID)

);

-- ActualRecord table
CREATE TABLE actualRecord(
   operation_ID varchar(20),
   machine_ID varchar(10),
   actStartTime time not null, -- Assume won't take one day
   actEndTime time not null, -- Assume won't take one day
   processExpense decimal(10,0) not null
   
);

-- Order table
CREATE TABLE orders(
   consumer_ID numeric(3, 0),
   package_ID numeric(3,0),
   packageNum decimal(5,0) not null,
   primary key(consumer_ID, package_ID)
);

-- PackageChips table
CREATE TABLE package_chips(
   package_ID numeric(3,0),
   chip_ID varchar(7),
   chipNum decimal(10, 0) not null,
   primary key(package_ID, chip_ID)
);

-- ChipProcessedPlant
CREATE TABLE chip_processed_plant(
   chip_ID varchar(7),
   plant_ID varchar(10),
   primary key(chip_ID, plant_ID)
);

-- ChipPreOperation
CREATE TABLE chip_pre_operation(
   chipType_ID char(2),
   operation_ID varchar(20),
   precedency varchar(100) not null,
   primary key(chipType_ID, operation_ID)
);

-- PlantHoldsMachine
CREATE TABLE plant_holds_machine(
   plant_ID varchar(10),
   machine_ID varchar(10),
   machineNum decimal(4,0) not null,
   primary key(plant_ID, machine_ID)  
);

-- MachineAbilityOperation
CREATE TABLE machine_ability_operation(
   machine_ID varchar(10),
   opeation_ID varchar(20),
   feasibility varchar(30) not null,
   timeNeeded decimal(10, 0),
   machineExpense decimal(10, 0),
   primary key(machine_ID, operation_ID)
);

-- MachineProcessOperation
CREATE TABLE machine_process_operation(
   machine_ID varchar(10),
   operation_ID varchar(20),
   primary key(machine_ID, operation_ID)
);

-- ---------------------------------------------------------------------
-- 
-- ---------------------------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;