-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hyperparameter_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hyperparameter_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hyperparameter_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hyperparameter_db` ;

-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Leaderboard_Metadata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Leaderboard_Metadata` (
  `Run_ID` VARCHAR(50) NOT NULL,
  `Model_Execution_Time` DOUBLE NULL,
  `Start_Time` DOUBLE NULL,
  `End_Time` DOUBLE NULL,
  `Run_Time` DOUBLE NULL,
  `Run_Path` VARCHAR(100) NULL,
  `Max_Models` INT NULL,
  `Model_Species` VARCHAR(50) NULL,
  PRIMARY KEY (`Run_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Leaderboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Leaderboard` (
  `Model_ID` INT NOT NULL,
  `Model_Name` VARCHAR(100) NULL,
  `RMSE` DOUBLE NULL,
  `MSE` DOUBLE NULL,
  `MAE` DOUBLE NULL,
  `RMSLE` DOUBLE NULL,
  `Presence_StackedEnsembled_Best_of_Family` ENUM("True", "False") NULL,
  PRIMARY KEY (`Model_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Hyperparameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Hyperparameter` (
  `Hyperparameter_ID` INT NOT NULL,
  `Name` VARCHAR(50) NULL,
  PRIMARY KEY (`Hyperparameter_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Hyperparameter_Values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Hyperparameter_Values` (
  `Model_ID` INT NOT NULL,
  `Hyperparameter_ID` INT NOT NULL,
  `Value` VARCHAR(50) NULL,
  PRIMARY KEY (`Hyperparameter_ID`, `Model_ID`),
  FOREIGN KEY (Model_ID) REFERENCES `hyperparameter_db`.`Leaderboard`(Model_ID),
  FOREIGN KEY (Hyperparameter_ID) REFERENCES `hyperparameter_db`.`Hyperparameter`(Hyperparameter_ID)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Model_Run`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Model_Run` (
  `Model_ID` INT NOT NULL,
  `Run_ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Model_ID`, `Run_ID`),
  FOREIGN KEY (Run_ID) REFERENCES `hyperparameter_db`.`Leaderboard_Metadata`(Run_ID),
  FOREIGN KEY (Model_ID) REFERENCES `hyperparameter_db`.`Leaderboard`(Model_ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Dataset_Metadata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Dataset_Metadata` (
  `Dataset_ID` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Dataset_Owner` VARCHAR(50) NULL,
  `Licence` VARCHAR(50) NULL,
  `Visibility` VARCHAR(50) NULL,
  `URL` VARCHAR(100) NULL,
  `Date_Created` DATE NULL,
  `Last_Updated` DATE NULL,
  `Data_Size` DOUBLE NULL,
  `Number_of_Rows` INT NULL,
  `Number_of_Columns` INT NULL,
  `Tag_ID` INT NULL,
  PRIMARY KEY (`Dataset_ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Data_Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Data_Map` (
  `Dataset_ID` INT NOT NULL,
  `Run_ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Dataset_ID`, `Run_ID`),
  FOREIGN KEY (Run_ID) REFERENCES `hyperparameter_db`.`Leaderboard_Metadata`(Run_ID),
  FOREIGN KEY (Dataset_ID) REFERENCES `hyperparameter_db`.`Dataset_Metadata`(Dataset_ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Model_Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Model_Map` (
  `Model_Type_ID` INT NOT NULL,
  `Model_Type_Name` VARCHAR(50) NULL,
  PRIMARY KEY (`Model_Type_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Hyperparameter_Def_Values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Hyperparameter_Def_Values` (
  `Model_Type_ID` INT NOT NULL,
  `Hyperparameter_ID` INT NOT NULL,
  `Default_Value` VARCHAR(50) NULL,
  PRIMARY KEY (`Hyperparameter_ID`, `Model_Type_ID`),
  FOREIGN KEY (Model_Type_ID) REFERENCES `hyperparameter_db`.`Model_Map`(Model_Type_ID),
  FOREIGN KEY (Hyperparameter_ID) REFERENCES `hyperparameter_db`.`Hyperparameter`(Hyperparameter_ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`ID_Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`ID_Map` (
  `Model_ID` INT NOT NULL,
  `Model_Type_ID` INT NOT NULL,
  PRIMARY KEY (`Model_ID`),
  FOREIGN KEY (Model_Type_ID) REFERENCES `hyperparameter_db`.`Model_Map`(Model_Type_ID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Dataset_Variable_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Dataset_Variable_Details` (
  `Var_ID` INT AUTO_INCREMENT NOT NULL,
  `Dataset_ID` INT NOT NULL,
  `Name_of_Variables` VARCHAR(50) NULL,
  `Datatype_of_Variable` VARCHAR(50) NULL,
  `Unique_Values_In_Each_Column` INT NULL,
  `Null_Values_In_Each_Column` INT NULL,
  PRIMARY KEY (`Var_ID`),
  FOREIGN KEY (Dataset_ID) REFERENCES `hyperparameter_db`.`Dataset_Metadata`(Dataset_ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Tags` (
  `Tag_ID` INT NOT NULL,
  `Tag_Name` VARCHAR(50) NULL,
  PRIMARY KEY (`Tag_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hyperparameter_db`.`Tag_Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_db`.`Tag_Map` (
  `Tag_ID` INT NOT NULL,
  `Dataset_ID` INT NOT NULL,
  PRIMARY KEY (`Tag_ID`, `Dataset_ID`),
  FOREIGN KEY (Dataset_ID) REFERENCES `hyperparameter_db`.`Dataset_Metadata`(Dataset_ID),
  FOREIGN KEY (Tag_ID) REFERENCES `hyperparameter_db`.`Tags`(Tag_ID)
 )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
