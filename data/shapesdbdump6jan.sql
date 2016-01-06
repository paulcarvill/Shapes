-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: shapes
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetfiles`
--

DROP TABLE IF EXISTS `craft_assetfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfiles` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kind` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `width` smallint(6) unsigned DEFAULT NULL,
  `height` smallint(6) unsigned DEFAULT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfiles_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `craft_assetfiles_sourceId_fk` (`sourceId`),
  KEY `craft_assetfiles_folderId_fk` (`folderId`),
  CONSTRAINT `craft_assetfiles_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfiles`
--

LOCK TABLES `craft_assetfiles` WRITE;
/*!40000 ALTER TABLE `craft_assetfiles` DISABLE KEYS */;
INSERT INTO `craft_assetfiles` VALUES (30,1,1,'craig.jpg','image',923,572,29425,'2016-01-05 15:08:57','2016-01-05 15:08:57','2016-01-05 15:08:57','adffe42e-86b9-4415-b830-43b1bd175e3a'),(31,1,1,'kamasi.jpg','image',925,542,111344,'2016-01-05 15:08:57','2016-01-05 15:08:58','2016-01-05 15:08:58','ff983441-8009-426f-9b20-8757a0f42b1e'),(32,1,1,'bonobo.jpg','image',1120,848,75666,'2016-01-05 15:08:58','2016-01-05 15:08:58','2016-01-05 15:08:58','56747d1b-c8f8-416a-85b7-c1a7117e9800');
/*!40000 ALTER TABLE `craft_assetfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetfolders`
--

DROP TABLE IF EXISTS `craft_assetfolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfolders_name_parentId_sourceId_unq_idx` (`name`,`parentId`,`sourceId`),
  KEY `craft_assetfolders_parentId_fk` (`parentId`),
  KEY `craft_assetfolders_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetfolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfolders_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfolders`
--

LOCK TABLES `craft_assetfolders` WRITE;
/*!40000 ALTER TABLE `craft_assetfolders` DISABLE KEYS */;
INSERT INTO `craft_assetfolders` VALUES (1,NULL,1,'Event image','','2015-11-01 19:22:02','2015-11-01 19:22:02','27f628ca-4711-4faf-88bf-9a81e78a0118');
/*!40000 ALTER TABLE `craft_assetfolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sourceId` int(10) NOT NULL,
  `offset` int(10) NOT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(10) DEFAULT NULL,
  `recordId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetindexdata_sessionId_sourceId_offset_unq_idx` (`sessionId`,`sourceId`,`offset`),
  KEY `craft_assetindexdata_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetindexdata_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetindexdata`
--

LOCK TABLES `craft_assetindexdata` WRITE;
/*!40000 ALTER TABLE `craft_assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assetsources`
--

DROP TABLE IF EXISTS `craft_assetsources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetsources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetsources_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assetsources_handle_unq_idx` (`handle`),
  KEY `craft_assetsources_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_assetsources_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetsources`
--

LOCK TABLES `craft_assetsources` WRITE;
/*!40000 ALTER TABLE `craft_assetsources` DISABLE KEYS */;
INSERT INTO `craft_assetsources` VALUES (1,'Event image','eventImage','Local','{\"path\":\"\\/var\\/www\\/html\\/uploads\\/\",\"url\":\"http:\\/\\/46.101.84.161\\/uploads\\/\"}',1,14,'2015-11-01 19:22:02','2016-01-05 15:31:21','0686644f-22c0-45b5-9f65-5cc24a096b26');
/*!40000 ALTER TABLE `craft_assetsources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT NULL,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_sourceId_fileId_location_idx` (`sourceId`,`fileId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransformindex`
--

LOCK TABLES `craft_assettransformindex` WRITE;
/*!40000 ALTER TABLE `craft_assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mode` enum('stretch','fit','crop') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'center-center',
  `height` int(10) DEFAULT NULL,
  `width` int(10) DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quality` int(10) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_fk` (`groupId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_categorygroups_handle_unq_idx` (`handle`),
  KEY `craft_categorygroups_structureId_fk` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups_i18n`
--

DROP TABLE IF EXISTS `craft_categorygroups_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `urlFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nestedUrlFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_i18n_groupId_locale_unq_idx` (`groupId`,`locale`),
  KEY `craft_categorygroups_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_categorygroups_i18n_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups_i18n`
--

LOCK TABLES `craft_categorygroups_i18n` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_i18n` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categorygroups_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_body` text COLLATE utf8_unicode_ci,
  `field_price` text COLLATE utf8_unicode_ci,
  `field_embed` text COLLATE utf8_unicode_ci,
  `field_ticketsLink` text COLLATE utf8_unicode_ci,
  `field_date` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_content_title_idx` (`title`),
  KEY `craft_content_locale_fk` (`locale`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
INSERT INTO `craft_content` VALUES (1,1,'en_gb',NULL,NULL,NULL,NULL,NULL,NULL,'2015-11-01 19:06:12','2016-01-05 18:16:43','c95678fa-09b1-4a2c-af4a-eb992b211e41'),(4,4,'en_gb','About','We play: Events space, social club & artist studios set in a converted warehouse on the River Lee. We connect: A collaborative, creative environment to encourage innovation & community. We host:  Exhibitions to shoots to corporate & creative events, you are in safe hands.',NULL,NULL,NULL,NULL,'2015-11-01 19:18:36','2015-11-01 19:26:20','9c439056-b539-492b-9179-67393af06737'),(5,5,'en_gb','Getting here',NULL,NULL,NULL,NULL,NULL,'2015-11-01 19:18:44','2015-11-01 19:18:44','4e5eece7-a0de-472c-880b-6c6f1becc68f'),(6,6,'en_gb','Bonobo / Dan Shake / Bradley Zero','This is most certainly something special. For the first time in two years in London, Bonobo puts down his bass and takes to the decks for an exclusive DJ set at super stylish new venue Shapes in Hackney.','£15.00','<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ha5vw3OlMx0\" frameborder=\"0\" allowfullscreen=\"\"></iframe>','http://seetickets.com','2015-11-05 00:00:00','2015-11-01 19:25:15','2016-01-05 15:09:14','bed3ca48-820f-47e0-952c-43b969518719'),(7,7,'en_gb','Kamasi Washington','This is most certainly something special. For the first time in two years in London, Bonobo puts down his bass and takes to the decks for an exclusive DJ set at super stylish new venue Shapes in Hackney.','£15.00','<iframe width=\"100%\" height=\"450\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/239037229&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true\"></iframe>','http://seetickets.com','2015-05-10 00:00:00','2015-11-01 19:25:15','2016-01-05 15:09:28','ae6f46a2-4fd5-42ff-881e-4b14675690d2'),(8,8,'en_gb','Craig David','This is most certainly something special. For the first time in two years in London, Bonobo puts down his bass and takes to the decks for an exclusive DJ set at super stylish new venue Shapes in Hackney.','£12.00','<iframe src=\"https://player.vimeo.com/video/56012765\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\"></iframe>','http://seetickets.com','2015-02-10 00:00:00','2015-11-01 19:25:15','2016-01-05 15:12:06','7256dea6-11e1-4733-ab64-4837d65a197c'),(9,9,'en_gb','Lorem ipsum','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','£12:00 - £20:00','<iframe src=\"https://embed.spotify.com/?uri=spotify:track:4th1RQAelzqgY7wL53UGQt\" width=\"300\" height=\"80\" frameborder=\"0\" allowtransparency=\"true\"></iframe>','http://seetickets.com','2015-01-01 00:00:00','2015-11-01 19:25:15','2016-01-05 15:09:52','7a0e7f29-7d07-41ea-8790-11a28776b80e'),(10,10,'en_gb','Exercitation ullamco laboris nisi','Lit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','','','','2014-12-09 00:00:00','2015-11-01 19:25:15','2016-01-05 15:10:03','326e736b-e3a0-4531-87fe-0a4990a3e317'),(11,11,'en_gb','Ullamco laboris','Sit consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','','','http://seetickets.com','2014-08-06 00:00:00','2015-11-01 19:25:15','2016-01-05 15:10:13','5c63a6c5-6284-4274-8c3b-07a22af190ae'),(12,12,'en_gb','Duis aute irure dolor','Am veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit qua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','£12:00 - £15:00','','http://seetickets.com','2014-04-15 22:00:00','2015-11-01 19:25:15','2016-01-05 15:10:24','e97ff472-2107-4e74-b474-3cbe9c0a0376'),(30,30,'en_gb','craig',NULL,NULL,NULL,NULL,NULL,'2016-01-05 15:08:57','2016-01-05 15:08:57','74764cdc-fbcc-41a1-a364-26b0e1bb7e41'),(31,31,'en_gb','kamasi',NULL,NULL,NULL,NULL,NULL,'2016-01-05 15:08:58','2016-01-05 15:08:58','f5eefbb3-a48f-423b-a7aa-88d11673d240'),(32,32,'en_gb','bonobo',NULL,NULL,NULL,NULL,NULL,'2016-01-05 15:08:58','2016-01-05 15:08:58','5ed43963-6abb-42fa-812c-191cca6bf452');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fingerprint` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `templateLine` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `traces` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
INSERT INTO `craft_elements` VALUES (1,'User',1,0,'2015-11-01 19:06:12','2016-01-05 18:16:43','d77c4a73-dfb4-47bc-bf07-a9c0a7704f85'),(4,'Entry',1,0,'2015-11-01 19:18:36','2015-11-01 19:26:20','7ceb3fc0-c364-42d3-b6ba-dad79c6c919a'),(5,'Entry',1,0,'2015-11-01 19:18:44','2015-11-01 19:18:44','2e1bfb5e-2ed7-43f0-a8f9-2a41bf34de9d'),(6,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:09:14','15064ec6-0750-42b5-abfb-f28837928d42'),(7,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:09:28','d634c4d2-50eb-437e-9402-e0b8a05127ba'),(8,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:12:06','b55bcd99-b1a2-4b41-bf05-1ff131ef484c'),(9,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:09:52','c0e77601-51c5-4edc-a398-b3f4c80bc6fa'),(10,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:10:03','2a750bc4-0510-4f18-b2d6-5a27d27eb075'),(11,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:10:13','0ff7a95f-c391-4e1a-9134-ec21a29ab369'),(12,'Entry',1,0,'2015-11-01 19:25:15','2016-01-05 15:10:24','8d915962-12b8-4b7b-b42c-53ad726ca2ad'),(30,'Asset',1,0,'2016-01-05 15:08:57','2016-01-05 15:08:57','c602279b-a572-4a6e-83e1-931f27f75462'),(31,'Asset',1,0,'2016-01-05 15:08:58','2016-01-05 15:08:58','4db7d5ff-750c-42f0-b34d-1723de98ccdd'),(32,'Asset',1,0,'2016-01-05 15:08:58','2016-01-05 15:08:58','9d2bbcb4-cdef-428d-b6e2-040ad8afa3d6');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements_i18n`
--

DROP TABLE IF EXISTS `craft_elements_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_i18n_elementId_locale_unq_idx` (`elementId`,`locale`),
  UNIQUE KEY `craft_elements_i18n_uri_locale_unq_idx` (`uri`,`locale`),
  KEY `craft_elements_i18n_slug_locale_idx` (`slug`,`locale`),
  KEY `craft_elements_i18n_enabled_idx` (`enabled`),
  KEY `craft_elements_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_elements_i18n_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements_i18n`
--

LOCK TABLES `craft_elements_i18n` WRITE;
/*!40000 ALTER TABLE `craft_elements_i18n` DISABLE KEYS */;
INSERT INTO `craft_elements_i18n` VALUES (1,1,'en_gb','',NULL,1,'2015-11-01 19:06:12','2016-01-05 18:16:43','d1129f76-0935-48db-b2c7-dd22c679f165'),(4,4,'en_gb','about','about',1,'2015-11-01 19:18:36','2015-11-01 19:26:20','b13fbad8-07b8-4efc-9209-3bd679307670'),(5,5,'en_gb','getting-here','getting-here',1,'2015-11-01 19:18:44','2015-11-01 19:18:44','42321730-c641-45fe-8171-d53c5e02a855'),(6,6,'en_gb','bonobo-dan-shake-bradley-zero','events/bonobo-dan-shake-bradley-zero',1,'2015-11-01 19:25:15','2016-01-05 15:09:14','db243381-5071-438a-bbaa-b8480daa61a9'),(7,7,'en_gb','kamasi-washington','events/kamasi-washington',1,'2015-11-01 19:25:15','2016-01-05 15:09:28','b3b7ef43-9c32-4a06-aa05-df5c37a0997a'),(8,8,'en_gb','craig-david','events/craig-david',1,'2015-11-01 19:25:15','2016-01-05 15:12:06','d7d6b58c-5693-46ba-8b88-a379e676af54'),(9,9,'en_gb','lorem-ipsum','events/lorem-ipsum',1,'2015-11-01 19:25:15','2016-01-05 15:09:53','1a1dcad8-4bbd-4a48-865d-23840c08dd40'),(10,10,'en_gb','exercitation-ullamco-laboris-nisi','events/exercitation-ullamco-laboris-nisi',1,'2015-11-01 19:25:15','2016-01-05 15:10:03','29d715f4-bb71-498c-b88c-eb1e8990a9ac'),(11,11,'en_gb','ullamco-laboris','events/ullamco-laboris',1,'2015-11-01 19:25:15','2016-01-05 15:10:13','4065af19-f8c4-4827-b480-755ee351b91b'),(12,12,'en_gb','duis-aute-irure-dolor','events/duis-aute-irure-dolor',1,'2015-11-01 19:25:15','2016-01-05 15:10:24','f7b10f7b-34d0-4946-995d-91d82a98e8e1'),(30,30,'en_gb','craig',NULL,1,'2016-01-05 15:08:57','2016-01-05 15:08:57','bb3fb8ea-9bc9-46d3-be52-e7882f41f11f'),(31,31,'en_gb','kamasi',NULL,1,'2016-01-05 15:08:58','2016-01-05 15:08:58','657231a7-8b38-4dd8-9733-b1512fd02fbd'),(32,32,'en_gb','bonobo',NULL,1,'2016-01-05 15:08:58','2016-01-05 15:08:58','0b881d35-818a-47b2-8f63-a84bb8603fe2');
/*!40000 ALTER TABLE `craft_elements_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_emailmessages`
--

DROP TABLE IF EXISTS `craft_emailmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_emailmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` char(150) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_emailmessages_key_locale_unq_idx` (`key`,`locale`),
  KEY `craft_emailmessages_locale_fk` (`locale`),
  CONSTRAINT `craft_emailmessages_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_emailmessages`
--

LOCK TABLES `craft_emailmessages` WRITE;
/*!40000 ALTER TABLE `craft_emailmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_emailmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_fk` (`authorId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
INSERT INTO `craft_entries` VALUES (4,4,NULL,NULL,'2015-11-01 19:18:36',NULL,'2015-11-01 19:18:36','2015-11-01 19:26:20','d4648e08-bfb3-4b06-afa8-49fcfc08bc36'),(5,5,NULL,NULL,'2015-11-01 19:18:44',NULL,'2015-11-01 19:18:44','2015-11-01 19:18:44','8a262e18-98d3-4bf5-87ae-43575d9b8ddd'),(6,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:09:14','86655fa0-8abd-4704-9a71-e95a867ea97a'),(7,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:09:28','a4ba50cd-10e2-40fc-8489-b39932805b85'),(8,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:12:06','c5cf91d1-36d4-4b01-b06c-ae84b64a3cb2'),(9,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:09:53','76d58b1b-528b-49c1-9c9d-02ee8c95d79e'),(10,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:10:03','282c46dd-fa8d-4f30-8ff8-00e082aa34ff'),(11,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:10:13','3700a849-b0cf-4ae7-aaa4-df9c3df43f64'),(12,3,3,1,'2015-11-01 19:25:00',NULL,'2015-11-01 19:25:15','2016-01-05 15:10:24','c2f7217d-8244-4f80-b1db-09855c707923');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entrydrafts_sectionId_fk` (`sectionId`),
  KEY `craft_entrydrafts_creatorId_fk` (`creatorId`),
  KEY `craft_entrydrafts_locale_fk` (`locale`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasTitleField` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Title',
  `titleFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `craft_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_fk` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
INSERT INTO `craft_entrytypes` VALUES (3,3,11,'Events','events',1,'Artist(s)',NULL,NULL,'2015-11-01 19:18:28','2015-11-01 19:24:58','1e61464d-b602-46fe-9d2b-d8447bb49602'),(4,4,12,'About','about',0,NULL,'{section.name|raw}',NULL,'2015-11-01 19:18:36','2015-11-01 19:26:08','96501695-6b57-4f71-8d74-de6c4407ff92'),(5,5,8,'Getting here','gettingHere',0,NULL,'{section.name|raw}',NULL,'2015-11-01 19:18:44','2015-11-01 19:18:44','e63fd481-1ffb-4edb-84b4-c83a51a63502');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entryversions_sectionId_fk` (`sectionId`),
  KEY `craft_entryversions_creatorId_fk` (`creatorId`),
  KEY `craft_entryversions_locale_fk` (`locale`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_export_map`
--

DROP TABLE IF EXISTS `craft_export_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_export_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settings` text COLLATE utf8_unicode_ci,
  `map` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_export_map`
--

LOCK TABLES `craft_export_map` WRITE;
/*!40000 ALTER TABLE `craft_export_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_export_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
INSERT INTO `craft_fieldgroups` VALUES (1,'Default','2015-11-01 19:06:12','2015-11-01 19:06:12','488b5d9b-d471-4d84-8339-25399b80feea');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_fk` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `craft_fieldlayoutfields` VALUES (1,3,1,1,1,1,'2015-11-01 19:06:12','2015-11-01 19:06:12','5367771a-a1b7-4439-9991-ff5e188c0e84'),(2,5,2,1,1,1,'2015-11-01 19:06:12','2015-11-01 19:06:12','382a2f1c-7d48-4cd4-97e1-7b12f74ea355'),(10,11,4,1,0,1,'2015-11-01 19:24:58','2015-11-01 19:24:58','cee76f15-2b64-4f64-8b1e-7b59f14402b6'),(11,11,4,6,0,2,'2015-11-01 19:24:58','2015-11-01 19:24:58','bce8196e-172e-4308-981e-1bbf8ffbe28e'),(12,11,4,7,0,3,'2015-11-01 19:24:58','2015-11-01 19:24:58','c3a7f755-55b2-4fac-91f0-848ca5aa21b4'),(13,11,4,3,0,4,'2015-11-01 19:24:58','2015-11-01 19:24:58','c972f8d8-cff3-4d97-88d8-db11552805ec'),(14,11,4,4,0,5,'2015-11-01 19:24:58','2015-11-01 19:24:58','ff771fae-dbe0-4d6e-a69e-9536758a244b'),(15,11,4,5,0,6,'2015-11-01 19:24:58','2015-11-01 19:24:58','96d194fa-cc05-47ee-b12b-65f27ba6df52'),(16,12,5,1,0,1,'2015-11-01 19:26:08','2015-11-01 19:26:08','52fa5201-1b43-4c05-acdc-a2904616c47a');
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
INSERT INTO `craft_fieldlayouts` VALUES (1,'Tag','2015-11-01 19:06:12','2015-11-01 19:06:12','f1675903-110f-4c09-b0ac-fef4471d435d'),(3,'Entry','2015-11-01 19:06:12','2015-11-01 19:06:12','73cdec7d-2ff1-4655-a239-5fe3d1d12598'),(5,'Entry','2015-11-01 19:06:12','2015-11-01 19:06:12','c1d4906b-0dea-4f41-94cc-0c777054a39d'),(8,'Entry','2015-11-01 19:18:44','2015-11-01 19:18:44','c523baec-3c3f-4783-a0d3-ac511ba7f308'),(11,'Entry','2015-11-01 19:24:58','2015-11-01 19:24:58','67910d2b-fa1c-4c90-bbf9-0f9c1bc88b67'),(12,'Entry','2015-11-01 19:26:08','2015-11-01 19:26:08','82fe958a-8466-41ac-a436-21dce95d4fa0'),(14,'Asset','2016-01-05 15:31:21','2016-01-05 15:31:21','7fa1444c-fdd9-4ed8-bffb-81c158493cf8');
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `craft_fieldlayouttabs` VALUES (1,3,'Content',1,'2015-11-01 19:06:12','2015-11-01 19:06:12','9de9cd5d-881d-46c7-b5ef-ceaebc457178'),(2,5,'Content',1,'2015-11-01 19:06:12','2015-11-01 19:06:12','7fe79689-e136-406d-90f5-07787eecafa4'),(4,11,'Default',1,'2015-11-01 19:24:58','2015-11-01 19:24:58','c851e9fa-9584-4c18-8bcb-694ae2e114b0'),(5,12,'Tab 1',1,'2015-11-01 19:26:08','2015-11-01 19:26:08','62ac219c-c061-499b-a49c-7b2d53ae507f');
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(58) COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `instructions` text COLLATE utf8_unicode_ci,
  `translatable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_groupId_fk` (`groupId`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
INSERT INTO `craft_fields` VALUES (1,1,'Body','body','global','',0,'RichText','{\"configFile\":\"Simple.json\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\"}','2015-11-01 19:06:12','2016-01-06 11:59:29','f03302f7-4f41-4ba2-ae14-721a99f5615e'),(3,1,'Price','price','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2015-11-01 19:19:56','2015-11-01 19:19:56','ee0f6c2c-df96-4734-bd7f-b0e4ca93cdf4'),(4,1,'Video/audio embed','embed','global','',0,'RichText','{\"configFile\":\"\",\"cleanupHtml\":\"\",\"purifyHtml\":\"\",\"columnType\":\"text\"}','2015-11-01 19:20:10','2016-01-05 14:17:35','8c7dce35-e868-4474-a6f3-69870bdd4ed7'),(5,1,'Tickets link','ticketsLink','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2015-11-01 19:20:19','2015-11-01 19:20:19','deedf369-c5b5-4c07-bc74-70ae3cba1929'),(6,1,'Date','date','global','',0,'Date','{\"minuteIncrement\":\"30\",\"showTime\":1,\"showDate\":1}','2015-11-01 19:20:42','2015-11-01 19:20:42','7d4b3d8e-ecbb-4e48-8a15-2c4b2505f9e6'),(7,1,'Image','image','global','To look best this image should be 1120px wide by 850px high.',0,'Assets','{\"useSingleFolder\":\"\",\"sources\":\"*\",\"defaultUploadLocationSource\":\"1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"limit\":\"\",\"selectionLabel\":\"Add an asset\"}','2015-11-01 19:20:55','2016-01-05 15:06:19','512510de-f19f-496b-8cf9-13afc639f06b');
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `craft_globalsets_handle_unq_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_import_entries`
--

DROP TABLE IF EXISTS `craft_import_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_import_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `historyId` int(11) DEFAULT NULL,
  `entryId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_import_entries_historyId_fk` (`historyId`),
  KEY `craft_import_entries_entryId_fk` (`entryId`),
  CONSTRAINT `craft_import_entries_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_import_entries_historyId_fk` FOREIGN KEY (`historyId`) REFERENCES `craft_import_history` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_import_entries`
--

LOCK TABLES `craft_import_entries` WRITE;
/*!40000 ALTER TABLE `craft_import_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_import_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_import_history`
--

DROP TABLE IF EXISTS `craft_import_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_import_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rows` int(10) DEFAULT NULL,
  `behavior` enum('append','replace','delete') COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('started','finished','reverted') COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_import_history_userId_fk` (`userId`),
  CONSTRAINT `craft_import_history_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_import_history`
--

LOCK TABLES `craft_import_history` WRITE;
/*!40000 ALTER TABLE `craft_import_history` DISABLE KEYS */;
INSERT INTO `craft_import_history` VALUES (1,1,'Entry','export.csv',7,'append','finished','2015-11-01 19:25:15','2015-11-01 19:25:15','2f2dfdc1-2da1-4d6f-988b-4790cd9abc99');
/*!40000 ALTER TABLE `craft_import_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_import_log`
--

DROP TABLE IF EXISTS `craft_import_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_import_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `historyId` int(11) DEFAULT NULL,
  `line` int(10) DEFAULT NULL,
  `errors` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_import_log_historyId_fk` (`historyId`),
  CONSTRAINT `craft_import_log_historyId_fk` FOREIGN KEY (`historyId`) REFERENCES `craft_import_history` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_import_log`
--

LOCK TABLES `craft_import_log` WRITE;
/*!40000 ALTER TABLE `craft_import_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_import_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `build` int(11) unsigned NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `releaseDate` datetime NOT NULL,
  `edition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `siteUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `on` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `track` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
INSERT INTO `craft_info` VALUES (1,'2.4',2670,'2.4.0','2015-06-16 18:59:31',0,'Shapes','http://46.101.84.161','Europe/London',1,0,'stable','2015-11-01 19:06:11','2016-01-05 17:46:47','b131e7b8-3563-4a17-a920-b60bcbddd6c7');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_locales`
--

DROP TABLE IF EXISTS `craft_locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_locales` (
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`locale`),
  KEY `craft_locales_sortOrder_idx` (`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_locales`
--

LOCK TABLES `craft_locales` WRITE;
/*!40000 ALTER TABLE `craft_locales` DISABLE KEYS */;
INSERT INTO `craft_locales` VALUES ('en_gb',1,'2015-11-01 19:06:11','2015-11-01 19:06:11','e923303c-3d8e-4407-9f98-fded0ef2c3a4');
/*!40000 ALTER TABLE `craft_locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_version_unq_idx` (`version`),
  KEY `craft_migrations_pluginId_fk` (`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
INSERT INTO `craft_migrations` VALUES (1,NULL,'m000000_000000_base','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','66006ae7-34e8-4029-b5d0-8aabae0a6ceb'),(2,NULL,'m140730_000001_add_filename_and_format_to_transformindex','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','c5040b31-a9cf-47e6-b003-72ab4eabb05f'),(3,NULL,'m140815_000001_add_format_to_transforms','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','801f47f7-1479-4e98-b32c-aef545b9cb6d'),(4,NULL,'m140822_000001_allow_more_than_128_items_per_field','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','a361f0dc-f544-4267-85dd-422ede97962d'),(5,NULL,'m140829_000001_single_title_formats','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','33fec02f-0878-4dce-b438-2c5ef87b0e6d'),(6,NULL,'m140831_000001_extended_cache_keys','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','62dc3cc5-8c51-4da0-b1ea-362e2cb96614'),(7,NULL,'m140922_000001_delete_orphaned_matrix_blocks','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','dd89799a-0f29-4991-ad7a-be6587344852'),(8,NULL,'m141008_000001_elements_index_tune','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','e23d03b2-7beb-4323-a764-ba1ba28e2220'),(9,NULL,'m141009_000001_assets_source_handle','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','1a8e12c9-bd32-492a-a94c-57fa9d692d34'),(10,NULL,'m141024_000001_field_layout_tabs','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','6cbd5349-1510-4de3-8be9-4ed28f5293b4'),(11,NULL,'m141030_000001_drop_structure_move_permission','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','d34162e5-c543-4895-92d7-682d2ef65bcb'),(12,NULL,'m141103_000001_tag_titles','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','811744fb-ce04-4f55-b9be-a0d9687c1d92'),(13,NULL,'m141109_000001_user_status_shuffle','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','fe6aa683-d9f8-437e-9419-e17ac6d528a6'),(14,NULL,'m141126_000001_user_week_start_day','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','3bb5bdfc-9e17-438e-a96c-725f0db2330e'),(15,NULL,'m150210_000001_adjust_user_photo_size','2015-11-01 19:06:11','2015-11-01 19:06:11','2015-11-01 19:06:11','4f060f0e-1629-4b95-9613-55511c7e2328'),(16,2,'m140430_122214_import_ImportHistory','2015-11-01 19:16:55','2015-11-01 19:16:55','2015-11-01 19:16:55','75a69327-8201-4675-b939-433c706a5c7a'),(17,2,'m140616_080724_import_saveEntryIdAndVersion','2015-11-01 19:16:55','2015-11-01 19:16:55','2015-11-01 19:16:55','5e86f141-3022-4a7a-983c-63d2c52c069d'),(18,2,'m140903_075432_import_ImportElements','2015-11-01 19:16:55','2015-11-01 19:16:55','2015-11-01 19:16:55','5b4c408e-fe18-4c3d-a541-c6747786900f'),(19,4,'m140924_111621_export_CreateExportMap','2016-01-04 11:52:10','2016-01-04 11:52:10','2016-01-04 11:52:10','69cab535-1cd5-4e70-9252-c13ed6739d3b');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `version` char(15) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `settings` text COLLATE utf8_unicode_ci,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
INSERT INTO `craft_plugins` VALUES (1,'InfiniteScroll','1.0',1,NULL,'2015-11-01 19:06:51','2015-11-01 19:06:51','2015-11-01 19:06:51','9b4febcd-37a7-48f4-b9f9-6e9ede0feeae'),(2,'Import','0.8.27',1,NULL,'2015-11-01 19:16:55','2015-11-01 19:16:55','2015-11-01 19:16:55','cd04ae58-ae9e-45c9-a7c8-4c20e719e454'),(3,'ContactForm','1.4',1,NULL,'2016-01-04 11:52:08','2016-01-04 11:52:08','2016-01-04 11:52:08','d85ffad1-9f27-454e-bcd3-118ada2db884'),(4,'Export','0.5.7',1,NULL,'2016-01-04 11:52:10','2016-01-04 11:52:10','2016-01-04 11:52:10','7f680a75-9480-468c-ae70-1ef6c54af9ab'),(5,'MailchimpSubscribe','0.6',1,NULL,'2016-01-04 11:52:17','2016-01-04 11:52:17','2016-01-04 11:52:17','1371e166-18f3-4fdf-ab2d-ce3857e6159e');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_rackspaceaccess`
--

DROP TABLE IF EXISTS `craft_rackspaceaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_rackspaceaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storageUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cdnUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_rackspaceaccess_connectionKey_unq_idx` (`connectionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_rackspaceaccess`
--

LOCK TABLES `craft_rackspaceaccess` WRITE;
/*!40000 ALTER TABLE `craft_rackspaceaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_rackspaceaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceLocale_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceLocale`,`targetId`),
  KEY `craft_relations_sourceId_fk` (`sourceId`),
  KEY `craft_relations_sourceLocale_fk` (`sourceLocale`),
  KEY `craft_relations_targetId_fk` (`targetId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceLocale_fk` FOREIGN KEY (`sourceLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
INSERT INTO `craft_relations` VALUES (25,7,6,NULL,32,1,'2016-01-05 15:09:14','2016-01-05 15:09:14','39eb8058-ea35-45da-80b7-d92c0ca0c5bf'),(26,7,7,NULL,31,1,'2016-01-05 15:09:28','2016-01-05 15:09:28','6ce9c53c-9d33-4b4f-b278-b1bf10113fa3'),(28,7,9,NULL,32,1,'2016-01-05 15:09:53','2016-01-05 15:09:53','ec083a81-5ed8-484c-afc1-8b277be49dca'),(29,7,10,NULL,31,1,'2016-01-05 15:10:03','2016-01-05 15:10:03','e27c5c60-32a5-468b-bcaa-31484594d85a'),(30,7,11,NULL,30,1,'2016-01-05 15:10:13','2016-01-05 15:10:13','2b9a5f6b-e94f-4ca1-9466-edec19fdb8bf'),(31,7,12,NULL,32,1,'2016-01-05 15:10:24','2016-01-05 15:10:24','b9d16599-a78b-4563-8af9-0c2f805aac7f'),(32,7,8,NULL,30,1,'2016-01-05 15:12:06','2016-01-05 15:12:06','a4a76542-ba43-4ca8-94e1-bf25309feac0');
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_routes`
--

DROP TABLE IF EXISTS `craft_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urlParts` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `urlPattern` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_routes_urlPattern_unq_idx` (`urlPattern`),
  KEY `craft_routes_locale_idx` (`locale`),
  CONSTRAINT `craft_routes_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_routes`
--

LOCK TABLES `craft_routes` WRITE;
/*!40000 ALTER TABLE `craft_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `fieldId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`locale`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,'en_gb',' vidhi '),(1,'firstname',0,'en_gb',' vidhi '),(1,'lastname',0,'en_gb',' gandhi '),(1,'fullname',0,'en_gb',' vidhi gandhi '),(1,'email',0,'en_gb',' vidhi shapeshackney com '),(1,'slug',0,'en_gb',''),(6,'field',5,'en_gb',' http seetickets com '),(6,'slug',0,'en_gb',' bonobo dan shake bradley zero '),(6,'title',0,'en_gb',' bonobo dan shake bradley zero '),(7,'field',1,'en_gb',' this is most certainly something special for the first time in two years in london bonobo puts down his bass and takes to the decks for an exclusive dj set at super stylish new venue shapes in hackney '),(7,'field',6,'en_gb',' 2015 05 10 '),(4,'slug',0,'en_gb',' about '),(4,'title',0,'en_gb',' about '),(5,'slug',0,'en_gb',''),(5,'title',0,'en_gb',' getting here '),(6,'field',1,'en_gb',' this is most certainly something special for the first time in two years in london bonobo puts down his bass and takes to the decks for an exclusive dj set at super stylish new venue shapes in hackney '),(6,'field',6,'en_gb',' 2015 11 05 '),(6,'field',7,'en_gb',' bonobo '),(6,'field',3,'en_gb',' 15 00 '),(6,'field',4,'en_gb',''),(7,'field',7,'en_gb',' kamasi '),(7,'field',3,'en_gb',' 15 00 '),(7,'field',4,'en_gb',''),(7,'field',5,'en_gb',' http seetickets com '),(7,'slug',0,'en_gb',' kamasi washington '),(7,'title',0,'en_gb',' kamasi washington '),(8,'field',1,'en_gb',' this is most certainly something special for the first time in two years in london bonobo puts down his bass and takes to the decks for an exclusive dj set at super stylish new venue shapes in hackney '),(8,'field',6,'en_gb',' 2015 02 10 '),(8,'field',7,'en_gb',' craig '),(8,'field',3,'en_gb',' 12 00 '),(8,'field',4,'en_gb',''),(8,'field',5,'en_gb',' http seetickets com '),(8,'slug',0,'en_gb',' craig david '),(8,'title',0,'en_gb',' craig david '),(9,'field',1,'en_gb',' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(9,'field',6,'en_gb',' 2015 01 01 '),(9,'field',7,'en_gb',' bonobo '),(9,'field',3,'en_gb',' 12 00 20 00 '),(9,'field',4,'en_gb',''),(9,'field',5,'en_gb',' http seetickets com '),(9,'slug',0,'en_gb',' lorem ipsum '),(9,'title',0,'en_gb',' lorem ipsum '),(10,'field',1,'en_gb',' lit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(10,'field',6,'en_gb',' 2014 12 09 '),(10,'field',7,'en_gb',' kamasi '),(10,'field',3,'en_gb',''),(10,'field',4,'en_gb',''),(10,'field',5,'en_gb',''),(10,'slug',0,'en_gb',' exercitation ullamco laboris nisi '),(10,'title',0,'en_gb',' exercitation ullamco laboris nisi '),(11,'field',1,'en_gb',' sit consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(11,'field',6,'en_gb',' 2014 08 06 '),(11,'field',7,'en_gb',' craig '),(11,'field',3,'en_gb',''),(11,'field',4,'en_gb',''),(11,'field',5,'en_gb',' http seetickets com '),(11,'slug',0,'en_gb',' ullamco laboris '),(11,'title',0,'en_gb',' ullamco laboris '),(12,'field',1,'en_gb',' am veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit qua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(12,'field',6,'en_gb',' 2014 04 15 '),(12,'field',7,'en_gb',' bonobo '),(12,'field',3,'en_gb',' 12 00 15 00 '),(12,'field',4,'en_gb',''),(12,'field',5,'en_gb',' http seetickets com '),(12,'slug',0,'en_gb',' duis aute irure dolor '),(12,'title',0,'en_gb',' duis aute irure dolor '),(4,'field',1,'en_gb',' we play events space social club artist studios set in a converted warehouse on the river lee we connect a collaborative creative environment to encourage innovation community we host exhibitions to shoots to corporate creative events you are in safe hands '),(32,'title',0,'en_gb',' bonobo '),(32,'slug',0,'en_gb',''),(32,'kind',0,'en_gb',' image '),(32,'extension',0,'en_gb',' jpg '),(32,'filename',0,'en_gb',' bonobo jpg '),(31,'title',0,'en_gb',' kamasi '),(31,'slug',0,'en_gb',''),(31,'kind',0,'en_gb',' image '),(31,'extension',0,'en_gb',' jpg '),(31,'filename',0,'en_gb',' kamasi jpg '),(30,'title',0,'en_gb',' craig '),(30,'kind',0,'en_gb',' image '),(30,'slug',0,'en_gb',''),(30,'extension',0,'en_gb',' jpg '),(30,'filename',0,'en_gb',' craig jpg ');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('single','channel','structure') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'channel',
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enableVersioning` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_name_unq_idx` (`name`),
  UNIQUE KEY `craft_sections_handle_unq_idx` (`handle`),
  KEY `craft_sections_structureId_fk` (`structureId`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
INSERT INTO `craft_sections` VALUES (3,NULL,'Events','events','channel',1,'events/_entry',1,'2015-11-01 19:18:28','2015-11-01 19:18:28','71bf2fa3-ae3d-4f49-b70d-716b60c555bf'),(4,NULL,'About','about','single',1,'about',1,'2015-11-01 19:18:36','2015-11-01 19:18:36','9db9a0b3-0e9f-4b48-a603-b237c9ce1c9e'),(5,NULL,'Getting here','gettingHere','single',1,'getting-here',1,'2015-11-01 19:18:44','2015-11-01 19:18:44','7db6e36b-d8d1-4e3e-a50d-7926d5b8a14d');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections_i18n`
--

DROP TABLE IF EXISTS `craft_sections_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `enabledByDefault` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `urlFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nestedUrlFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_i18n_sectionId_locale_unq_idx` (`sectionId`,`locale`),
  KEY `craft_sections_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_sections_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_sections_i18n_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections_i18n`
--

LOCK TABLES `craft_sections_i18n` WRITE;
/*!40000 ALTER TABLE `craft_sections_i18n` DISABLE KEYS */;
INSERT INTO `craft_sections_i18n` VALUES (3,3,'en_gb',0,'events/{slug}',NULL,'2015-11-01 19:18:28','2015-11-01 19:18:28','a8543b86-5575-4638-aa5a-ea16490cfe11'),(4,4,'en_gb',0,'about',NULL,'2015-11-01 19:18:36','2015-11-01 19:18:36','15cff963-79c1-4bdc-b5b3-a686e9aa5e0e'),(5,5,'en_gb',0,'getting-here',NULL,'2015-11-01 19:18:44','2015-11-01 19:18:44','760847b6-c2a6-40c2-979b-4caddbe0ccfe');
/*!40000 ALTER TABLE `craft_sections_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_fk` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sessions`
--

LOCK TABLES `craft_sessions` WRITE;
/*!40000 ALTER TABLE `craft_sessions` DISABLE KEYS */;
INSERT INTO `craft_sessions` VALUES (1,1,'a9650fbdc3a1758096b2e445d4b5b7af491421fcczozMjoiNWpaS2ZKOEVPT2p0WTBzdEpnWDRCTm5WR2ZKZm5ROWgiOw==','2015-11-01 19:06:12','2015-11-01 19:06:12','abcffd73-c33e-446d-9c25-c0f01ed818cd'),(2,1,'ab7dcfeed64aa9c250f89b8e62ffec225565786bczozMjoiSkxSYWdtTVl4ZGcwVWhOR1ZfaXlrZ2t0Z0JiQ3k2ZzEiOw==','2016-01-04 19:27:19','2016-01-05 14:06:06','51f606ef-7eaa-43d0-968c-2267348215cb'),(5,1,'c237b4ebf1542b88415738c9dacdc5786371a8b2czozMjoiUW5TaDk0cnBLbTg5dE1VY1o4SkFia3VidTBTUUlET3oiOw==','2016-01-05 16:19:30','2016-01-05 16:19:30','54b50510-3311-4167-80e5-3cd62dbb4c84'),(7,1,'73f0246cf3321fbd96948fa5fc34bb16bde105e2czozMjoiWGRaWn5HMUVXSW53cEYzfnFnfkJSSWZveFJDX2ppSVMiOw==','2016-01-05 18:02:03','2016-01-05 18:02:03','0e861f62-f0e0-40c0-b2f9-9ea2c9a29352');
/*!40000 ALTER TABLE `craft_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_systemsettings`
--

DROP TABLE IF EXISTS `craft_systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_systemsettings`
--

LOCK TABLES `craft_systemsettings` WRITE;
/*!40000 ALTER TABLE `craft_systemsettings` DISABLE KEYS */;
INSERT INTO `craft_systemsettings` VALUES (1,'email','{\"protocol\":\"sendmail\",\"emailAddress\":\"vidhi@shapeshackney.com\",\"senderName\":\"Shapes\"}','2015-11-01 19:06:12','2016-01-05 18:16:20','c6083eaf-f383-453f-b658-194b16abff76');
/*!40000 ALTER TABLE `craft_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_taggroups_handle_unq_idx` (`handle`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
INSERT INTO `craft_taggroups` VALUES (1,'Default','default',1,'2015-11-01 19:06:12','2015-11-01 19:06:12','de4653e0-5668-44aa-ac78-593507ae7e19');
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_fk` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tasks`
--

DROP TABLE IF EXISTS `craft_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `currentStep` int(11) unsigned DEFAULT NULL,
  `totalSteps` int(11) unsigned DEFAULT NULL,
  `status` enum('pending','error','running') COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tasks_root_idx` (`root`),
  KEY `craft_tasks_lft_idx` (`lft`),
  KEY `craft_tasks_rgt_idx` (`rgt`),
  KEY `craft_tasks_level_idx` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tasks`
--

LOCK TABLES `craft_tasks` WRITE;
/*!40000 ALTER TABLE `craft_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecachecriteria`
--

DROP TABLE IF EXISTS `craft_templatecachecriteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachecriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `criteria` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachecriteria_cacheId_fk` (`cacheId`),
  KEY `craft_templatecachecriteria_type_idx` (`type`),
  CONSTRAINT `craft_templatecachecriteria_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecachecriteria`
--

LOCK TABLES `craft_templatecachecriteria` WRITE;
/*!40000 ALTER TABLE `craft_templatecachecriteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecachecriteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_fk` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecacheelements`
--

LOCK TABLES `craft_templatecacheelements` WRITE;
/*!40000 ALTER TABLE `craft_templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_expiryDate_cacheKey_locale_path_idx` (`expiryDate`,`cacheKey`,`locale`,`path`),
  KEY `craft_templatecaches_locale_fk` (`locale`),
  CONSTRAINT `craft_templatecaches_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecaches`
--

LOCK TABLES `craft_templatecaches` WRITE;
/*!40000 ALTER TABLE `craft_templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `route` text COLLATE utf8_unicode_ci,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_fk` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_fk` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_fk` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferredLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekStartDay` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `client` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `suspended` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pending` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIPAddress` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(4) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordResetRequired` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_users_username_unq_idx` (`username`),
  UNIQUE KEY `craft_users_email_unq_idx` (`email`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_preferredLocale_fk` (`preferredLocale`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_preferredLocale_fk` FOREIGN KEY (`preferredLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
INSERT INTO `craft_users` VALUES (1,'vidhi',NULL,'Vidhi','Gandhi','vidhi@shapeshackney.com','$2y$13$qXATDDidOeveby9VuRxG2uUarQbdrTc.dTl4SnWGc.xddebxU2mxu',NULL,1,1,0,0,0,0,0,'2016-01-06 11:58:41','74.125.57.118',NULL,NULL,'2016-01-04 19:26:44',NULL,NULL,NULL,NULL,0,'2015-11-01 20:59:34','2015-11-01 19:06:12','2016-01-06 11:58:41','86e1dbc0-a909-4ca0-ba53-64ffaf075810');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_fk` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
INSERT INTO `craft_widgets` VALUES (1,1,'RecentEntries',1,NULL,1,'2015-11-01 19:06:15','2015-11-01 19:06:15','e3bb8371-e5e6-4313-98a4-082474af870e'),(2,1,'GetHelp',2,NULL,0,'2015-11-01 19:06:15','2016-01-05 16:24:15','f8a181b8-45e0-4894-8bd4-fd70ca1c4c31'),(3,1,'Updates',3,NULL,0,'2015-11-01 19:06:15','2016-01-05 16:24:18','4ce9e78a-e73f-46f8-a2d4-2af441aea4bd'),(4,1,'Feed',4,'{\"url\":\"http:\\/\\/feeds.feedburner.com\\/blogandtonic\",\"title\":\"Blog & Tonic\"}',0,'2015-11-01 19:06:15','2016-01-05 16:24:20','eb5c98c5-09e6-4fa4-8f4e-eda4983af5be'),(5,1,'QuickPost',5,'{\"section\":\"3\",\"entryType\":\"\",\"fields\":[\"1\",\"6\",\"7\",\"3\"]}',1,'2016-01-05 16:24:55','2016-01-05 16:24:55','76049b84-d826-4858-975e-8aaa0dc8c437');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-06  7:30:46
