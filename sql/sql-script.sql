-- MySQL Script generated by MySQL Workbench
-- ter 16 jun 2020 14:55:37
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cardapiocbs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cardapiocbs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cardapiocbs` ;
USE `cardapiocbs` ;

-- -----------------------------------------------------
-- Table `cardapiocbs`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`produto` (
  `prod_id` INT NOT NULL AUTO_INCREMENT,
  `prod_nome` VARCHAR(200) NULL,
  `prod_marca` VARCHAR(200) NULL,
  `prod_preco` DOUBLE NULL,
  PRIMARY KEY (`prod_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cardapiocbs`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`categoria` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `cat_nome` VARCHAR(200) NOT NULL,
  `cat_desc` VARCHAR(200) NULL,
  `cat_img` VARCHAR(45) NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cardapiocbs`.`cesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`cesta` (
  `cesta_id` INT NOT NULL AUTO_INCREMENT,
  `cesta_nome` VARCHAR(200) NULL,
  `cesta_preco` DOUBLE NULL,
  `cat_id` INT NULL,
  PRIMARY KEY (`cesta_id`),
  INDEX `cat_id_FK_idx` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `cat_id_FK_cesta`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cardapiocbs`.`categoria` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cardapiocbs`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`pedido` (
  `ped_id` INT NOT NULL AUTO_INCREMENT,
  `ped_detalhes` VARCHAR(200) NULL,
  `ped_cliente` VARCHAR(200) NULL,
  PRIMARY KEY (`ped_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cardapiocbs`.`pedido_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`pedido_item` (
  `ped_item_id` INT NOT NULL AUTO_INCREMENT,
  `ped_item_qtd` INT NULL,
  `cesta_id` INT NULL,
  `ped_id` INT NULL,
  PRIMARY KEY (`ped_item_id`),
  INDEX `cesta_id_FK_idx` (`cesta_id` ASC) VISIBLE,
  INDEX `ped_id_FK_idx` (`ped_id` ASC) VISIBLE,
  CONSTRAINT `cesta_id_FK_pedido`
    FOREIGN KEY (`cesta_id`)
    REFERENCES `cardapiocbs`.`cesta` (`cesta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ped_id_FK_pedido`
    FOREIGN KEY (`ped_id`)
    REFERENCES `cardapiocbs`.`pedido` (`ped_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cardapiocbs`.`cesta_comp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`cesta_comp` (
  `cesta_id` INT NOT NULL,
  `prod_id` INT NOT NULL,
  `cesta_comp_qtd` VARCHAR(45) NULL,
  INDEX `prod_id_FK_idx` (`prod_id` ASC) VISIBLE,
  INDEX `cesta_id_Fk_idx` (`cesta_id` ASC) VISIBLE,
  CONSTRAINT `cesta_id_Fk_comp`
    FOREIGN KEY (`cesta_id`)
    REFERENCES `cardapiocbs`.`cesta` (`cesta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prod_id_FK_comp`
    FOREIGN KEY (`prod_id`)
    REFERENCES `cardapiocbs`.`produto` (`prod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cardapiocbs`.`pedido_completado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardapiocbs`.`pedido_completado` (
  `ped_id` INT NOT NULL,
  `ped_status` VARCHAR(45) NULL,
  INDEX `ped_id_FK_comp_idx` (`ped_id` ASC) VISIBLE,
  CONSTRAINT `ped_id_FK_comp`
    FOREIGN KEY (`ped_id`)
    REFERENCES `cardapiocbs`.`pedido` (`ped_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Insert into categoria
INSERT INTO categoria (cat_nome, cat_desc, cat_img) VALUES ("Padrao", "Cestas Padrao", 1);
INSERT INTO categoria (cat_nome, cat_desc, cat_img) VALUES ("Natal", "Cestas Natal", 1);

-- Insert into cestas 
INSERT INTO cesta (cesta_nome, cesta_preco, cat_id) VALUES ("Kit Limpeza 1", 44.90, 1);
INSERT INTO cesta (cesta_nome, cesta_preco, cat_id) VALUES ("Cesta Doação", 53.00, 1);
INSERT INTO cesta (cesta_nome, cesta_preco, cat_id) VALUES ("Cesta EconoMais", 75.00, 1);
INSERT INTO cesta (cesta_nome, cesta_preco, cat_id) VALUES ("Cesta Confecção Sindicato", 101.00, 1);
INSERT INTO cesta (cesta_nome, cesta_preco, cat_id) VALUES ("Cesta QualiMais", 102.50, 1);