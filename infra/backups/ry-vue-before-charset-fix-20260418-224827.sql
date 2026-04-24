-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_nameçš„å¤–é”®',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  `blob_data` blob COMMENT 'å­˜æ”¾æŒä¹…åŒ–Triggerå¯¹è±¡',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blobç±»åž‹çš„è§¦å‘å™¨è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ—¥åŽ†åç§°',
  `calendar` blob NOT NULL COMMENT 'å­˜æ”¾æŒä¹…åŒ–calendarå¯¹è±¡',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='æ—¥åŽ†ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_nameçš„å¤–é”®',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  `cron_expression` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cronè¡¨è¾¾å¼',
  `time_zone_id` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ—¶åŒº',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cronç±»åž‹çš„è§¦å‘å™¨è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `entry_id` varchar(95) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦å™¨å®žä¾‹id',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_nameçš„å¤–é”®',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦å™¨å®žä¾‹å',
  `fired_time` bigint NOT NULL COMMENT 'è§¦å‘çš„æ—¶é—´',
  `sched_time` bigint NOT NULL COMMENT 'å®šæ—¶å™¨åˆ¶å®šçš„æ—¶é—´',
  `priority` int NOT NULL COMMENT 'ä¼˜å…ˆçº§',
  `state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'çŠ¶æ€',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ä»»åŠ¡åç§°',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ä»»åŠ¡ç»„å',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦å¹¶å‘',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦æŽ¥å—æ¢å¤æ‰§è¡Œ',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å·²è§¦å‘çš„è§¦å‘å™¨è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ä»»åŠ¡åç§°',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ä»»åŠ¡ç»„å',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç›¸å…³ä»‹ç»',
  `job_class_name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ‰§è¡Œä»»åŠ¡ç±»åç§°',
  `is_durable` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ˜¯å¦æŒä¹…åŒ–',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ˜¯å¦å¹¶å‘',
  `is_update_data` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ˜¯å¦æ›´æ–°æ•°æ®',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ˜¯å¦æŽ¥å—æ¢å¤æ‰§è¡Œ',
  `job_data` blob COMMENT 'å­˜æ”¾æŒä¹…åŒ–jobå¯¹è±¡',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ä»»åŠ¡è¯¦ç»†ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `lock_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'æ‚²è§‚é”åç§°',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å­˜å‚¨çš„æ‚²è§‚é”ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='æš‚åœçš„è§¦å‘å™¨è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'å®žä¾‹åç§°',
  `last_checkin_time` bigint NOT NULL COMMENT 'ä¸Šæ¬¡æ£€æŸ¥æ—¶é—´',
  `checkin_interval` bigint NOT NULL COMMENT 'æ£€æŸ¥é—´éš”æ—¶é—´',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='è°ƒåº¦å™¨çŠ¶æ€è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_nameçš„å¤–é”®',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  `repeat_count` bigint NOT NULL COMMENT 'é‡å¤çš„æ¬¡æ•°ç»Ÿè®¡',
  `repeat_interval` bigint NOT NULL COMMENT 'é‡å¤çš„é—´éš”æ—¶é—´',
  `times_triggered` bigint NOT NULL COMMENT 'å·²ç»è§¦å‘çš„æ¬¡æ•°',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ç®€å•è§¦å‘å™¨çš„ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_nameçš„å¤–é”®',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggersè¡¨trigger_groupçš„å¤–é”®',
  `str_prop_1` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Stringç±»åž‹çš„triggerçš„ç¬¬ä¸€ä¸ªå‚æ•°',
  `str_prop_2` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Stringç±»åž‹çš„triggerçš„ç¬¬äºŒä¸ªå‚æ•°',
  `str_prop_3` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Stringç±»åž‹çš„triggerçš„ç¬¬ä¸‰ä¸ªå‚æ•°',
  `int_prop_1` int DEFAULT NULL COMMENT 'intç±»åž‹çš„triggerçš„ç¬¬ä¸€ä¸ªå‚æ•°',
  `int_prop_2` int DEFAULT NULL COMMENT 'intç±»åž‹çš„triggerçš„ç¬¬äºŒä¸ªå‚æ•°',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'longç±»åž‹çš„triggerçš„ç¬¬ä¸€ä¸ªå‚æ•°',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'longç±»åž‹çš„triggerçš„ç¬¬äºŒä¸ªå‚æ•°',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimalç±»åž‹çš„triggerçš„ç¬¬ä¸€ä¸ªå‚æ•°',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimalç±»åž‹çš„triggerçš„ç¬¬äºŒä¸ªå‚æ•°',
  `bool_prop_1` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Booleanç±»åž‹çš„triggerçš„ç¬¬ä¸€ä¸ªå‚æ•°',
  `bool_prop_2` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Booleanç±»åž‹çš„triggerçš„ç¬¬äºŒä¸ªå‚æ•°',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='åŒæ­¥æœºåˆ¶çš„è¡Œé”è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPROP_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPROP_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒåº¦åç§°',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§¦å‘å™¨çš„åå­—',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§¦å‘å™¨æ‰€å±žç»„çš„åå­—',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_detailsè¡¨job_nameçš„å¤–é”®',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_detailsè¡¨job_groupçš„å¤–é”®',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç›¸å…³ä»‹ç»',
  `next_fire_time` bigint DEFAULT NULL COMMENT 'ä¸Šä¸€æ¬¡è§¦å‘æ—¶é—´ï¼ˆæ¯«ç§’ï¼‰',
  `prev_fire_time` bigint DEFAULT NULL COMMENT 'ä¸‹ä¸€æ¬¡è§¦å‘æ—¶é—´ï¼ˆé»˜è®¤ä¸º-1è¡¨ç¤ºä¸è§¦å‘ï¼‰',
  `priority` int DEFAULT NULL COMMENT 'ä¼˜å…ˆçº§',
  `trigger_state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§¦å‘å™¨çŠ¶æ€',
  `trigger_type` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§¦å‘å™¨çš„ç±»åž‹',
  `start_time` bigint NOT NULL COMMENT 'å¼€å§‹æ—¶é—´',
  `end_time` bigint DEFAULT NULL COMMENT 'ç»“æŸæ—¶é—´',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ—¥ç¨‹è¡¨åç§°',
  `misfire_instr` smallint DEFAULT NULL COMMENT 'è¡¥å¿æ‰§è¡Œçš„ç­–ç•¥',
  `job_data` blob COMMENT 'å­˜æ”¾æŒä¹…åŒ–jobå¯¹è±¡',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='è§¦å‘å™¨è¯¦ç»†ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ç¼–å·',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¡¨åç§°',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¡¨æè¿°',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å…³è”å­è¡¨çš„è¡¨å',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å­è¡¨å…³è”çš„å¤–é”®å',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å®žä½“ç±»åç§°',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT 'ä½¿ç”¨çš„æ¨¡æ¿ï¼ˆcrudå•è¡¨æ“ä½œ treeæ ‘è¡¨æ“ä½œï¼‰',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å‰ç«¯æ¨¡æ¿ç±»åž‹ï¼ˆelement-uiæ¨¡ç‰ˆ element-plusæ¨¡ç‰ˆï¼‰',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç”ŸæˆåŒ…è·¯å¾„',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç”Ÿæˆæ¨¡å—å',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç”Ÿæˆä¸šåŠ¡å',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç”ŸæˆåŠŸèƒ½å',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç”ŸæˆåŠŸèƒ½ä½œè€…',
  `form_col_num` int DEFAULT '1' COMMENT 'è¡¨å•å¸ƒå±€ï¼ˆå•åˆ— åŒåˆ— ä¸‰åˆ—ï¼‰',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'ç”Ÿæˆä»£ç æ–¹å¼ï¼ˆ0zipåŽ‹ç¼©åŒ… 1è‡ªå®šä¹‰è·¯å¾„ï¼‰',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT 'ç”Ÿæˆè·¯å¾„ï¼ˆä¸å¡«é»˜è®¤é¡¹ç›®è·¯å¾„ï¼‰',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å…¶å®ƒç”Ÿæˆé€‰é¡¹',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ä»£ç ç”Ÿæˆä¸šåŠ¡è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ç¼–å·',
  `table_id` bigint DEFAULT NULL COMMENT 'å½’å±žè¡¨ç¼–å·',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'åˆ—åç§°',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'åˆ—æè¿°',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'åˆ—ç±»åž‹',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVAç±»åž‹',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVAå­—æ®µå',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦ä¸»é”®ï¼ˆ1æ˜¯ï¼‰',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦è‡ªå¢žï¼ˆ1æ˜¯ï¼‰',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦å¿…å¡«ï¼ˆ1æ˜¯ï¼‰',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦ä¸ºæ’å…¥å­—æ®µï¼ˆ1æ˜¯ï¼‰',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦ç¼–è¾‘å­—æ®µï¼ˆ1æ˜¯ï¼‰',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦åˆ—è¡¨å­—æ®µï¼ˆ1æ˜¯ï¼‰',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¯å¦æŸ¥è¯¢å­—æ®µï¼ˆ1æ˜¯ï¼‰',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT 'æŸ¥è¯¢æ–¹å¼ï¼ˆç­‰äºŽã€ä¸ç­‰äºŽã€å¤§äºŽã€å°äºŽã€èŒƒå›´ï¼‰',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ˜¾ç¤ºç±»åž‹ï¼ˆæ–‡æœ¬æ¡†ã€æ–‡æœ¬åŸŸã€ä¸‹æ‹‰æ¡†ã€å¤é€‰æ¡†ã€å•é€‰æ¡†ã€æ—¥æœŸæŽ§ä»¶ï¼‰',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸ç±»åž‹',
  `sort` int DEFAULT NULL COMMENT 'æŽ’åº',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ä»£ç ç”Ÿæˆä¸šåŠ¡è¡¨å­—æ®µ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT 'å‚æ•°ä¸»é”®',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å‚æ•°åç§°',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å‚æ•°é”®å',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å‚æ•°é”®å€¼',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT 'ç³»ç»Ÿå†…ç½®ï¼ˆYæ˜¯ Nå¦ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å‚æ•°é…ç½®è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'ä¸»æ¡†æž¶é¡µ-é»˜è®¤çš®è‚¤æ ·å¼åç§°','sys.index.skinName','skin-blue','Y','admin','2026-04-18 22:19:51','',NULL,'è“è‰² skin-blueã€ç»¿è‰² skin-greenã€ç´«è‰² skin-purpleã€çº¢è‰² skin-redã€é»„è‰² skin-yellow'),(2,'ç”¨æˆ·ç®¡ç†-è´¦å·åˆå§‹å¯†ç ','sys.user.initPassword','123456','Y','admin','2026-04-18 22:19:51','',NULL,'åˆå§‹åŒ–å¯†ç  123456'),(3,'ä¸»æ¡†æž¶é¡µ-ä¾§è¾¹æ ä¸»é¢˜','sys.index.sideTheme','theme-dark','Y','admin','2026-04-18 22:19:51','',NULL,'æ·±è‰²ä¸»é¢˜theme-darkï¼Œæµ…è‰²ä¸»é¢˜theme-light'),(4,'è´¦å·è‡ªåŠ©-éªŒè¯ç å¼€å…³','sys.account.captchaEnabled','true','Y','admin','2026-04-18 22:19:51','',NULL,'æ˜¯å¦å¼€å¯éªŒè¯ç åŠŸèƒ½ï¼ˆtrueå¼€å¯ï¼Œfalseå…³é—­ï¼‰'),(5,'è´¦å·è‡ªåŠ©-æ˜¯å¦å¼€å¯ç”¨æˆ·æ³¨å†ŒåŠŸèƒ½','sys.account.registerUser','false','Y','admin','2026-04-18 22:19:51','',NULL,'æ˜¯å¦å¼€å¯æ³¨å†Œç”¨æˆ·åŠŸèƒ½ï¼ˆtrueå¼€å¯ï¼Œfalseå…³é—­ï¼‰'),(6,'ç”¨æˆ·ç™»å½•-é»‘åå•åˆ—è¡¨','sys.login.blackIPList','','Y','admin','2026-04-18 22:19:51','',NULL,'è®¾ç½®ç™»å½•IPé»‘åå•é™åˆ¶ï¼Œå¤šä¸ªåŒ¹é…é¡¹ä»¥;åˆ†éš”ï¼Œæ”¯æŒåŒ¹é…ï¼ˆ*é€šé…ã€ç½‘æ®µï¼‰'),(7,'ç”¨æˆ·ç®¡ç†-åˆå§‹å¯†ç ä¿®æ”¹ç­–ç•¥','sys.account.initPasswordModify','1','Y','admin','2026-04-18 22:19:51','',NULL,'0ï¼šåˆå§‹å¯†ç ä¿®æ”¹ç­–ç•¥å…³é—­ï¼Œæ²¡æœ‰ä»»ä½•æç¤ºï¼Œ1ï¼šæé†’ç”¨æˆ·ï¼Œå¦‚æžœæœªä¿®æ”¹åˆå§‹å¯†ç ï¼Œåˆ™åœ¨ç™»å½•æ—¶å°±ä¼šæé†’ä¿®æ”¹å¯†ç å¯¹è¯æ¡†'),(8,'ç”¨æˆ·ç®¡ç†-è´¦å·å¯†ç æ›´æ–°å‘¨æœŸ','sys.account.passwordValidateDays','0','Y','admin','2026-04-18 22:19:51','',NULL,'å¯†ç æ›´æ–°å‘¨æœŸï¼ˆå¡«å†™æ•°å­—ï¼Œæ•°æ®åˆå§‹åŒ–å€¼ä¸º0ä¸é™åˆ¶ï¼Œè‹¥ä¿®æ”¹å¿…é¡»ä¸ºå¤§äºŽ0å°äºŽ365çš„æ­£æ•´æ•°ï¼‰ï¼Œå¦‚æžœè¶…è¿‡è¿™ä¸ªå‘¨æœŸç™»å½•ç³»ç»Ÿæ—¶ï¼Œåˆ™åœ¨ç™»å½•æ—¶å°±ä¼šæé†’ä¿®æ”¹å¯†ç å¯¹è¯æ¡†'),(9,'ç”¨æˆ·ç®¡ç†-å¯†ç å­—ç¬¦èŒƒå›´','sys.account.chrtype','0','Y','admin','2026-04-18 22:19:51','',NULL,'é»˜è®¤ä»»æ„å­—ç¬¦èŒƒå›´ï¼Œ0ä»»æ„ï¼ˆå¯†ç å¯ä»¥è¾“å…¥ä»»æ„å­—ç¬¦ï¼‰ï¼Œ1æ•°å­—ï¼ˆå¯†ç åªèƒ½ä¸º0-9æ•°å­—ï¼‰ï¼Œ2è‹±æ–‡å­—æ¯ï¼ˆå¯†ç åªèƒ½ä¸ºa-zå’ŒA-Zå­—æ¯ï¼‰ï¼Œ3å­—æ¯å’Œæ•°å­—ï¼ˆå¯†ç å¿…é¡»åŒ…å«å­—æ¯ï¼Œæ•°å­—ï¼‰,4å­—æ¯æ•°å­—å’Œç‰¹æ®Šå­—ç¬¦ï¼ˆç›®å‰æ”¯æŒçš„ç‰¹æ®Šå­—ç¬¦åŒ…æ‹¬ï¼š~!@#$%^&*()-=_+ï¼‰');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'éƒ¨é—¨id',
  `parent_id` bigint DEFAULT '0' COMMENT 'çˆ¶éƒ¨é—¨id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ç¥–çº§åˆ—è¡¨',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'éƒ¨é—¨åç§°',
  `order_num` int DEFAULT '0' COMMENT 'æ˜¾ç¤ºé¡ºåº',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'è´Ÿè´£äºº',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'è”ç³»ç”µè¯',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'é‚®ç®±',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'éƒ¨é—¨çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'åˆ é™¤æ ‡å¿—ï¼ˆ0ä»£è¡¨å­˜åœ¨ 2ä»£è¡¨åˆ é™¤ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='éƒ¨é—¨è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','è‹¥ä¾ç§‘æŠ€',0,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(101,100,'0,100','æ·±åœ³æ€»å…¬å¸',1,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(102,100,'0,100','é•¿æ²™åˆ†å…¬å¸',2,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(103,101,'0,100,101','ç ”å‘éƒ¨é—¨',1,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(104,101,'0,100,101','å¸‚åœºéƒ¨é—¨',2,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(105,101,'0,100,101','æµ‹è¯•éƒ¨é—¨',3,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(106,101,'0,100,101','è´¢åŠ¡éƒ¨é—¨',4,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(107,101,'0,100,101','è¿ç»´éƒ¨é—¨',5,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(108,102,'0,100,102','å¸‚åœºéƒ¨é—¨',1,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL),(109,102,'0,100,102','è´¢åŠ¡éƒ¨é—¨',2,'è‹¥ä¾','15888888888','ry@qq.com','0','0','admin','2026-04-18 22:19:49','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT 'å­—å…¸ç¼–ç ',
  `dict_sort` int DEFAULT '0' COMMENT 'å­—å…¸æŽ’åº',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸æ ‡ç­¾',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸é”®å€¼',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸ç±»åž‹',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ ·å¼å±žæ€§ï¼ˆå…¶ä»–æ ·å¼æ‰©å±•ï¼‰',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'è¡¨æ ¼å›žæ˜¾æ ·å¼',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT 'æ˜¯å¦é»˜è®¤ï¼ˆYæ˜¯ Nå¦ï¼‰',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å­—å…¸æ•°æ®è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'ç”·','0','sys_user_sex','','','Y','0','admin','2026-04-18 22:19:50','',NULL,'æ€§åˆ«ç”·'),(2,2,'å¥³','1','sys_user_sex','','','N','0','admin','2026-04-18 22:19:50','',NULL,'æ€§åˆ«å¥³'),(3,3,'æœªçŸ¥','2','sys_user_sex','','','N','0','admin','2026-04-18 22:19:50','',NULL,'æ€§åˆ«æœªçŸ¥'),(4,1,'æ˜¾ç¤º','0','sys_show_hide','','primary','Y','0','admin','2026-04-18 22:19:50','',NULL,'æ˜¾ç¤ºèœå•'),(5,2,'éšè—','1','sys_show_hide','','danger','N','0','admin','2026-04-18 22:19:50','',NULL,'éšè—èœå•'),(6,1,'æ­£å¸¸','0','sys_normal_disable','','primary','Y','0','admin','2026-04-18 22:19:51','',NULL,'æ­£å¸¸çŠ¶æ€'),(7,2,'åœç”¨','1','sys_normal_disable','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'åœç”¨çŠ¶æ€'),(8,1,'æ­£å¸¸','0','sys_job_status','','primary','Y','0','admin','2026-04-18 22:19:51','',NULL,'æ­£å¸¸çŠ¶æ€'),(9,2,'æš‚åœ','1','sys_job_status','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'åœç”¨çŠ¶æ€'),(10,1,'é»˜è®¤','DEFAULT','sys_job_group','','','Y','0','admin','2026-04-18 22:19:51','',NULL,'é»˜è®¤åˆ†ç»„'),(11,2,'ç³»ç»Ÿ','SYSTEM','sys_job_group','','','N','0','admin','2026-04-18 22:19:51','',NULL,'ç³»ç»Ÿåˆ†ç»„'),(12,1,'æ˜¯','Y','sys_yes_no','','primary','Y','0','admin','2026-04-18 22:19:51','',NULL,'ç³»ç»Ÿé»˜è®¤æ˜¯'),(13,2,'å¦','N','sys_yes_no','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'ç³»ç»Ÿé»˜è®¤å¦'),(14,1,'é€šçŸ¥','1','sys_notice_type','','warning','Y','0','admin','2026-04-18 22:19:51','',NULL,'é€šçŸ¥'),(15,2,'å…¬å‘Š','2','sys_notice_type','','success','N','0','admin','2026-04-18 22:19:51','',NULL,'å…¬å‘Š'),(16,1,'æ­£å¸¸','0','sys_notice_status','','primary','Y','0','admin','2026-04-18 22:19:51','',NULL,'æ­£å¸¸çŠ¶æ€'),(17,2,'å…³é—­','1','sys_notice_status','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'å…³é—­çŠ¶æ€'),(18,99,'å…¶ä»–','0','sys_oper_type','','info','N','0','admin','2026-04-18 22:19:51','',NULL,'å…¶ä»–æ“ä½œ'),(19,1,'æ–°å¢ž','1','sys_oper_type','','info','N','0','admin','2026-04-18 22:19:51','',NULL,'æ–°å¢žæ“ä½œ'),(20,2,'ä¿®æ”¹','2','sys_oper_type','','info','N','0','admin','2026-04-18 22:19:51','',NULL,'ä¿®æ”¹æ“ä½œ'),(21,3,'åˆ é™¤','3','sys_oper_type','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'åˆ é™¤æ“ä½œ'),(22,4,'æŽˆæƒ','4','sys_oper_type','','primary','N','0','admin','2026-04-18 22:19:51','',NULL,'æŽˆæƒæ“ä½œ'),(23,5,'å¯¼å‡º','5','sys_oper_type','','warning','N','0','admin','2026-04-18 22:19:51','',NULL,'å¯¼å‡ºæ“ä½œ'),(24,6,'å¯¼å…¥','6','sys_oper_type','','warning','N','0','admin','2026-04-18 22:19:51','',NULL,'å¯¼å…¥æ“ä½œ'),(25,7,'å¼ºé€€','7','sys_oper_type','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'å¼ºé€€æ“ä½œ'),(26,8,'ç”Ÿæˆä»£ç ','8','sys_oper_type','','warning','N','0','admin','2026-04-18 22:19:51','',NULL,'ç”Ÿæˆæ“ä½œ'),(27,9,'æ¸…ç©ºæ•°æ®','9','sys_oper_type','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'æ¸…ç©ºæ“ä½œ'),(28,1,'æˆåŠŸ','0','sys_common_status','','primary','N','0','admin','2026-04-18 22:19:51','',NULL,'æ­£å¸¸çŠ¶æ€'),(29,2,'å¤±è´¥','1','sys_common_status','','danger','N','0','admin','2026-04-18 22:19:51','',NULL,'åœç”¨çŠ¶æ€');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'å­—å…¸ä¸»é”®',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸åç§°',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å­—å…¸ç±»åž‹',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å­—å…¸ç±»åž‹è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'ç”¨æˆ·æ€§åˆ«','sys_user_sex','0','admin','2026-04-18 22:19:50','',NULL,'ç”¨æˆ·æ€§åˆ«åˆ—è¡¨'),(2,'èœå•çŠ¶æ€','sys_show_hide','0','admin','2026-04-18 22:19:50','',NULL,'èœå•çŠ¶æ€åˆ—è¡¨'),(3,'ç³»ç»Ÿå¼€å…³','sys_normal_disable','0','admin','2026-04-18 22:19:50','',NULL,'ç³»ç»Ÿå¼€å…³åˆ—è¡¨'),(4,'ä»»åŠ¡çŠ¶æ€','sys_job_status','0','admin','2026-04-18 22:19:50','',NULL,'ä»»åŠ¡çŠ¶æ€åˆ—è¡¨'),(5,'ä»»åŠ¡åˆ†ç»„','sys_job_group','0','admin','2026-04-18 22:19:50','',NULL,'ä»»åŠ¡åˆ†ç»„åˆ—è¡¨'),(6,'ç³»ç»Ÿæ˜¯å¦','sys_yes_no','0','admin','2026-04-18 22:19:50','',NULL,'ç³»ç»Ÿæ˜¯å¦åˆ—è¡¨'),(7,'é€šçŸ¥ç±»åž‹','sys_notice_type','0','admin','2026-04-18 22:19:50','',NULL,'é€šçŸ¥ç±»åž‹åˆ—è¡¨'),(8,'é€šçŸ¥çŠ¶æ€','sys_notice_status','0','admin','2026-04-18 22:19:50','',NULL,'é€šçŸ¥çŠ¶æ€åˆ—è¡¨'),(9,'æ“ä½œç±»åž‹','sys_oper_type','0','admin','2026-04-18 22:19:50','',NULL,'æ“ä½œç±»åž‹åˆ—è¡¨'),(10,'ç³»ç»ŸçŠ¶æ€','sys_common_status','0','admin','2026-04-18 22:19:50','',NULL,'ç™»å½•çŠ¶æ€åˆ—è¡¨');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ä»»åŠ¡ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ä»»åŠ¡åç§°',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT 'ä»»åŠ¡ç»„å',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒç”¨ç›®æ ‡å­—ç¬¦ä¸²',
  `cron_expression` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cronæ‰§è¡Œè¡¨è¾¾å¼',
  `misfire_policy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT 'è®¡åˆ’æ‰§è¡Œé”™è¯¯ç­–ç•¥ï¼ˆ1ç«‹å³æ‰§è¡Œ 2æ‰§è¡Œä¸€æ¬¡ 3æ”¾å¼ƒæ‰§è¡Œï¼‰',
  `concurrent` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT 'æ˜¯å¦å¹¶å‘æ‰§è¡Œï¼ˆ0å…è®¸ 1ç¦æ­¢ï¼‰',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1æš‚åœï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å¤‡æ³¨ä¿¡æ¯',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å®šæ—¶ä»»åŠ¡è°ƒåº¦è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'ç³»ç»Ÿé»˜è®¤ï¼ˆæ— å‚ï¼‰','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-04-18 22:19:51','',NULL,''),(2,'ç³»ç»Ÿé»˜è®¤ï¼ˆæœ‰å‚ï¼‰','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-04-18 22:19:51','',NULL,''),(3,'ç³»ç»Ÿé»˜è®¤ï¼ˆå¤šå‚ï¼‰','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-04-18 22:19:51','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ä»»åŠ¡æ—¥å¿—ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ä»»åŠ¡åç§°',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ä»»åŠ¡ç»„å',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è°ƒç”¨ç›®æ ‡å­—ç¬¦ä¸²',
  `job_message` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æ—¥å¿—ä¿¡æ¯',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'æ‰§è¡ŒçŠ¶æ€ï¼ˆ0æ­£å¸¸ 1å¤±è´¥ï¼‰',
  `exception_info` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å¼‚å¸¸ä¿¡æ¯',
  `start_time` datetime DEFAULT NULL COMMENT 'æ‰§è¡Œå¼€å§‹æ—¶é—´',
  `end_time` datetime DEFAULT NULL COMMENT 'æ‰§è¡Œç»“æŸæ—¶é—´',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å®šæ—¶ä»»åŠ¡è°ƒåº¦æ—¥å¿—è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'è®¿é—®ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ç”¨æˆ·è´¦å·',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ç™»å½•IPåœ°å€',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ç™»å½•åœ°ç‚¹',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æµè§ˆå™¨ç±»åž‹',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ“ä½œç³»ç»Ÿ',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'ç™»å½•çŠ¶æ€ï¼ˆ0æˆåŠŸ 1å¤±è´¥ï¼‰',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æç¤ºæ¶ˆæ¯',
  `login_time` datetime DEFAULT NULL COMMENT 'è®¿é—®æ—¶é—´',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ç³»ç»Ÿè®¿é—®è®°å½•';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Edge 147','Windows >=10','0','登录成功','2026-04-18 22:34:09'),(101,'admin','127.0.0.1','内网IP','Curl 8.5.0','','0','登录成功','2026-04-18 22:44:34'),(102,'admin','127.0.0.1','内网IP','Edge 147','Windows >=10','0','退出成功','2026-04-18 22:44:50'),(103,'admin','127.0.0.1','内网IP','Edge 147','Windows >=10','0','登录成功','2026-04-18 22:45:01');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'èœå•ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'èœå•åç§°',
  `parent_id` bigint DEFAULT '0' COMMENT 'çˆ¶èœå•ID',
  `order_num` int DEFAULT '0' COMMENT 'æ˜¾ç¤ºé¡ºåº',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è·¯ç”±åœ°å€',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ç»„ä»¶è·¯å¾„',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'è·¯ç”±å‚æ•°',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è·¯ç”±åç§°',
  `is_frame` int DEFAULT '1' COMMENT 'æ˜¯å¦ä¸ºå¤–é“¾ï¼ˆ0æ˜¯ 1å¦ï¼‰',
  `is_cache` int DEFAULT '0' COMMENT 'æ˜¯å¦ç¼“å­˜ï¼ˆ0ç¼“å­˜ 1ä¸ç¼“å­˜ï¼‰',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'èœå•ç±»åž‹ï¼ˆMç›®å½• Cèœå• FæŒ‰é’®ï¼‰',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'èœå•çŠ¶æ€ï¼ˆ0æ˜¾ç¤º 1éšè—ï¼‰',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'èœå•çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'æƒé™æ ‡è¯†',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT 'èœå•å›¾æ ‡',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='èœå•æƒé™è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'ç³»ç»Ÿç®¡ç†',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-04-18 22:19:49','',NULL,'ç³»ç»Ÿç®¡ç†ç›®å½•'),(2,'ç³»ç»Ÿç›‘æŽ§',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2026-04-18 22:19:49','',NULL,'ç³»ç»Ÿç›‘æŽ§ç›®å½•'),(3,'ç³»ç»Ÿå·¥å…·',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2026-04-18 22:19:49','',NULL,'ç³»ç»Ÿå·¥å…·ç›®å½•'),(4,'è‹¥ä¾å®˜ç½‘',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2026-04-18 22:19:49','',NULL,'è‹¥ä¾å®˜ç½‘åœ°å€'),(100,'ç”¨æˆ·ç®¡ç†',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-04-18 22:19:49','',NULL,'ç”¨æˆ·ç®¡ç†èœå•'),(101,'è§’è‰²ç®¡ç†',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-04-18 22:19:49','',NULL,'è§’è‰²ç®¡ç†èœå•'),(102,'èœå•ç®¡ç†',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-04-18 22:19:49','',NULL,'èœå•ç®¡ç†èœå•'),(103,'éƒ¨é—¨ç®¡ç†',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2026-04-18 22:19:49','',NULL,'éƒ¨é—¨ç®¡ç†èœå•'),(104,'å²—ä½ç®¡ç†',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2026-04-18 22:19:49','',NULL,'å²—ä½ç®¡ç†èœå•'),(105,'å­—å…¸ç®¡ç†',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2026-04-18 22:19:49','',NULL,'å­—å…¸ç®¡ç†èœå•'),(106,'å‚æ•°è®¾ç½®',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2026-04-18 22:19:49','',NULL,'å‚æ•°è®¾ç½®èœå•'),(107,'é€šçŸ¥å…¬å‘Š',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2026-04-18 22:19:49','',NULL,'é€šçŸ¥å…¬å‘Šèœå•'),(108,'æ—¥å¿—ç®¡ç†',1,9,'log','','','',1,0,'M','0','0','','log','admin','2026-04-18 22:19:49','',NULL,'æ—¥å¿—ç®¡ç†èœå•'),(109,'åœ¨çº¿ç”¨æˆ·',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2026-04-18 22:19:49','',NULL,'åœ¨çº¿ç”¨æˆ·èœå•'),(110,'å®šæ—¶ä»»åŠ¡',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2026-04-18 22:19:49','',NULL,'å®šæ—¶ä»»åŠ¡èœå•'),(111,'æ•°æ®ç›‘æŽ§',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2026-04-18 22:19:49','',NULL,'æ•°æ®ç›‘æŽ§èœå•'),(112,'æœåŠ¡ç›‘æŽ§',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2026-04-18 22:19:49','',NULL,'æœåŠ¡ç›‘æŽ§èœå•'),(113,'ç¼“å­˜ç›‘æŽ§',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2026-04-18 22:19:49','',NULL,'ç¼“å­˜ç›‘æŽ§èœå•'),(114,'ç¼“å­˜åˆ—è¡¨',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2026-04-18 22:19:49','',NULL,'ç¼“å­˜åˆ—è¡¨èœå•'),(115,'è¡¨å•æž„å»º',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2026-04-18 22:19:49','',NULL,'è¡¨å•æž„å»ºèœå•'),(116,'ä»£ç ç”Ÿæˆ',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2026-04-18 22:19:49','',NULL,'ä»£ç ç”Ÿæˆèœå•'),(117,'ç³»ç»ŸæŽ¥å£',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2026-04-18 22:19:49','',NULL,'ç³»ç»ŸæŽ¥å£èœå•'),(500,'æ“ä½œæ—¥å¿—',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2026-04-18 22:19:49','',NULL,'æ“ä½œæ—¥å¿—èœå•'),(501,'ç™»å½•æ—¥å¿—',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2026-04-18 22:19:49','',NULL,'ç™»å½•æ—¥å¿—èœå•'),(1000,'ç”¨æˆ·æŸ¥è¯¢',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-04-18 22:19:49','',NULL,''),(1001,'ç”¨æˆ·æ–°å¢ž',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-04-18 22:19:49','',NULL,''),(1002,'ç”¨æˆ·ä¿®æ”¹',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-04-18 22:19:49','',NULL,''),(1003,'ç”¨æˆ·åˆ é™¤',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-04-18 22:19:49','',NULL,''),(1004,'ç”¨æˆ·å¯¼å‡º',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-04-18 22:19:49','',NULL,''),(1005,'ç”¨æˆ·å¯¼å…¥',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-04-18 22:19:49','',NULL,''),(1006,'é‡ç½®å¯†ç ',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-04-18 22:19:49','',NULL,''),(1007,'è§’è‰²æŸ¥è¯¢',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-04-18 22:19:49','',NULL,''),(1008,'è§’è‰²æ–°å¢ž',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-04-18 22:19:49','',NULL,''),(1009,'è§’è‰²ä¿®æ”¹',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-04-18 22:19:49','',NULL,''),(1010,'è§’è‰²åˆ é™¤',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-04-18 22:19:49','',NULL,''),(1011,'è§’è‰²å¯¼å‡º',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-04-18 22:19:49','',NULL,''),(1012,'èœå•æŸ¥è¯¢',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-04-18 22:19:49','',NULL,''),(1013,'èœå•æ–°å¢ž',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-04-18 22:19:49','',NULL,''),(1014,'èœå•ä¿®æ”¹',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-04-18 22:19:49','',NULL,''),(1015,'èœå•åˆ é™¤',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-04-18 22:19:49','',NULL,''),(1016,'éƒ¨é—¨æŸ¥è¯¢',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2026-04-18 22:19:49','',NULL,''),(1017,'éƒ¨é—¨æ–°å¢ž',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2026-04-18 22:19:49','',NULL,''),(1018,'éƒ¨é—¨ä¿®æ”¹',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1019,'éƒ¨é—¨åˆ é™¤',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1020,'å²—ä½æŸ¥è¯¢',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1021,'å²—ä½æ–°å¢ž',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2026-04-18 22:19:50','',NULL,''),(1022,'å²—ä½ä¿®æ”¹',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1023,'å²—ä½åˆ é™¤',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1024,'å²—ä½å¯¼å‡º',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1025,'å­—å…¸æŸ¥è¯¢',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1026,'å­—å…¸æ–°å¢ž',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2026-04-18 22:19:50','',NULL,''),(1027,'å­—å…¸ä¿®æ”¹',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1028,'å­—å…¸åˆ é™¤',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1029,'å­—å…¸å¯¼å‡º',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1030,'å‚æ•°æŸ¥è¯¢',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1031,'å‚æ•°æ–°å¢ž',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2026-04-18 22:19:50','',NULL,''),(1032,'å‚æ•°ä¿®æ”¹',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1033,'å‚æ•°åˆ é™¤',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1034,'å‚æ•°å¯¼å‡º',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1035,'å…¬å‘ŠæŸ¥è¯¢',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1036,'å…¬å‘Šæ–°å¢ž',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2026-04-18 22:19:50','',NULL,''),(1037,'å…¬å‘Šä¿®æ”¹',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1038,'å…¬å‘Šåˆ é™¤',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1039,'æ“ä½œæŸ¥è¯¢',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1040,'æ“ä½œåˆ é™¤',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1041,'æ—¥å¿—å¯¼å‡º',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1042,'ç™»å½•æŸ¥è¯¢',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1043,'ç™»å½•åˆ é™¤',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1044,'æ—¥å¿—å¯¼å‡º',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1045,'è´¦æˆ·è§£é”',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2026-04-18 22:19:50','',NULL,''),(1046,'åœ¨çº¿æŸ¥è¯¢',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1047,'æ‰¹é‡å¼ºé€€',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2026-04-18 22:19:50','',NULL,''),(1048,'å•æ¡å¼ºé€€',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2026-04-18 22:19:50','',NULL,''),(1049,'ä»»åŠ¡æŸ¥è¯¢',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1050,'ä»»åŠ¡æ–°å¢ž',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2026-04-18 22:19:50','',NULL,''),(1051,'ä»»åŠ¡ä¿®æ”¹',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1052,'ä»»åŠ¡åˆ é™¤',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1053,'çŠ¶æ€ä¿®æ”¹',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2026-04-18 22:19:50','',NULL,''),(1054,'ä»»åŠ¡å¯¼å‡º',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2026-04-18 22:19:50','',NULL,''),(1055,'ç”ŸæˆæŸ¥è¯¢',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2026-04-18 22:19:50','',NULL,''),(1056,'ç”Ÿæˆä¿®æ”¹',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2026-04-18 22:19:50','',NULL,''),(1057,'ç”Ÿæˆåˆ é™¤',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2026-04-18 22:19:50','',NULL,''),(1058,'å¯¼å…¥ä»£ç ',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2026-04-18 22:19:50','',NULL,''),(1059,'é¢„è§ˆä»£ç ',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2026-04-18 22:19:50','',NULL,''),(1060,'ç”Ÿæˆä»£ç ',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2026-04-18 22:19:50','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT 'å…¬å‘ŠID',
  `notice_title` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'å…¬å‘Šæ ‡é¢˜',
  `notice_type` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'å…¬å‘Šç±»åž‹ï¼ˆ1é€šçŸ¥ 2å…¬å‘Šï¼‰',
  `notice_content` longblob COMMENT 'å…¬å‘Šå†…å®¹',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'å…¬å‘ŠçŠ¶æ€ï¼ˆ0æ­£å¸¸ 1å…³é—­ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='é€šçŸ¥å…¬å‘Šè¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'æ¸©é¦¨æé†’ï¼š2018-07-01 è‹¥ä¾æ–°ç‰ˆæœ¬å‘å¸ƒå•¦','2',_binary '新版本内容','0','admin','2026-04-18 22:19:51','',NULL,'ç®¡ç†å‘˜'),(2,'ç»´æŠ¤é€šçŸ¥ï¼š2018-07-01 è‹¥ä¾ç³»ç»Ÿå‡Œæ™¨ç»´æŠ¤','1',_binary '维护内容','0','admin','2026-04-18 22:19:51','',NULL,'ç®¡ç†å‘˜'),(3,'è‹¥ä¾å¼€æºæ¡†æž¶ä»‹ç»','1',_binary '<p><span style=\"color: rgb(230, 0, 0);\">项目介绍</span></p><p><font color=\"#333333\">RuoYi开源项目是为企业用户定制的后台脚手架框架，为企业打造的一站式解决方案，降低企业开发成本，提升开发效率。主要包括用户管理、角色管理、部门管理、菜单管理、参数管理、字典管理、</font><span style=\"color: rgb(51, 51, 51);\">岗位管理</span><span style=\"color: rgb(51, 51, 51);\">、定时任务</span><span style=\"color: rgb(51, 51, 51);\">、</span><span style=\"color: rgb(51, 51, 51);\">服务监控、登录日志、操作日志、代码生成等功能。其中，还支持多数据源、数据权限、国际化、Redis缓存、Docker部署、滑动验证码、第三方认证登录、分布式事务、</span><font color=\"#333333\">分布式文件存储</font><span style=\"color: rgb(51, 51, 51);\">、分库分表处理等技术特点。</span></p><p><img src=\"https://foruda.gitee.com/images/1773931848342439032/a4d22313_1815095.png\" style=\"width: 64px;\"><br></p><p><span style=\"color: rgb(230, 0, 0);\">官网及演示</span></p><p><span style=\"color: rgb(51, 51, 51);\">若依官网地址：&nbsp;</span><a href=\"http://ruoyi.vip\" target=\"_blank\">http://ruoyi.vip</a><a href=\"http://ruoyi.vip\" target=\"_blank\"></a></p><p><span style=\"color: rgb(51, 51, 51);\">若依文档地址：&nbsp;</span><a href=\"http://doc.ruoyi.vip\" target=\"_blank\">http://doc.ruoyi.vip</a><br></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【不分离版】：&nbsp;</span><a href=\"http://demo.ruoyi.vip\" target=\"_blank\">http://demo.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【分离版本】：&nbsp;</span><a href=\"http://vue.ruoyi.vip\" target=\"_blank\">http://vue.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【微服务版】：&nbsp;</span><a href=\"http://cloud.ruoyi.vip\" target=\"_blank\">http://cloud.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【移动端版】：&nbsp;</span><a href=\"http://h5.ruoyi.vip\" target=\"_blank\">http://h5.ruoyi.vip</a></p><p><br style=\"color: rgb(48, 49, 51); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px;\"></p>','0','admin','2026-04-18 22:19:51','',NULL,'ç®¡ç†å‘˜');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice_read`
--

DROP TABLE IF EXISTS `sys_notice_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice_read` (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'å·²è¯»ä¸»é”®',
  `notice_id` int NOT NULL COMMENT 'å…¬å‘Šid',
  `user_id` bigint NOT NULL COMMENT 'ç”¨æˆ·id',
  `read_time` datetime NOT NULL COMMENT 'é˜…è¯»æ—¶é—´',
  PRIMARY KEY (`read_id`),
  UNIQUE KEY `uk_user_notice` (`user_id`,`notice_id`) COMMENT 'åŒä¸€ç”¨æˆ·åŒä¸€å…¬å‘Šåªè®°å½•ä¸€æ¬¡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å…¬å‘Šå·²è¯»è®°å½•è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice_read`
--

LOCK TABLES `sys_notice_read` WRITE;
/*!40000 ALTER TABLE `sys_notice_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'æ—¥å¿—ä¸»é”®',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ¨¡å—æ ‡é¢˜',
  `business_type` int DEFAULT '0' COMMENT 'ä¸šåŠ¡ç±»åž‹ï¼ˆ0å…¶å®ƒ 1æ–°å¢ž 2ä¿®æ”¹ 3åˆ é™¤ï¼‰',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ–¹æ³•åç§°',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¯·æ±‚æ–¹å¼',
  `operator_type` int DEFAULT '0' COMMENT 'æ“ä½œç±»åˆ«ï¼ˆ0å…¶å®ƒ 1åŽå°ç”¨æˆ· 2æ‰‹æœºç«¯ç”¨æˆ·ï¼‰',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ“ä½œäººå‘˜',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'éƒ¨é—¨åç§°',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¯·æ±‚URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ä¸»æœºåœ°å€',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ“ä½œåœ°ç‚¹',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¯·æ±‚å‚æ•°',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'è¿”å›žå‚æ•°',
  `status` int DEFAULT '0' COMMENT 'æ“ä½œçŠ¶æ€ï¼ˆ0æ­£å¸¸ 1å¼‚å¸¸ï¼‰',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'é”™è¯¯æ¶ˆæ¯',
  `oper_time` datetime DEFAULT NULL COMMENT 'æ“ä½œæ—¶é—´',
  `cost_time` bigint DEFAULT '0' COMMENT 'æ¶ˆè€—æ—¶é—´',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='æ“ä½œæ—¥å¿—è®°å½•';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'å²—ä½ID',
  `post_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'å²—ä½ç¼–ç ',
  `post_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'å²—ä½åç§°',
  `post_sort` int NOT NULL COMMENT 'æ˜¾ç¤ºé¡ºåº',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='å²—ä½ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','è‘£äº‹é•¿',1,'0','admin','2026-04-18 22:19:49','',NULL,''),(2,'se','é¡¹ç›®ç»ç†',2,'0','admin','2026-04-18 22:19:49','',NULL,''),(3,'hr','äººåŠ›èµ„æº',3,'0','admin','2026-04-18 22:19:49','',NULL,''),(4,'user','æ™®é€šå‘˜å·¥',4,'0','admin','2026-04-18 22:19:49','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'è§’è‰²ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§’è‰²åç§°',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§’è‰²æƒé™å­—ç¬¦ä¸²',
  `role_sort` int NOT NULL COMMENT 'æ˜¾ç¤ºé¡ºåº',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT 'æ•°æ®èŒƒå›´ï¼ˆ1ï¼šå…¨éƒ¨æ•°æ®æƒé™ 2ï¼šè‡ªå®šæ•°æ®æƒé™ 3ï¼šæœ¬éƒ¨é—¨æ•°æ®æƒé™ 4ï¼šæœ¬éƒ¨é—¨åŠä»¥ä¸‹æ•°æ®æƒé™ï¼‰',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT 'èœå•æ ‘é€‰æ‹©é¡¹æ˜¯å¦å…³è”æ˜¾ç¤º',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT 'éƒ¨é—¨æ ‘é€‰æ‹©é¡¹æ˜¯å¦å…³è”æ˜¾ç¤º',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'è§’è‰²çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'åˆ é™¤æ ‡å¿—ï¼ˆ0ä»£è¡¨å­˜åœ¨ 2ä»£è¡¨åˆ é™¤ï¼‰',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='è§’è‰²ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'è¶…çº§ç®¡ç†å‘˜','admin',1,'1',1,1,'0','0','admin','2026-04-18 22:19:49','',NULL,'è¶…çº§ç®¡ç†å‘˜'),(2,'æ™®é€šè§’è‰²','common',2,'2',1,1,'0','0','admin','2026-04-18 22:19:49','',NULL,'æ™®é€šè§’è‰²');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT 'è§’è‰²ID',
  `dept_id` bigint NOT NULL COMMENT 'éƒ¨é—¨ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='è§’è‰²å’Œéƒ¨é—¨å…³è”è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT 'è§’è‰²ID',
  `menu_id` bigint NOT NULL COMMENT 'èœå•ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='è§’è‰²å’Œèœå•å…³è”è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,4);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ç”¨æˆ·ID',
  `dept_id` bigint DEFAULT NULL COMMENT 'éƒ¨é—¨ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ç”¨æˆ·è´¦å·',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ç”¨æˆ·æ˜µç§°',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT 'ç”¨æˆ·ç±»åž‹ï¼ˆ00ç³»ç»Ÿç”¨æˆ·ï¼‰',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'ç”¨æˆ·é‚®ç®±',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ‰‹æœºå·ç ',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'ç”¨æˆ·æ€§åˆ«ï¼ˆ0ç”· 1å¥³ 2æœªçŸ¥ï¼‰',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å¤´åƒåœ°å€',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'å¯†ç ',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'è´¦å·çŠ¶æ€ï¼ˆ0æ­£å¸¸ 1åœç”¨ï¼‰',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT 'åˆ é™¤æ ‡å¿—ï¼ˆ0ä»£è¡¨å­˜åœ¨ 2ä»£è¡¨åˆ é™¤ï¼‰',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æœ€åŽç™»å½•IP',
  `login_date` datetime DEFAULT NULL COMMENT 'æœ€åŽç™»å½•æ—¶é—´',
  `pwd_update_date` datetime DEFAULT NULL COMMENT 'å¯†ç æœ€åŽæ›´æ–°æ—¶é—´',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'åˆ›å»ºè€…',
  `create_time` datetime DEFAULT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'æ›´æ–°è€…',
  `update_time` datetime DEFAULT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'å¤‡æ³¨',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ç”¨æˆ·ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','è‹¥ä¾','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-04-18 22:45:01','2026-04-18 22:19:49','admin','2026-04-18 22:19:49','',NULL,'ç®¡ç†å‘˜'),(2,105,'ry','è‹¥ä¾','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-04-18 22:19:49','2026-04-18 22:19:49','admin','2026-04-18 22:19:49','',NULL,'æµ‹è¯•å‘˜');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT 'ç”¨æˆ·ID',
  `post_id` bigint NOT NULL COMMENT 'å²—ä½ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ç”¨æˆ·ä¸Žå²—ä½å…³è”è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT 'ç”¨æˆ·ID',
  `role_id` bigint NOT NULL COMMENT 'è§’è‰²ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ç”¨æˆ·å’Œè§’è‰²å…³è”è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-18 22:48:34
