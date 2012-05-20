-- phpMyAdmin SQL Dump
-- version 3.3.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2012 at 10:45 AM
-- Server version: 5.1.36
-- PHP Version: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dcim`
--

-- --------------------------------------------------------

--
-- Table structure for table `fac_Cabinet`
--

CREATE TABLE IF NOT EXISTS `fac_Cabinet` (
  `CabinetID` int(11) NOT NULL AUTO_INCREMENT,
  `DataCenterID` int(11) NOT NULL,
  `Location` varchar(20) NOT NULL,
  `AssignedTo` int(11) NOT NULL,
  `ZoneID` int(11) NOT NULL,
  `CabinetHeight` int(11) NOT NULL,
  `Model` varchar(80) NOT NULL,
  `MaxKW` float NOT NULL,
  `MaxWeight` int(11) NOT NULL,
  `InstallationDate` date NOT NULL,
  `MapX1` int(11) NOT NULL,
  `MapX2` int(11) NOT NULL,
  `MapY1` int(11) NOT NULL,
  `MapY2` int(11) NOT NULL,
  `MapXY` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `depth` int(11) NOT NULL,
  `offset` int(11) NOT NULL,
  `direction` char(1) NOT NULL,
  `KeyNo` int(11) NOT NULL,
  PRIMARY KEY (`CabinetID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_CabinetAudit`
--

CREATE TABLE IF NOT EXISTS `fac_CabinetAudit` (
  `CabinetID` int(11) NOT NULL,
  `UserID` varchar(80) NOT NULL,
  `AuditStamp` datetime NOT NULL,
  PRIMARY KEY (`CabinetID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Config`
--

CREATE TABLE IF NOT EXISTS `fac_Config` (
  `Parameter` varchar(40) NOT NULL,
  `Value` varchar(200) NOT NULL,
  `UnitOfMeasure` varchar(40) NOT NULL,
  `ValType` varchar(40) NOT NULL,
  `DefaultVal` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Contact`
--

