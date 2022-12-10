SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- --------------------------------------------------------

--
-- Dumping data for table `consumer`
--

INSERT INTO `consumer` (`consumer_ID`, `location`, `package_ID`, `conBankAccount_ID`, `plant_ID`) VALUES
(`123`, `A`, `001`, `12345`, NULL),
(`456`, `B`, `002`, `11155`, `plantA`),
(`789`, `C`, `003`, `12233`, `plantC`)
(`100`, `D`, `004`, `13566`, `plantD`);

-- --------------------------------------------------------

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`package_ID`, `timeRequired`, `Budget`) VALUES
(`001`, `6:00`, `20000`),
(`002`, `4:00`, `15000`),
(`003`, `3:00`, `18000`),
(`004`, `8:00`, `30000`),
(`005`, `5:00`, `25000`);


-- --------------------------------------------------------

--
-- Dumping data for table `employees`
--

INSERT INTO `chip`(`chip_ID`, `chipType_ID`, `machine_ID`) VALUES
(`chip1`, `A1`, `etchmachine`),   # Point to himself
(`chip2`, `A3`, `drillmachine`),
(`chip2`, `A3`, `testmachine`),
(`chip3`, `B2`, `bondmachine`),
(`chip4`, `C4`, `packmachine`),
(`chip5`, `B5`, `bondmachine`),
(`chip6`, `D1`, `drillmachine`),
(`chip7`, `F3`, `testmachine`);

-- --------------------------------------------------------

--
-- Dumping data for table `job_history`
--

INSERT INTO `plant`(`plant_ID`, `location`, `plantOwner_ID`) VALUES
(`plantA`, `Longgang`, `plantOwner1`),
(`plantB`, `Futian`, `plantOwner2`),
(`plantC`, `Baoan`, `plantOwner2`),
(`plantD`, `Nanshan`, `plantOwner3`);


INSERT INTO `plantOwner`(`plantOwner_ID`, `plantBankAccount_ID`) VALUES
(`plantOwner1`, `156777`),
(`plantOwner2`, `235000`),
(`plantOwner3`, `147888`)

-- --------------------------------------------------------

--
-- Dumping data for table `jobs`
--

INSERT INTO `machine`(`machine_ID`, `machineType_ID`) VALUES
(`machine1`, `etchmachine`),
(`machine2`, `bondmachine`),
(`machine3`, `drillmachine`),
(`machine4`, `testmachine`),
(`machine5`, `packmachine`);

-- --------------------------------------------------------

--
-- Dumping data for table `locations`
--

INSERT INTO `operation`(`operation_ID`, `operationType_ID`) VALUES
(`design-import`, `design-import`),
(`etch`, `etch`)
(`bond`, `bond`),
(`drill`, `drill`),
(`test`, `test`),
(`pack`, `pack`);

-- --------------------------------------------------------

--
-- Dumping data for table `regions`
--

INSERT INTO `planRecord`(`operation_ID`, `machine_ID`, `planStartTime`, `planEndTime`, `processExpense`) VALUES
(`design-import`, `machine3`, `08:00`, `09:00`, `1700`),
(`test`, `machine4`, `11:00`, `14:00`, `1100`);



INSERT INTO `actualRecord`(`operation_ID`, `machine_ID`, `actStartTime`, `actEndTime`, `processExpense`) VALUES
(`design-import`, `machine2`, `08:00`, `09:00`, `1600`),
(`test`, `machine4`, `12:00`, `15:00`, `900`);






-- --------------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;