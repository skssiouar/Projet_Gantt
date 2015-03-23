-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Sam 21 Mars 2015 à 12:49
-- Version du serveur: 5.5.41-0ubuntu0.14.04.1
-- Version de PHP: 5.5.9-1ubuntu4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `slurm_acct_db`
--
CREATE DATABASE IF NOT EXISTS `slurm_acct_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `slurm_acct_db`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `get_parent_limits`$$
CREATE DEFINER="slurm"@"localhost" PROCEDURE "get_parent_limits"(my_table text, acct text, cluster text, without_limits int)
begin set @par_id = NULL; set @mj = NULL; set @msj = NULL; set @mcpj = NULL; set @mnpj = NULL; set @mwpj = NULL; set @mcmpj = NULL; set @mcrm = NULL; set @def_qos_id = NULL; set @qos = ''; set @delta_qos = ''; set @my_acct = acct; if without_limits then set @mj = 0; set @msj = 0; set @mcpj = 0; set @mnpj = 0; set @mwpj = 0; set @mcmpj = 0; set @mcrm = 0; set @def_qos_id = 0; set @qos = 0; set @delta_qos = 0; end if; REPEAT set @s = 'select '; if @par_id is NULL then set @s = CONCAT(@s, '@par_id := id_assoc, '); end if; if @mj is NULL then set @s = CONCAT(@s, '@mj := max_jobs, '); end if; if @msj is NULL then set @s = CONCAT(@s, '@msj := max_submit_jobs, '); end if; if @mcpj is NULL then set @s = CONCAT(@s, '@mcpj := max_cpus_pj, ') ;end if; if @mnpj is NULL then set @s = CONCAT(@s, '@mnpj := max_nodes_pj, ') ;end if; if @mwpj is NULL then set @s = CONCAT(@s, '@mwpj := max_wall_pj, '); end if; if @mcmpj is NULL then set @s = CONCAT(@s, '@mcmpj := max_cpu_mins_pj, '); end if; if @mcrm is NULL then set @s = CONCAT(@s, '@mcrm := max_cpu_run_mins, '); end if; if @def_qos_id is NULL then set @s = CONCAT(@s, '@def_qos_id := def_qos_id, '); end if; if @qos = '' then set @s = CONCAT(@s, '@qos := qos, @delta_qos := CONCAT(delta_qos, @delta_qos), '); end if; set @s = concat(@s, '@my_acct := parent_acct from "', cluster, '_', my_table, '" where acct = \'', @my_acct, '\' && user=\'\''); prepare query from @s; execute query; deallocate prepare query; UNTIL (@mj != -1 && @msj != -1 && @mcpj != -1 && @mnpj != -1 && @mwpj != -1 && @mcmpj != -1 && @mcrm != -1 && @def_qos_id != -1 && @qos != '') || @my_acct = '' END REPEAT; END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `acct_coord_table`
--

DROP TABLE IF EXISTS `acct_coord_table`;
CREATE TABLE IF NOT EXISTS `acct_coord_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) DEFAULT '0',
  `acct` tinytext NOT NULL,
  `user` tinytext NOT NULL,
  PRIMARY KEY (`acct`(20),`user`(20))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `acct_table`
--

DROP TABLE IF EXISTS `acct_table`;
CREATE TABLE IF NOT EXISTS `acct_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) DEFAULT '0',
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  `organization` text NOT NULL,
  PRIMARY KEY (`name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `acct_table`
--

INSERT INTO `acct_table` (`creation_time`, `mod_time`, `deleted`, `name`, `description`, `organization`) VALUES
(1426643057, 1426643057, 0, 'root', 'default root account', 'root');

-- --------------------------------------------------------

--
-- Structure de la table `cluster_table`
--

