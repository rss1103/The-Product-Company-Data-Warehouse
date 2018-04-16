-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema financedw
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema financedw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `financedw` DEFAULT CHARACTER SET utf8 ;
USE `financedw` ;

-- -----------------------------------------------------
-- Table `financedw`.`Customer_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Customer_dim` (
  `custID` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `Address 1` VARCHAR(50) NULL DEFAULT NULL,
  `Address 2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `zip` VARCHAR(45) NULL DEFAULT NULL,
  `Type Name` VARCHAR(20) NULL DEFAULT NULL,
  `Customer Type ID` VARCHAR(45) NULL DEFAULT NULL,
  `Customer_Company_origin` VARCHAR(45) NULL,
  `customer_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`customer_SK`),
  INDEX `idx_customer_dim_lookup` (`custID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`Order_Date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Order_Date` (
  `OrderDate` DATE NULL DEFAULT NULL,
  `Year` INT(11) NULL DEFAULT NULL,
  `Quarter` INT(11) NULL DEFAULT NULL,
  `Month` INT(11) NULL DEFAULT NULL,
  `Week` INT(11) NULL DEFAULT NULL,
  `Day` INT(11) NULL DEFAULT NULL,
  `FiscalYear` INT(11) NULL DEFAULT NULL,
  `FiscalQuarter` INT(11) NULL DEFAULT NULL,
  `FiscalMonth` INT(11) NULL DEFAULT NULL,
  `FiscalWeek` INT(11) NULL DEFAULT NULL,
  `FiscalDay` INT(11) NULL DEFAULT NULL,
  `OrderDate_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`OrderDate_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`Methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Methods` (
  `Shippingmethod` VARCHAR(45) NULL DEFAULT NULL,
  `Paymentmethod` VARCHAR(45) NULL DEFAULT NULL,
  `Ordermethod` VARCHAR(45) NULL DEFAULT NULL,
  `Method_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Method_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`Product_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Product_dim` (
  `prodID` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  `price1` DECIMAL(10,2) NULL,
  `price2` DECIMAL(10,2) NULL,
  `unitCost` DECIMAL(10,2) NULL,
  `prodTypeID` INT(11) NULL,
  `typeDescription` VARCHAR(45) NULL,
  `buID` VARCHAR(45) NULL DEFAULT NULL,
  `Product_Company_Origin` VARCHAR(45) NULL,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `abbrev` VARCHAR(10) NULL DEFAULT NULL,
  `product_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`product_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`Sales_Date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Sales_Date` (
  `SalesDate` DATE NULL DEFAULT NULL,
  `Year` INT(11) NULL DEFAULT NULL,
  `Quarter` INT(11) NULL DEFAULT NULL,
  `Month` INT(11) NULL DEFAULT NULL,
  `Week` INT(11) NULL DEFAULT NULL,
  `Day` INT(11) NULL DEFAULT NULL,
  `FiscalYear` INT(11) NULL DEFAULT NULL,
  `FiscalQuarter` INT(11) NULL DEFAULT NULL,
  `FiscalMonth` INT(11) NULL DEFAULT NULL,
  `FiscalWeek` INT(11) NULL DEFAULT NULL,
  `FiscalDay` INT(11) NULL,
  `SaleDate_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`SaleDate_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`Supplier_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`Supplier_dim` (
  `SupplierName` VARCHAR(50) NULL DEFAULT NULL,
  `SupAddress1` VARCHAR(50) NULL DEFAULT NULL,
  `SupAddress2` VARCHAR(50) NULL DEFAULT NULL,
  `City` VARCHAR(20) NULL DEFAULT NULL,
  `State` VARCHAR(45) NULL DEFAULT NULL,
  `SupplierZip` INT(11) NULL DEFAULT NULL,
  `SupplierID` VARCHAR(45) NULL DEFAULT NULL,
  `Supplier_Company_Origin` VARCHAR(45) NULL,
  `supplier_SK` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`supplier_SK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`sales_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financedw`.`sales_fact` (
  `InvoiceID` INT(11) NULL,
  `Amt` DECIMAL(10,2) NULL DEFAULT NULL,
  `Qty` INT(11) NULL DEFAULT NULL,
  `Discounted` TINYINT(1) NULL DEFAULT NULL,
  `ShipDays` INT(11) NULL DEFAULT NULL,
  `ShipCost` DECIMAL(10,2) NULL DEFAULT NULL,
  `InvoiceSource` VARCHAR(45) NULL,
  `Method_SK` INT(11) NOT NULL,
  `supplier_SK` INT(11) NOT NULL,
  `product_SK` INT(11) NOT NULL,
  `customer_SK` INT(11) NOT NULL,
  `SaleDate_SK` INT(11) NOT NULL,
  `OrderDate_SK` INT(11) NOT NULL,
  INDEX `fk_sales_fact_Methods_idx` (`Method_SK` ASC),
  INDEX `fk_sales_fact_supplier_dimension1_idx` (`supplier_SK` ASC),
  INDEX `fk_sales_fact_product_dim1_idx` (`product_SK` ASC),
  INDEX `fk_sales_fact_customer_dimension1_idx` (`customer_SK` ASC),
  INDEX `fk_sales_fact_Sales_Date1_idx` (`SaleDate_SK` ASC),
  INDEX `fk_sales_fact_orderdate_dim1_idx` (`OrderDate_SK` ASC),
  CONSTRAINT `fk_sales_fact_Methods`
    FOREIGN KEY (`Method_SK`)
    REFERENCES `financedw`.`Methods` (`Method_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_supplier_dimension1`
    FOREIGN KEY (`supplier_SK`)
    REFERENCES `financedw`.`Supplier_dim` (`supplier_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_product_dim1`
    FOREIGN KEY (`product_SK`)
    REFERENCES `financedw`.`Product_dim` (`product_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_customer_dimension1`
    FOREIGN KEY (`customer_SK`)
    REFERENCES `financedw`.`Customer_dim` (`customer_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_Sales_Date1`
    FOREIGN KEY (`SaleDate_SK`)
    REFERENCES `financedw`.`Sales_Date` (`SaleDate_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_fact_orderdate_dim1`
    FOREIGN KEY (`OrderDate_SK`)
    REFERENCES `financedw`.`Order_Date` (`OrderDate_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