CREATE TABLE IF NOT EXISTS `fac_Contact` (
  `ContactID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` varchar(80) NOT NULL,
  `LastName` varchar(40) NOT NULL,
  `FirstName` varchar(40) NOT NULL,
  `Phone1` varchar(20) NOT NULL,
  `Phone2` varchar(20) NOT NULL,
  `Phone3` varchar(20) NOT NULL,
  `Email` varchar(80) NOT NULL,
  PRIMARY KEY (`ContactID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_DataCenter`
--

CREATE TABLE IF NOT EXISTS `fac_DataCenter` (
  `DataCenterID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `SquareFootage` int(11) NOT NULL,
  `DeliveryAddress` varchar(255) NOT NULL,
  `Administrator` varchar(80) NOT NULL,
  `DrawingFileName` varchar(255) NOT NULL,
  `EntryLogging` tinyint(1) NOT NULL,
  `rows` int(11) NOT NULL,
  `cols` int(11) NOT NULL,
  `ppd` int(11) NOT NULL,
  `start_row` char(2) NOT NULL,
  `start_col` int(11) NOT NULL,
  PRIMARY KEY (`DataCenterID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Decommission`
--

CREATE TABLE IF NOT EXISTS `fac_Decommission` (
  `SurplusDate` date NOT NULL,
  `Label` varchar(80) NOT NULL,
  `SerialNo` varchar(40) NOT NULL,
  `AssetTag` varchar(20) NOT NULL,
  `UserID` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Department`
--

CREATE TABLE IF NOT EXISTS `fac_Department` (
  `DeptID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `ExecSponsor` varchar(80) NOT NULL,
  `SDM` varchar(80) NOT NULL,
  `Classification` varchar(80) NOT NULL,
  PRIMARY KEY (`DeptID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_DeptContacts`
--

CREATE TABLE IF NOT EXISTS `fac_DeptContacts` (
  `DeptID` int(11) NOT NULL,
  `ContactID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Device`
--

CREATE TABLE IF NOT EXISTS `fac_Device` (
  `DeviceID` int(11) NOT NULL AUTO_INCREMENT,
  `Label` varchar(80) NOT NULL,
  `SerialNo` varchar(40) NOT NULL,
  `AssetTag` varchar(20) NOT NULL,
  `PrimaryIP` varchar(20) NOT NULL,
  `SNMPCommunity` varchar(80) NOT NULL,
  `ESX` tinyint(1) NOT NULL,
  `Owner` int(11) NOT NULL,
  `EscalationTimeID` int(11) NOT NULL,
  `EscalationID` int(11) NOT NULL,
  `PrimaryContact` int(11) NOT NULL,
  `Cabinet` int(11) NOT NULL,
  `Position` int(11) NOT NULL,
  `Height` int(11) NOT NULL,
  `Ports` int(11) NOT NULL,
  `TemplateID` int(11) NOT NULL,
  `NominalWatts` int(11) NOT NULL,
  `Amps` float NOT NULL,
  `PowerSupplyCount` int(11) NOT NULL,
  `DeviceType` enum('Server','Appliance','Storage Array','Switch','Routing Chassis','Patch Panel','Physical Infrastructure') NOT NULL,
  `MfgDate` date NOT NULL,
  `InstallDate` date NOT NULL,
  `Notes` text,
  `Reservation` tinyint(1) NOT NULL,
  PRIMARY KEY (`DeviceID`),
  KEY `SerialNo` (`SerialNo`,`AssetTag`,`PrimaryIP`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_DeviceTemplate`
--

CREATE TABLE IF NOT EXISTS `fac_DeviceTemplate` (
  `TemplateID` int(11) NOT NULL AUTO_INCREMENT,
  `ManufacturerID` int(11) NOT NULL,
  `Model` varchar(80) NOT NULL,
  `Height` int(11) NOT NULL,
  `Weight` int(11) NOT NULL,
  `Wattage` int(11) NOT NULL,
  PRIMARY KEY (`TemplateID`),
  KEY `ManufacturerID` (`ManufacturerID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Escalations`
--

CREATE TABLE IF NOT EXISTS `fac_Escalations` (
  `EscalationID` int(11) NOT NULL AUTO_INCREMENT,
  `Details` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`EscalationID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_EscalationTimes`
--

CREATE TABLE IF NOT EXISTS `fac_EscalationTimes` (
  `EscalationTimeID` int(11) NOT NULL AUTO_INCREMENT,
  `TimePeriod` varchar(80) NOT NULL,
  PRIMARY KEY (`EscalationTimeID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Manufacturer`
--

CREATE TABLE IF NOT EXISTS `fac_Manufacturer` (
  `ManufacturerID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(80) NOT NULL,
  PRIMARY KEY (`ManufacturerID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PanelSchedule`
--

CREATE TABLE IF NOT EXISTS `fac_PanelSchedule` (
  `PanelID` int(11) NOT NULL AUTO_INCREMENT,
  `PolePosition` int(11) NOT NULL,
  `NumPoles` int(11) NOT NULL,
  `Label` varchar(80) NOT NULL,
  PRIMARY KEY (`PanelID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PDUStats`
--

CREATE TABLE IF NOT EXISTS `fac_PDUStats` (
  `PDUID` int(11) NOT NULL,
  `PhaseA` float(6,2) NOT NULL,
  `PhaseB` float(6,2) NOT NULL,
  `PhaseC` float(6,2) NOT NULL,
  `TotalAmps` float(6,2) NOT NULL,
  PRIMARY KEY (`PDUID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PowerConnection`
--

CREATE TABLE IF NOT EXISTS `fac_PowerConnection` (
  `PDUID` int(11) NOT NULL,
  `PDUPosition` int(11) NOT NULL,
  `DeviceID` int(11) NOT NULL,
  `DeviceConnNumber` int(11) NOT NULL,
  KEY `PDUID` (`PDUID`,`DeviceID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PowerDistribution`
--

CREATE TABLE IF NOT EXISTS `fac_PowerDistribution` (
  `PDUID` int(11) NOT NULL AUTO_INCREMENT,
  `Label` varchar(40) NOT NULL,
  `Location` varchar(10) NOT NULL,
  `CabinetID` int(11) NOT NULL,
  `InputVoltage` enum('Single Phase','2-Phase','3-Phase') NOT NULL,
  `InputAmperage` int(11) NOT NULL,
  `ManagementType` enum('Unmanaged','Geist','ServerTech','APC') NOT NULL,
  `Model` varchar(80) NOT NULL,
  `NumOutputs` int(11) NOT NULL,
  `IPAddress` varchar(16) NOT NULL,
  `SNMPCommunity` varchar(50) NOT NULL,
  `FirmwareVersion` varchar(40) NOT NULL,
  `PanelID` int(11) NOT NULL,
  `PanelPole` int(11) NOT NULL,
  `FailSafe` tinyint(1) NOT NULL,
  `PanelID2` int(11) NOT NULL,
  `PanelPole2` int(11) NOT NULL,
  PRIMARY KEY (`PDUID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PowerPanel`
--

CREATE TABLE IF NOT EXISTS `fac_PowerPanel` (
  `PanelID` int(11) NOT NULL AUTO_INCREMENT,
  `PowerSourceID` int(11) NOT NULL,
  `PanelLabel` varchar(20) NOT NULL,
  `NumberOfPoles` int(11) NOT NULL,
  `MainBreakerSize` int(11) NOT NULL,
  `NumberScheme` enum('Odd/Even','Sequential') NOT NULL,
  PRIMARY KEY (`PanelID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_PowerSource`
--

CREATE TABLE IF NOT EXISTS `fac_PowerSource` (
  `PowerSourceID` int(11) NOT NULL AUTO_INCREMENT,
  `SourceName` varchar(80) NOT NULL,
  `DataCenterID` int(11) NOT NULL,
  `IPAddress` varchar(20) NOT NULL,
  `Community` varchar(40) NOT NULL,
  `LoadOID` varchar(80) NOT NULL,
  `Capacity` int(11) NOT NULL,
  PRIMARY KEY (`PowerSourceID`),
  KEY `DataCenterID` (`DataCenterID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_RackRequest`
--

CREATE TABLE IF NOT EXISTS `fac_RackRequest` (
  `RequestID` int(11) NOT NULL AUTO_INCREMENT,
  `RequestorID` int(11) NOT NULL,
  `RequestTime` datetime NOT NULL,
  `CompleteTime` datetime NOT NULL,
  `Label` varchar(40) NOT NULL,
  `SerialNo` varchar(40) NOT NULL,
  `AssetTag` varchar(40) NOT NULL,
  `ESX` tinyint(1) NOT NULL,
  `Owner` int(11) NOT NULL,
  `DeviceHeight` int(11) NOT NULL,
  `EthernetCount` int(11) NOT NULL,
  `VLANList` varchar(80) NOT NULL,
  `SANCount` int(11) NOT NULL,
  `SANList` varchar(80) NOT NULL,
  `DeviceClass` varchar(80) NOT NULL,
  `DeviceType` varchar(80) NOT NULL,
  `LabelColor` varchar(80) NOT NULL,
  `CurrentLocation` varchar(120) NOT NULL,
  `SpecialInstructions` text NOT NULL,
  PRIMARY KEY (`RequestID`),
  KEY `RequestorID` (`RequestorID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fac_SwitchConnection`
--

CREATE TABLE IF NOT EXISTS `fac_SwitchConnection` (
  `SwitchDeviceID` int(11) NOT NULL,
  `SwitchPortNumber` int(11) NOT NULL,
  `EndpointDeviceID` int(11) NOT NULL,
  `EndpointPort` int(11) NOT NULL,
  `Notes` varchar(80) NOT NULL,
  KEY `SwitchDeviceID` (`SwitchDeviceID`,`EndpointDeviceID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_User`
--

CREATE TABLE IF NOT EXISTS `fac_User` (
  `UserID` varchar(80) NOT NULL,
  `Name` varchar(80) NOT NULL,
  `ReadAccess` tinyint(1) NOT NULL,
  `WriteAccess` tinyint(1) NOT NULL,
  `DeleteAccess` tinyint(1) NOT NULL,
  `ContactAdmin` tinyint(1) NOT NULL,
  `RackRequest` tinyint(1) NOT NULL,
  `RackAdmin` tinyint(1) NOT NULL,
  `SiteAdmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_VMInventory`
--

CREATE TABLE IF NOT EXISTS `fac_VMInventory` (
  `VMIndex` int(11) NOT NULL,
  `DeviceID` int(11) NOT NULL,
  `LastUpdated` datetime NOT NULL,
  `vmID` int(11) NOT NULL,
  `vmName` varchar(80) NOT NULL,
  `vmState` varchar(80) NOT NULL,
  `Owner` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fac_Zone`
--

CREATE TABLE IF NOT EXISTS `fac_Zone` (
  `ZoneID` int(11) NOT NULL AUTO_INCREMENT,
  `DataCenterID` int(11) NOT NULL,
  `Description` varchar(120) NOT NULL,
  PRIMARY KEY (`ZoneID`),
  KEY `DataCenterID` (`DataCenterID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

