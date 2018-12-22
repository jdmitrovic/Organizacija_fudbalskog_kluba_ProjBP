-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema org_klub
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema org_klub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `org_klub` DEFAULT CHARACTER SET utf8 ;
USE `org_klub` ;

-- -----------------------------------------------------
-- Table `org_klub`.`Osoblje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Osoblje` (
  `id_osoblja` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `godina_rodjenja` INT NOT NULL,
  `plata` INT NOT NULL,
  `nacionalnost` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_osoblja`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Fudbaler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Fudbaler` (
  `pozicija` VARCHAR(45) NOT NULL,
  `lateralnost` VARCHAR(45) NOT NULL,
  `Osoblje_id_osoblja` INT NOT NULL,
  PRIMARY KEY (`Osoblje_id_osoblja`),
  INDEX `fk_Fudbaler_Osoblje1_idx` (`Osoblje_id_osoblja` ASC),
  CONSTRAINT `fk_Fudbaler_Osoblje1`
    FOREIGN KEY (`Osoblje_id_osoblja`)
    REFERENCES `org_klub`.`Osoblje` (`id_osoblja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Menadzer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Menadzer` (
  `kvalifikacije` VARCHAR(45) NOT NULL,
  `Osoblje_id_osoblja` INT NOT NULL,
  PRIMARY KEY (`Osoblje_id_osoblja`),
  CONSTRAINT `fk_Menadzer_Osoblje1`
    FOREIGN KEY (`Osoblje_id_osoblja`)
    REFERENCES `org_klub`.`Osoblje` (`id_osoblja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Predsednik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Predsednik` (
  `id_predsednika` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_predsednika`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Stadion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Stadion` (
  `id_stadiona` INT NOT NULL,
  `ime_stadiona` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `kapacitet` INT NOT NULL,
  PRIMARY KEY (`id_stadiona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Fudbalski_klub`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Fudbalski_klub` (
  `id_kluba` INT NOT NULL,
  `ime_kiuba` VARCHAR(45) NOT NULL,
  `godina_osnivanja` YEAR NOT NULL,
  `drzava` VARCHAR(45) NOT NULL,
  `grad` VARCHAR(45) NOT NULL,
  `Predsednik_id_predsednika` INT NOT NULL,
  `Stadion_id_stadiona` INT NOT NULL,
  `liga` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_kluba`),
  INDEX `fk_Fudbalski_klub_Predsednik_idx` (`Predsednik_id_predsednika` ASC) ,
  INDEX `fk_Fudbalski_klub_Stadion1_idx` (`Stadion_id_stadiona` ASC) ,
  CONSTRAINT `fk_Fudbalski_klub_Predsednik`
    FOREIGN KEY (`Predsednik_id_predsednika`)
    REFERENCES `org_klub`.`Predsednik` (`id_predsednika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fudbalski_klub_Stadion1`
    FOREIGN KEY (`Stadion_id_stadiona`)
    REFERENCES `org_klub`.`Stadion` (`id_stadiona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Tim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Tim` (
  `vrsta_tima` VARCHAR(45) NOT NULL,
  `Fudbalski_klub_id_kluba` INT NOT NULL,
  PRIMARY KEY (`vrsta_tima`, `Fudbalski_klub_id_kluba`),
  INDEX `fk_Tim_Fudbalski_klub1_idx` (`Fudbalski_klub_id_kluba` ASC) ,
  CONSTRAINT `fk_Tim_Fudbalski_klub1`
    FOREIGN KEY (`Fudbalski_klub_id_kluba`)
    REFERENCES `org_klub`.`Fudbalski_klub` (`id_kluba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Nastupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Nastupa` (
  `godina_debitovanja` YEAR NOT NULL,
  `poslednja_godina` YEAR,
  `broj_nastupa` INT NOT NULL,
  `Fudbaler_Osoblje_id_osoblja` INT NOT NULL,
  `Tim_vrsta_tima` VARCHAR(45) NOT NULL,
  `Tim_Fudbalski_klub_id_kluba` INT NOT NULL,
  `broj_dresa` INT NOT NULL,
  PRIMARY KEY (`Fudbaler_Osoblje_id_osoblja`, `Tim_vrsta_tima`, `Tim_Fudbalski_klub_id_kluba`),
  INDEX `fk_Nastupao_Tim1_idx` (`Tim_vrsta_tima` ASC, `Tim_Fudbalski_klub_id_kluba` ASC) ,
  CONSTRAINT `fk_Nastupao_Fudbaler1`
    FOREIGN KEY (`Fudbaler_Osoblje_id_osoblja`)
    REFERENCES `org_klub`.`Fudbaler` (`Osoblje_id_osoblja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nastupao_Tim1`
    FOREIGN KEY (`Tim_vrsta_tima` , `Tim_Fudbalski_klub_id_kluba`)
    REFERENCES `org_klub`.`Tim` (`vrsta_tima` , `Fudbalski_klub_id_kluba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Trenira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Trenira` (
  `godina_debitovanja` YEAR NOT NULL,
  `poslednja_godina` YEAR,
  `Menadzer_Osoblje_id_osoblja` INT NOT NULL,
  `Tim_vrsta_tima` VARCHAR(45) NOT NULL,
  `Tim_Fudbalski_klub_id_kluba` INT NOT NULL,
  PRIMARY KEY (`Menadzer_Osoblje_id_osoblja`, `Tim_vrsta_tima`, `Tim_Fudbalski_klub_id_kluba`),
  INDEX `fk_Trenira_Tim1_idx` (`Tim_vrsta_tima` ASC, `Tim_Fudbalski_klub_id_kluba` ASC) ,
  CONSTRAINT `fk_Trenira_Menadzer1`
    FOREIGN KEY (`Menadzer_Osoblje_id_osoblja`)
    REFERENCES `org_klub`.`Menadzer` (`Osoblje_id_osoblja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trenira_Tim1`
    FOREIGN KEY (`Tim_vrsta_tima` , `Tim_Fudbalski_klub_id_kluba`)
    REFERENCES `org_klub`.`Tim` (`vrsta_tima` , `Fudbalski_klub_id_kluba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `org_klub`.`Filijala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `org_klub`.`Filijala` (
  `Fudbalski_klub_id_kluba_senior` INT NOT NULL,
  `Fudbalski_klub_id_kluba_filijala` INT NOT NULL,
  PRIMARY KEY (`Fudbalski_klub_id_kluba_senior`, `Fudbalski_klub_id_kluba_filijala`),
  INDEX `fk_Filijala_Fudbalski_klub2_idx` (`Fudbalski_klub_id_kluba_filijala` ASC) ,
  CONSTRAINT `fk_Filijala_Fudbalski_klub1`
    FOREIGN KEY (`Fudbalski_klub_id_kluba_senior`)
    REFERENCES `org_klub`.`Fudbalski_klub` (`id_kluba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Filijala_Fudbalski_klub2`
    FOREIGN KEY (`Fudbalski_klub_id_kluba_filijala`)
    REFERENCES `org_klub`.`Fudbalski_klub` (`id_kluba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