DROP TABLE IF EXISTS `cluster_table`;
CREATE TABLE IF NOT EXISTS `cluster_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) DEFAULT '0',
  `name` tinytext NOT NULL,
  `control_host` tinytext NOT NULL,
  `control_port` int(10) unsigned NOT NULL DEFAULT '0',
  `last_port` int(10) unsigned NOT NULL DEFAULT '0',
  `rpc_version` smallint(5) unsigned NOT NULL DEFAULT '0',
  `classification` smallint(5) unsigned DEFAULT '0',
  `dimensions` smallint(5) unsigned DEFAULT '1',
  `plugin_id_select` smallint(5) unsigned DEFAULT '0',
  `flags` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `cluster_table`
--

INSERT INTO `cluster_table` (`creation_time`, `mod_time`, `deleted`, `name`, `control_host`, `control_port`, `last_port`, `rpc_version`, `classification`, `dimensions`, `plugin_id_select`, `flags`) VALUES
(1426715342, 1426715342, 0, 'magi', '', 0, 0, 0, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `magi_assoc_table`
--

DROP TABLE IF EXISTS `magi_assoc_table`;
CREATE TABLE IF NOT EXISTS `magi_assoc_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `is_def` tinyint(4) NOT NULL DEFAULT '0',
  `id_assoc` int(11) NOT NULL AUTO_INCREMENT,
  `user` tinytext NOT NULL,
  `acct` tinytext NOT NULL,
  `partition` tinytext NOT NULL,
  `parent_acct` tinytext NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `shares` int(11) NOT NULL DEFAULT '1',
  `max_jobs` int(11) DEFAULT NULL,
  `max_submit_jobs` int(11) DEFAULT NULL,
  `max_cpus_pj` int(11) DEFAULT NULL,
  `max_nodes_pj` int(11) DEFAULT NULL,
  `max_wall_pj` int(11) DEFAULT NULL,
  `max_cpu_mins_pj` bigint(20) DEFAULT NULL,
  `max_cpu_run_mins` bigint(20) DEFAULT NULL,
  `grp_jobs` int(11) DEFAULT NULL,
  `grp_submit_jobs` int(11) DEFAULT NULL,
  `grp_cpus` int(11) DEFAULT NULL,
  `grp_mem` int(11) DEFAULT NULL,
  `grp_nodes` int(11) DEFAULT NULL,
  `grp_wall` int(11) DEFAULT NULL,
  `grp_cpu_mins` bigint(20) DEFAULT NULL,
  `grp_cpu_run_mins` bigint(20) DEFAULT NULL,
  `def_qos_id` int(11) DEFAULT NULL,
  `qos` blob NOT NULL,
  `delta_qos` blob NOT NULL,
  PRIMARY KEY (`id_assoc`),
  UNIQUE KEY `user` (`user`(20),`acct`(20),`partition`(20))
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `magi_assoc_table`
--

