SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
CREATE SCHEMA IF NOT EXISTS `spacestation13` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;
USE `spacestation13` ;

-- -----------------------------------------------------
-- Table `spacestation13`.`death`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spacestation13`.`death` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `pod` TEXT NOT NULL COMMENT 'Place of death' ,
  `coord` TEXT NOT NULL COMMENT 'X, Y, Z POD' ,
  `tod` DATETIME NOT NULL COMMENT 'Time of death' ,
  `job` TEXT NOT NULL ,
  `special` TEXT NOT NULL ,
  `name` TEXT NOT NULL ,
  `byondkey` TEXT NOT NULL ,
  `laname` TEXT NOT NULL COMMENT 'Last attacker name' ,
  `lakey` TEXT NOT NULL COMMENT 'Last attacker key' ,
  `gender` TEXT NOT NULL ,
  `bruteloss` INT(11) NOT NULL ,
  `brainloss` INT(11) NOT NULL ,
  `fireloss` INT(11) NOT NULL ,
  `oxyloss` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 3409
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacestation13`.`karma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spacestation13`.`karma` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `spendername` TEXT NOT NULL ,
  `spenderkey` TEXT NOT NULL ,
  `receivername` TEXT NOT NULL ,
  `receiverkey` TEXT NOT NULL ,
  `receiverrole` TEXT NOT NULL ,
  `receiverspecial` TEXT NOT NULL ,
  `isnegative` TINYINT(1) NOT NULL ,
  `spenderip` TEXT NOT NULL ,
  `time` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 943
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacestation13`.`karmatotals`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spacestation13`.`karmatotals` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `byondkey` TEXT NOT NULL ,
  `karma` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 244
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacestation13`.`library`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spacestation13`.`library` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `author` TEXT NOT NULL ,
  `title` TEXT NOT NULL ,
  `content` TEXT NOT NULL ,
  `category` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 184
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacestation13`.`population`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `spacestation13`.`population` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `playercount` INT(11) NULL DEFAULT NULL ,
  `admincount` INT(11) NULL DEFAULT NULL ,
  `time` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 2544
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
