SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- --------------------------------------------------------

--
-- Dumping data for table `consumer`
--

INSERT INTO `consumer` (`consumer_ID`, `location`, `package_ID`, `conBankAccount_ID`, `plant_ID`) VALUES
(`123`, `Longgang`, `001`, `12345`, NULL),
(`456`, `Nanshan`, `002`, `11155`, `plantA`),
(`789`, `Nanshan`, `003`, `12233`, `plantC`)
(`100`, `Futian`, `004`, `13566`, `plantD`);

INSERT INTO `orders`(`consumer_ID`, `package_ID`, `packageNum`) VALUES
(`123`, `003`, `10`),
(`456`, `002`, `30`),
(`789`, `005`, `15`),
(`100`, `001`, `10`);

-- --------------------------------------------------------

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`package_ID`, `timeRequired`, `Budget`) VALUES
(`001`, `60:00`, `20000`),
(`002`, `40:00`, `15000`),
(`003`, `35:00`, `18000`),
(`004`, `50:00`, `30000`),
(`005`, `55:00`, `25000`);

INSERT INTO `package_chips`(`package_ID`, `chip_ID`, `chipNum`) VALUES
(`001`, `chip1`, `10`),
(`001`, `chip3`, `30`),
(`002`, `chip2`, `20`),
(`003`, `chip3`, `20`),
(`003`, `chip4`, `35`),
(`004`, `chip7`, `40`),
(`005`, `chip5`, `30`);


-- --------------------------------------------------------

--
-- Dumping data for table `employees`
--

INSERT INTO `chip`(`chip_ID`, `chipType_ID`, `operation_ID`) VALUES
(`chip1`, `A1`, `design-import`),
(`chip2`, `A3`, `drill`),
(`chip2`, `A3`, `bond`),
(`chip3`, `B2`, `etch`),
(`chip4`, `C4`, `test`),
(`chip5`, `B5`, `design-import`),
(`chip5`, `B5`, `bond`),
(`chip5`, `B5`, `test`),
(`chip6`, `D1`, `drill`),
(`chip7`, `F3`, `etch`),
(`chip7`, `F3`, `test`);

-- --------------------------------------------------------

--
-- Dumping data for table `job_history`
--

INSERT INTO `plant`(`plant_ID`, `location`, `plantOwner_ID`) VALUES
(`plantA`, `Longgang`, `plantOwner1`),
(`plantB`, `Futian`, `plantOwner2`),
(`plantC`, `Baoan`, `plantOwner2`),
(`plantD`, `Nanshan`, `plantOwner3`)
(`plantE`, `Longgang`, `plantOwner1`);


INSERT INTO `plantOwner`(`plantOwner_ID`, `plantBankAccount_ID`) VALUES
(`plantOwner1`, `156777`),
(`plantOwner2`, `235000`),
(`plantOwner3`, `147888`)

-- --------------------------------------------------------

--
-- Dumping data for table `jobs`
--

INSERT INTO `machine`(`machine_ID`, `machineType_ID`) VALUES
(`machine1`, `machineType1`),
(`machine2`, `machineType2`),
(`machine3`, `machineType3`),
(`machine4`, `machineType4`),
(`machine5`, `machineType5`);

INSERT INTO `chip_pre_operation`(`chipType_ID`, `operation_ID`, `precedency`) VALUES
(`A3`, `drill`, `1`),
(`A3`, `bond`, `2`),
(`B5`, `design-import`, `1`),
(`B5`, `bond`, `2`),
(`B5`, `test`, `3`);

-- --------------------------------------------------------

--
-- Dumping data for table `locations`
--

INSERT INTO `operation`(`operation_ID`, `operationType_ID`) VALUES
(`design-import`, `design-import`),
(`etch`, `etch`)
(`bond`, `bond`),
(`drill`, `drill`),
(`test`, `test`);

INSERT INTO `plant_holds_machine`(`plant_ID`, `machine_ID`, `machineNum`) VALUES
(`plantA`, `machine1`, `5`),
(`plantB`, `machine5`, `5`),
(`plantB`, `machine2`, `20`),
(`plantC`, `machine1`, `5`),
(`plantC`, `machine2`, `10`),
(`plantC`, `machine4`, `10`),
(`plantD`, `machine3`, `5`),
(`plantD`, `machine5`, `5`),
(`plantD`, `machine4`, `15`),
(`plantD`, `machine3`, `5`),
(`plantE`, `machine4`, `10`);

INSERT INTO `machine_ability_operation`(`machine_ID`, `operation_ID`, `time`, `machineExpense`) VALUES
(`machine1`, `design-import`, `2:00`, `2000`),
(`machine2`, `etch`, `3:00`, `3000`),
(`machine2`, `bond`, `4:00`, `2300`),
(`machine3`, `bond`, `3:00`, `3000`),
(`machine3`, `drill`, `4:00`, `4500`),
(`machine4`, `etch`, `2:30`, `3200`),
(`machine4`, `drill`, `5:00`, `4000`),
(`machine5`, `design-import`, `2:30`, `1600`),
(`machine5`, `test`, `1:00`, `1100`);

-- --------------------------------------------------------

--
-- Dumping data for table `regions`
--

INSERT INTO `planRecord`(`operation_ID`, `plant_ID`, `machine_ID`, `planStartTime`, `planEndTime`, `processExpense`) VALUES
(`design-import`, `plantC`, `machine1`, `08:00`, `10:00`, `2000`),
(`test`, `plantD`, `machine5`, `11:00`, `12:00`, `1100`);



INSERT INTO `actualRecord`(`operation_ID`, `plant_ID`, `machine_ID`, `actStartTime`, `actEndTime`, `processExpense`) VALUES
(`design-import`,  `plantA`, `machine1`, `08:00`, `09:00`, `2000`),
(`test`,  `plantD`, `machine5`, `12:00`, `15:00`, `1100`);


-- --------------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;