INSERT INTO `magi_assoc_table` (`creation_time`, `mod_time`, `deleted`, `is_def`, `id_assoc`, `user`, `acct`, `partition`, `parent_acct`, `lft`, `rgt`, `shares`, `max_jobs`, `max_submit_jobs`, `max_cpus_pj`, `max_nodes_pj`, `max_wall_pj`, `max_cpu_mins_pj`, `max_cpu_run_mins`, `grp_jobs`, `grp_submit_jobs`, `grp_cpus`, `grp_mem`, `grp_nodes`, `grp_wall`, `grp_cpu_mins`, `grp_cpu_run_mins`, `def_qos_id`, `qos`, `delta_qos`) VALUES
(1426715342, 1426715342, 0, 0, 1, '', 'root', '', '', 1, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0x2c31, ''),
(1426715342, 1426715342, 0, 1, 2, 'root', 'root', '', '', 2, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `magi_assoc_usage_day_table`
--

DROP TABLE IF EXISTS `magi_assoc_usage_day_table`;
CREATE TABLE IF NOT EXISTS `magi_assoc_usage_day_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_assoc` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_assoc`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_assoc_usage_hour_table`
--

DROP TABLE IF EXISTS `magi_assoc_usage_hour_table`;
CREATE TABLE IF NOT EXISTS `magi_assoc_usage_hour_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_assoc` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_assoc`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_assoc_usage_month_table`
--

DROP TABLE IF EXISTS `magi_assoc_usage_month_table`;
CREATE TABLE IF NOT EXISTS `magi_assoc_usage_month_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_assoc` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_assoc`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_event_table`
--

DROP TABLE IF EXISTS `magi_event_table`;
CREATE TABLE IF NOT EXISTS `magi_event_table` (
  `time_start` int(10) unsigned NOT NULL,
  `time_end` int(10) unsigned NOT NULL DEFAULT '0',
  `node_name` tinytext NOT NULL,
  `cluster_nodes` text NOT NULL,
  `cpu_count` int(11) NOT NULL,
  `reason` tinytext NOT NULL,
  `reason_uid` int(10) unsigned NOT NULL DEFAULT '4294967294',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`node_name`(20),`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_job_table`
--

DROP TABLE IF EXISTS `magi_job_table`;
CREATE TABLE IF NOT EXISTS `magi_job_table` (
  `job_db_inx` int(11) NOT NULL AUTO_INCREMENT,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `account` tinytext,
  `cpus_req` int(10) unsigned NOT NULL,
  `cpus_alloc` int(10) unsigned NOT NULL,
  `derived_ec` int(10) unsigned NOT NULL DEFAULT '0',
  `derived_es` text,
  `exit_code` int(10) unsigned NOT NULL DEFAULT '0',
  `job_name` tinytext NOT NULL,
  `id_assoc` int(10) unsigned NOT NULL,
  `id_block` tinytext,
  `id_job` int(10) unsigned NOT NULL,
  `id_qos` int(10) unsigned NOT NULL DEFAULT '0',
  `id_resv` int(10) unsigned NOT NULL,
  `id_wckey` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `kill_requid` int(11) NOT NULL DEFAULT '-1',
  `mem_req` int(10) unsigned NOT NULL DEFAULT '0',
  `nodelist` text,
  `nodes_alloc` int(10) unsigned NOT NULL,
  `node_inx` text,
  `partition` tinytext NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `state` smallint(5) unsigned NOT NULL,
  `timelimit` int(10) unsigned NOT NULL DEFAULT '0',
  `time_submit` int(10) unsigned NOT NULL DEFAULT '0',
  `time_eligible` int(10) unsigned NOT NULL DEFAULT '0',
  `time_start` int(10) unsigned NOT NULL DEFAULT '0',
  `time_end` int(10) unsigned NOT NULL DEFAULT '0',
  `time_suspended` int(10) unsigned NOT NULL DEFAULT '0',
  `gres_req` text NOT NULL,
  `gres_alloc` text NOT NULL,
  `gres_used` text NOT NULL,
  `wckey` tinytext NOT NULL,
  `track_steps` tinyint(4) NOT NULL,
  PRIMARY KEY (`job_db_inx`),
  UNIQUE KEY `id_job` (`id_job`,`id_assoc`,`time_submit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `magi_last_ran_table`
--

DROP TABLE IF EXISTS `magi_last_ran_table`;
CREATE TABLE IF NOT EXISTS `magi_last_ran_table` (
  `hourly_rollup` int(10) unsigned NOT NULL DEFAULT '0',
  `daily_rollup` int(10) unsigned NOT NULL DEFAULT '0',
  `monthly_rollup` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `magi_last_ran_table`
--

INSERT INTO `magi_last_ran_table` (`hourly_rollup`, `daily_rollup`, `monthly_rollup`) VALUES
(1426716000, 1426716000, 1426716000);

-- --------------------------------------------------------

--
-- Structure de la table `magi_resv_table`
--

DROP TABLE IF EXISTS `magi_resv_table`;
CREATE TABLE IF NOT EXISTS `magi_resv_table` (
  `id_resv` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `assoclist` text NOT NULL,
  `cpus` int(10) unsigned NOT NULL,
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `nodelist` text NOT NULL,
  `node_inx` text NOT NULL,
  `resv_name` text NOT NULL,
  `time_start` int(10) unsigned NOT NULL DEFAULT '0',
  `time_end` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_resv`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_step_table`
--

DROP TABLE IF EXISTS `magi_step_table`;
CREATE TABLE IF NOT EXISTS `magi_step_table` (
  `job_db_inx` int(11) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `cpus_alloc` int(10) unsigned NOT NULL,
  `exit_code` int(11) NOT NULL DEFAULT '0',
  `id_step` int(11) NOT NULL,
  `kill_requid` int(11) NOT NULL DEFAULT '-1',
  `nodelist` text NOT NULL,
  `nodes_alloc` int(10) unsigned NOT NULL,
  `node_inx` text,
  `state` smallint(5) unsigned NOT NULL,
  `step_name` text NOT NULL,
  `task_cnt` int(10) unsigned NOT NULL,
  `task_dist` smallint(6) NOT NULL DEFAULT '0',
  `time_start` int(10) unsigned NOT NULL DEFAULT '0',
  `time_end` int(10) unsigned NOT NULL DEFAULT '0',
  `time_suspended` int(10) unsigned NOT NULL DEFAULT '0',
  `user_sec` int(10) unsigned NOT NULL DEFAULT '0',
  `user_usec` int(10) unsigned NOT NULL DEFAULT '0',
  `sys_sec` int(10) unsigned NOT NULL DEFAULT '0',
  `sys_usec` int(10) unsigned NOT NULL DEFAULT '0',
  `max_pages` int(10) unsigned NOT NULL DEFAULT '0',
  `max_pages_task` int(10) unsigned NOT NULL DEFAULT '0',
  `max_pages_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_pages` double unsigned NOT NULL DEFAULT '0',
  `max_rss` bigint(20) unsigned NOT NULL DEFAULT '0',
  `max_rss_task` int(10) unsigned NOT NULL DEFAULT '0',
  `max_rss_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_rss` double unsigned NOT NULL DEFAULT '0',
  `max_vsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `max_vsize_task` int(10) unsigned NOT NULL DEFAULT '0',
  `max_vsize_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_vsize` double unsigned NOT NULL DEFAULT '0',
  `min_cpu` int(10) unsigned NOT NULL DEFAULT '0',
  `min_cpu_task` int(10) unsigned NOT NULL DEFAULT '0',
  `min_cpu_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_cpu` double unsigned NOT NULL DEFAULT '0',
  `act_cpufreq` double unsigned NOT NULL DEFAULT '0',
  `consumed_energy` double unsigned NOT NULL DEFAULT '0',
  `req_cpufreq` int(10) unsigned NOT NULL DEFAULT '0',
  `max_disk_read` double unsigned NOT NULL DEFAULT '0',
  `max_disk_read_task` int(10) unsigned NOT NULL DEFAULT '0',
  `max_disk_read_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_disk_read` double unsigned NOT NULL DEFAULT '0',
  `max_disk_write` double unsigned NOT NULL DEFAULT '0',
  `max_disk_write_task` int(10) unsigned NOT NULL DEFAULT '0',
  `max_disk_write_node` int(10) unsigned NOT NULL DEFAULT '0',
  `ave_disk_write` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`job_db_inx`,`id_step`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_suspend_table`
--

DROP TABLE IF EXISTS `magi_suspend_table`;
CREATE TABLE IF NOT EXISTS `magi_suspend_table` (
  `job_db_inx` int(11) NOT NULL,
  `id_assoc` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL DEFAULT '0',
  `time_end` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_usage_day_table`
--

DROP TABLE IF EXISTS `magi_usage_day_table`;
CREATE TABLE IF NOT EXISTS `magi_usage_day_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `time_start` int(10) unsigned NOT NULL,
  `cpu_count` int(11) NOT NULL DEFAULT '0',
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `down_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `pdown_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `idle_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `resv_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `over_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_usage_hour_table`
--

DROP TABLE IF EXISTS `magi_usage_hour_table`;
CREATE TABLE IF NOT EXISTS `magi_usage_hour_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `time_start` int(10) unsigned NOT NULL,
  `cpu_count` int(11) NOT NULL DEFAULT '0',
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `down_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `pdown_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `idle_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `resv_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `over_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_usage_month_table`
--

DROP TABLE IF EXISTS `magi_usage_month_table`;
CREATE TABLE IF NOT EXISTS `magi_usage_month_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `time_start` int(10) unsigned NOT NULL,
  `cpu_count` int(11) NOT NULL DEFAULT '0',
  `alloc_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `down_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `pdown_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `idle_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `resv_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  `over_cpu_secs` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_wckey_table`
--

DROP TABLE IF EXISTS `magi_wckey_table`;
CREATE TABLE IF NOT EXISTS `magi_wckey_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `is_def` tinyint(4) NOT NULL DEFAULT '0',
  `id_wckey` int(11) NOT NULL AUTO_INCREMENT,
  `wckey_name` tinytext NOT NULL,
  `user` tinytext NOT NULL,
  PRIMARY KEY (`id_wckey`),
  UNIQUE KEY `wckey_name` (`wckey_name`(20),`user`(20))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `magi_wckey_usage_day_table`
--

DROP TABLE IF EXISTS `magi_wckey_usage_day_table`;
CREATE TABLE IF NOT EXISTS `magi_wckey_usage_day_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_wckey` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) DEFAULT '0',
  `resv_cpu_secs` bigint(20) DEFAULT '0',
  `over_cpu_secs` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id_wckey`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_wckey_usage_hour_table`
--

DROP TABLE IF EXISTS `magi_wckey_usage_hour_table`;
CREATE TABLE IF NOT EXISTS `magi_wckey_usage_hour_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_wckey` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) DEFAULT '0',
  `resv_cpu_secs` bigint(20) DEFAULT '0',
  `over_cpu_secs` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id_wckey`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `magi_wckey_usage_month_table`
--

DROP TABLE IF EXISTS `magi_wckey_usage_month_table`;
CREATE TABLE IF NOT EXISTS `magi_wckey_usage_month_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  `id_wckey` int(11) NOT NULL,
  `time_start` int(10) unsigned NOT NULL,
  `alloc_cpu_secs` bigint(20) DEFAULT '0',
  `resv_cpu_secs` bigint(20) DEFAULT '0',
  `over_cpu_secs` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id_wckey`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `qos_table`
--

DROP TABLE IF EXISTS `qos_table`;
CREATE TABLE IF NOT EXISTS `qos_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text,
  `flags` int(10) unsigned DEFAULT '0',
  `grace_time` int(10) unsigned DEFAULT NULL,
  `max_jobs_per_user` int(11) DEFAULT NULL,
  `max_submit_jobs_per_user` int(11) DEFAULT NULL,
  `max_cpus_per_job` int(11) DEFAULT NULL,
  `max_cpus_per_user` int(11) DEFAULT NULL,
  `max_nodes_per_job` int(11) DEFAULT NULL,
  `max_nodes_per_user` int(11) DEFAULT NULL,
  `max_wall_duration_per_job` int(11) DEFAULT NULL,
  `max_cpu_mins_per_job` bigint(20) DEFAULT NULL,
  `max_cpu_run_mins_per_user` bigint(20) DEFAULT NULL,
  `grp_jobs` int(11) DEFAULT NULL,
  `grp_submit_jobs` int(11) DEFAULT NULL,
  `grp_cpus` int(11) DEFAULT NULL,
  `grp_mem` int(11) DEFAULT NULL,
  `grp_nodes` int(11) DEFAULT NULL,
  `grp_wall` int(11) DEFAULT NULL,
  `grp_cpu_mins` bigint(20) DEFAULT NULL,
  `grp_cpu_run_mins` bigint(20) DEFAULT NULL,
  `preempt` text NOT NULL,
  `preempt_mode` int(11) DEFAULT '0',
  `priority` int(10) unsigned DEFAULT '0',
  `usage_factor` double NOT NULL DEFAULT '1',
  `usage_thres` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`(20))
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `qos_table`
--

INSERT INTO `qos_table` (`creation_time`, `mod_time`, `deleted`, `id`, `name`, `description`, `flags`, `grace_time`, `max_jobs_per_user`, `max_submit_jobs_per_user`, `max_cpus_per_job`, `max_cpus_per_user`, `max_nodes_per_job`, `max_nodes_per_user`, `max_wall_duration_per_job`, `max_cpu_mins_per_job`, `max_cpu_run_mins_per_user`, `grp_jobs`, `grp_submit_jobs`, `grp_cpus`, `grp_mem`, `grp_nodes`, `grp_wall`, `grp_cpu_mins`, `grp_cpu_run_mins`, `preempt`, `preempt_mode`, `priority`, `usage_factor`, `usage_thres`) VALUES
(1426643057, 1426643057, 0, 1, 'normal', 'Normal QOS default', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `table_defs_table`
--

DROP TABLE IF EXISTS `table_defs_table`;
CREATE TABLE IF NOT EXISTS `table_defs_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `table_name` text NOT NULL,
  `definition` text NOT NULL,
  PRIMARY KEY (`table_name`(50))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `table_defs_table`
--

INSERT INTO `table_defs_table` (`creation_time`, `mod_time`, `table_name`, `definition`) VALUES
(1426715342, 1426715342, '"magi_assoc_table"', 'alter table "magi_assoc_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify is_def tinyint default 0 not null, modify id_assoc int not null auto_increment, modify user tinytext not null default '''', modify acct tinytext not null, modify partition tinytext not null default '''', modify parent_acct tinytext not null default '''', modify lft int not null, modify rgt int not null, modify shares int default 1 not null, modify max_jobs int default NULL, modify max_submit_jobs int default NULL, modify max_cpus_pj int default NULL, modify max_nodes_pj int default NULL, modify max_wall_pj int default NULL, modify max_cpu_mins_pj bigint default NULL, modify max_cpu_run_mins bigint default NULL, modify grp_jobs int default NULL, modify grp_submit_jobs int default NULL, modify grp_cpus int default NULL, modify grp_mem int default NULL, modify grp_nodes int default NULL, modify grp_wall int default NULL, modify grp_cpu_mins bigint default NULL, modify grp_cpu_run_mins bigint default NULL, modify def_qos_id int default NULL, modify qos blob not null default '''', modify delta_qos blob not null default '''', drop primary key, add primary key (id_assoc), drop index user, add unique index (user(20), acct(20), partition(20));'),
(1426715342, 1426715342, '"magi_assoc_usage_day_table"', 'alter table "magi_assoc_usage_day_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_assoc int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0 not null, drop primary key, add primary key (id_assoc, time_start);'),
(1426715342, 1426715342, '"magi_assoc_usage_hour_table"', 'alter table "magi_assoc_usage_hour_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_assoc int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0 not null, drop primary key, add primary key (id_assoc, time_start);'),
(1426715342, 1426715342, '"magi_assoc_usage_month_table"', 'alter table "magi_assoc_usage_month_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_assoc int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0 not null, drop primary key, add primary key (id_assoc, time_start);'),
(1426715342, 1426715342, '"magi_event_table"', 'alter table "magi_event_table" modify time_start int unsigned not null, modify time_end int unsigned default 0 not null, modify node_name tinytext default '''' not null, modify cluster_nodes text not null default '''', modify cpu_count int not null, modify reason tinytext not null, modify reason_uid int unsigned default 0xfffffffe not null, modify state smallint unsigned default 0 not null, drop primary key, add primary key (node_name(20), time_start);'),
(1426715342, 1426715342, '"magi_job_table"', 'alter table "magi_job_table" modify job_db_inx int not null auto_increment, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify account tinytext, modify cpus_req int unsigned not null, modify cpus_alloc int unsigned not null, modify derived_ec int unsigned default 0 not null, modify derived_es text, modify exit_code int unsigned default 0 not null, modify job_name tinytext not null, modify id_assoc int unsigned not null, modify id_block tinytext, modify id_job int unsigned not null, modify id_qos int unsigned default 0 not null, modify id_resv int unsigned not null, modify id_wckey int unsigned not null, modify id_user int unsigned not null, modify id_group int unsigned not null, modify kill_requid int default -1 not null, modify mem_req int unsigned default 0 not null, modify nodelist text, modify nodes_alloc int unsigned not null, modify node_inx text, modify partition tinytext not null, modify priority int unsigned not null, modify state smallint unsigned not null, modify timelimit int unsigned default 0 not null, modify time_submit int unsigned default 0 not null, modify time_eligible int unsigned default 0 not null, modify time_start int unsigned default 0 not null, modify time_end int unsigned default 0 not null, modify time_suspended int unsigned default 0 not null, modify gres_req text not null default '''', modify gres_alloc text not null default '''', modify gres_used text not null default '''', modify wckey tinytext not null default '''', modify track_steps tinyint not null, drop primary key, add primary key (job_db_inx), drop index id_job, add unique index (id_job, id_assoc, time_submit);'),
(1426715342, 1426715342, '"magi_last_ran_table"', 'alter table "magi_last_ran_table" modify hourly_rollup int unsigned default 0 not null, modify daily_rollup int unsigned default 0 not null, modify monthly_rollup int unsigned default 0 not null;'),
(1426715342, 1426715342, '"magi_resv_table"', 'alter table "magi_resv_table" modify id_resv int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify assoclist text not null default '''', modify cpus int unsigned not null, modify flags smallint unsigned default 0 not null, modify nodelist text not null default '''', modify node_inx text not null default '''', modify resv_name text not null, modify time_start int unsigned default 0 not null, modify time_end int unsigned default 0 not null, drop primary key, add primary key (id_resv, time_start);'),
(1426715342, 1426715342, '"magi_step_table"', 'alter table "magi_step_table" modify job_db_inx int not null, modify deleted tinyint default 0 not null, modify cpus_alloc int unsigned not null, modify exit_code int default 0 not null, modify id_step int not null, modify kill_requid int default -1 not null, modify nodelist text not null, modify nodes_alloc int unsigned not null, modify node_inx text, modify state smallint unsigned not null, modify step_name text not null, modify task_cnt int unsigned not null, modify task_dist smallint default 0 not null, modify time_start int unsigned default 0 not null, modify time_end int unsigned default 0 not null, modify time_suspended int unsigned default 0 not null, modify user_sec int unsigned default 0 not null, modify user_usec int unsigned default 0 not null, modify sys_sec int unsigned default 0 not null, modify sys_usec int unsigned default 0 not null, modify max_pages int unsigned default 0 not null, modify max_pages_task int unsigned default 0 not null, modify max_pages_node int unsigned default 0 not null, modify ave_pages double unsigned default 0.0 not null, modify max_rss bigint unsigned default 0 not null, modify max_rss_task int unsigned default 0 not null, modify max_rss_node int unsigned default 0 not null, modify ave_rss double unsigned default 0.0 not null, modify max_vsize bigint unsigned default 0 not null, modify max_vsize_task int unsigned default 0 not null, modify max_vsize_node int unsigned default 0 not null, modify ave_vsize double unsigned default 0.0 not null, modify min_cpu int unsigned default 0 not null, modify min_cpu_task int unsigned default 0 not null, modify min_cpu_node int unsigned default 0 not null, modify ave_cpu double unsigned default 0.0 not null, modify act_cpufreq double unsigned default 0.0 not null, modify consumed_energy double unsigned default 0.0 not null, modify req_cpufreq int unsigned default 0 not null, modify max_disk_read double unsigned default 0.0 not null, modify max_disk_read_task int unsigned default 0 not null, modify max_disk_read_node int unsigned default 0 not null, modify ave_disk_read double unsigned default 0.0 not null, modify max_disk_write double unsigned default 0.0 not null, modify max_disk_write_task int unsigned default 0 not null, modify max_disk_write_node int unsigned default 0 not null, modify ave_disk_write double unsigned default 0.0 not null, drop primary key, add primary key (job_db_inx, id_step);'),
(1426715342, 1426715342, '"magi_suspend_table"', 'alter table "magi_suspend_table" modify job_db_inx int not null, modify id_assoc int not null, modify time_start int unsigned default 0 not null, modify time_end int unsigned default 0 not null;'),
(1426715342, 1426715342, '"magi_usage_day_table"', 'alter table "magi_usage_day_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify time_start int unsigned not null, modify cpu_count int default 0 not null, modify alloc_cpu_secs bigint default 0 not null, modify down_cpu_secs bigint default 0 not null, modify pdown_cpu_secs bigint default 0 not null, modify idle_cpu_secs bigint default 0 not null, modify resv_cpu_secs bigint default 0 not null, modify over_cpu_secs bigint default 0 not null, drop primary key, add primary key (time_start);'),
(1426715342, 1426715342, '"magi_usage_hour_table"', 'alter table "magi_usage_hour_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify time_start int unsigned not null, modify cpu_count int default 0 not null, modify alloc_cpu_secs bigint default 0 not null, modify down_cpu_secs bigint default 0 not null, modify pdown_cpu_secs bigint default 0 not null, modify idle_cpu_secs bigint default 0 not null, modify resv_cpu_secs bigint default 0 not null, modify over_cpu_secs bigint default 0 not null, drop primary key, add primary key (time_start);'),
(1426715342, 1426715342, '"magi_usage_month_table"', 'alter table "magi_usage_month_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify time_start int unsigned not null, modify cpu_count int default 0 not null, modify alloc_cpu_secs bigint default 0 not null, modify down_cpu_secs bigint default 0 not null, modify pdown_cpu_secs bigint default 0 not null, modify idle_cpu_secs bigint default 0 not null, modify resv_cpu_secs bigint default 0 not null, modify over_cpu_secs bigint default 0 not null, drop primary key, add primary key (time_start);'),
(1426715342, 1426715342, '"magi_wckey_table"', 'alter table "magi_wckey_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify is_def tinyint default 0 not null, modify id_wckey int not null auto_increment, modify wckey_name tinytext not null default '''', modify user tinytext not null, drop primary key, add primary key (id_wckey), drop index wckey_name, add unique index (wckey_name(20), user(20));'),
(1426715342, 1426715342, '"magi_wckey_usage_day_table"', 'alter table "magi_wckey_usage_day_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_wckey int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0, modify resv_cpu_secs bigint default 0, modify over_cpu_secs bigint default 0, drop primary key, add primary key (id_wckey, time_start);'),
(1426715342, 1426715342, '"magi_wckey_usage_hour_table"', 'alter table "magi_wckey_usage_hour_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_wckey int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0, modify resv_cpu_secs bigint default 0, modify over_cpu_secs bigint default 0, drop primary key, add primary key (id_wckey, time_start);'),
(1426715342, 1426715342, '"magi_wckey_usage_month_table"', 'alter table "magi_wckey_usage_month_table" modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0 not null, modify id_wckey int not null, modify time_start int unsigned not null, modify alloc_cpu_secs bigint default 0, modify resv_cpu_secs bigint default 0, modify over_cpu_secs bigint default 0, drop primary key, add primary key (id_wckey, time_start);'),
(1426643057, 1426643057, 'acct_coord_table', 'alter table acct_coord_table modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0, modify acct tinytext not null, modify user tinytext not null, drop primary key, add primary key (acct(20), user(20));'),
(1426643057, 1426643057, 'acct_table', 'alter table acct_table modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0, modify name tinytext not null, modify description text not null, modify organization text not null, drop primary key, add primary key (name(20));'),
(1426643057, 1426643057, 'cluster_table', 'alter table cluster_table modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0, modify name tinytext not null, modify control_host tinytext not null default '''', modify control_port int unsigned not null default 0, modify last_port int unsigned not null default 0, modify rpc_version smallint unsigned not null default 0, modify classification smallint unsigned default 0, modify dimensions smallint unsigned default 1, modify plugin_id_select smallint unsigned default 0, modify flags int unsigned default 0, drop primary key, add primary key (name(20));'),
(1426643057, 1426643057, 'qos_table', 'alter table qos_table modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0, modify id int not null auto_increment, modify name tinytext not null, modify description text, modify flags int unsigned default 0, modify grace_time int unsigned default NULL, modify max_jobs_per_user int default NULL, modify max_submit_jobs_per_user int default NULL, modify max_cpus_per_job int default NULL, modify max_cpus_per_user int default NULL, modify max_nodes_per_job int default NULL, modify max_nodes_per_user int default NULL, modify max_wall_duration_per_job int default NULL, modify max_cpu_mins_per_job bigint default NULL, modify max_cpu_run_mins_per_user bigint default NULL, modify grp_jobs int default NULL, modify grp_submit_jobs int default NULL, modify grp_cpus int default NULL, modify grp_mem int default NULL, modify grp_nodes int default NULL, modify grp_wall int default NULL, modify grp_cpu_mins bigint default NULL, modify grp_cpu_run_mins bigint default NULL, modify preempt text not null default '''', modify preempt_mode int default 0, modify priority int unsigned default 0, modify usage_factor double default 1.0 not null, modify usage_thres double default NULL, drop primary key, add primary key (id), drop index name, add unique index (name(20));'),
(1426643057, 1426643057, 'txn_table', 'alter table txn_table modify id int not null auto_increment, modify timestamp int unsigned default 0 not null, modify action smallint not null, modify name text not null, modify actor tinytext not null, modify cluster tinytext not null default '''', modify info blob, drop primary key, add primary key (id);'),
(1426643057, 1426643057, 'user_table', 'alter table user_table modify creation_time int unsigned not null, modify mod_time int unsigned default 0 not null, modify deleted tinyint default 0, modify name tinytext not null, modify admin_level smallint default 1 not null, drop primary key, add primary key (name(20));');

-- --------------------------------------------------------

--
-- Structure de la table `txn_table`
--

DROP TABLE IF EXISTS `txn_table`;
CREATE TABLE IF NOT EXISTS `txn_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `action` smallint(6) NOT NULL,
  `name` text NOT NULL,
  `actor` tinytext NOT NULL,
  `cluster` tinytext NOT NULL,
  `info` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `txn_table`
--

INSERT INTO `txn_table` (`id`, `timestamp`, `action`, `name`, `actor`, `cluster`, `info`) VALUES
(1, 1426715342, 1405, 'magi', 'root', '', 0x6d6f645f74696d653d313432363731353334322c207368617265733d312c206772705f6370755f6d696e733d4e554c4c2c206772705f6370755f72756e5f6d696e733d4e554c4c2c206772705f637075733d4e554c4c2c206772705f6a6f62733d4e554c4c2c206772705f6d656d3d4e554c4c2c206772705f6e6f6465733d4e554c4c2c206772705f7375626d69745f6a6f62733d4e554c4c2c206772705f77616c6c3d4e554c4c2c206d61785f6370755f6d696e735f706a3d4e554c4c2c206d61785f6370755f72756e5f6d696e733d4e554c4c2c206d61785f637075735f706a3d4e554c4c2c206d61785f6a6f62733d4e554c4c2c206d61785f6e6f6465735f706a3d4e554c4c2c206d61785f7375626d69745f6a6f62733d4e554c4c2c206d61785f77616c6c5f706a3d4e554c4c2c206465665f716f735f69643d4e554c4c2c20716f733d272c3127),
(2, 1426715342, 1404, 'id_assoc=2', 'root', 'magi', 0x6d6f645f74696d653d313432363731353334322c20616363743d27726f6f74272c20757365723d27726f6f74272c20706172746974696f6e3d27272c207368617265733d312c206772705f6370755f6d696e733d4e554c4c2c206772705f6370755f72756e5f6d696e733d4e554c4c2c206772705f637075733d4e554c4c2c206772705f6a6f62733d4e554c4c2c206772705f6d656d3d4e554c4c2c206772705f6e6f6465733d4e554c4c2c206772705f7375626d69745f6a6f62733d4e554c4c2c206772705f77616c6c3d4e554c4c2c2069735f6465663d312c206d61785f6370755f6d696e735f706a3d4e554c4c2c206d61785f6370755f72756e5f6d696e733d4e554c4c2c206d61785f637075735f706a3d4e554c4c2c206d61785f6a6f62733d4e554c4c2c206d61785f6e6f6465735f706a3d4e554c4c2c206d61785f7375626d69745f6a6f62733d4e554c4c2c206d61785f77616c6c5f706a3d4e554c4c2c206465665f716f735f69643d4e554c4c2c20716f733d27272c2064656c74615f716f733d2727);

-- --------------------------------------------------------

--
-- Structure de la table `user_table`
--

DROP TABLE IF EXISTS `user_table`;
CREATE TABLE IF NOT EXISTS `user_table` (
  `creation_time` int(10) unsigned NOT NULL,
  `mod_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(4) DEFAULT '0',
  `name` tinytext NOT NULL,
  `admin_level` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `user_table`
--

INSERT INTO `user_table` (`creation_time`, `mod_time`, `deleted`, `name`, `admin_level`) VALUES
(1426643057, 1426643057, 0, 'root', 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;