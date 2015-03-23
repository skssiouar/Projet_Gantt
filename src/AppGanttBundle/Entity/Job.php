<?php
// src/AppGanttBundle/Entity/Job.php

namespace AppGanttBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * Job
 *
 * @ORM\Table(name="job_table")
 * @ORM\Entity(repositoryClass="AppGanttBundle\Entity\JobRepository")
 */
class Job {
	/**
	 * @ORM\Column(name="job_db_inx", type="int", nullable=false)
	 * @ORM\Id
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $jobDbInx;
	
	/**
	 * @ORM\Column(name="mod_time", type="int", options={"default":0, "unsigned":true} , nullable=false)
	 */
	private $modTime = 0;
	
	/**
	 * @ORM\Column(name="deleted", type="boolean", options={"default":false})
	 */
	private $deleted = false;
	
	/**
	 * @ORM\Column(name="account", type="string")
	 */
	private $account;
	
	/**
	 * @ORM\Column(name="cpus_req", type="int", nullable=false, options={"unsigned":true})
	 */
	private $cpusReq;
	
	/**
	 * @ORM\Column(name="cpus_alloc", type="int", nullable=false, options={"unsigned":true})
	 */
	private $cpusAlloc;
	
	/**
	 * @ORM\Column(name="derived_ec", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $derivedEc = 0;
	
	/**
	 * @ORM\Column(name="derived_es", type="string")
	 */
	private $derivedEs;
	
	/**
	 * @ORM\Column(name="exit_code", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $exitCode = 0;
	
	/**
	 * @ORM\Column(name="job_name", type="string", nullable=false)
	 */
	private $jobName;

	/**
	 * @ORM\Column(name="id_assoc", type="int", nullable=false, options={"unsigned":true})
	 */
	private $idAssoc;
	
	/**
	 * @ORM\Column(name="id_block", type="string")
	 */
	private $idBlock;
	
	/**
	 * @ORM\Column(name="id_job", type="int", nullable=false, options={"unsigned":true})
	 */
	private $idJob;
	
	/**
	 * @ORM\Column(name="id_job", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $idQos = 0;
	
	/**
	 * @ORM\Column(name="id_resv", type="int", nullable=false, options={"unsigned":true})
	 */
	private $idResv;
	
	/**
	 * @ORM\Column(name="id_user", type="int", nullable=false, options={"unsigned":true})
	 */
	private $idUser;
	
	/**
	 * @ORM\Column(name="id_group", type="int", nullable=false, options={"unsigned":true})
	 */
	private $idGroup;
	
	/**
	 * @ORM\Column(name="kill_requid", type="int", nullable=false, options={"default":-1})
	 */
	private $killRequid = -1;
	
	/**
	 * @ORM\Column(name="mem_req", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $memReq = 0;
	
	/**
	 * @ORM\Column(name="nodelist", type="string")
	 */
	private $nodelist;
	
	/**
	 * @ORM\Column(name="nodes_alloc", type="int", nullable=false, options={"unsigned":true})
	 */
	private $nodesAlloc;
	
	/**
	 * @ORM\Column(name="node_inx", type="string")
	 */
	private $nodeInx;
	
	/**
	 * @ORM\Column(name="partition", type="string", nullable=false)
	 */
	private $partition;
	
	/**
	 * @ORM\Column(name="priority", type="int", nullable=false, options={"unsigned":true})
	 */
	private $priority;
	
	/**
	 * @ORM\Column(name="state", type="smallint", nullable=false, options={"unsigned":true})
	 */
	private $state;
	
	/**
	 * @ORM\Column(name="timelimit", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $timelimit = 0;
	
	/**
	 * @ORM\Column(name="time_submit", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $timeSubmit = 0;
	
	/**
	 * @ORM\Column(name="time_eligible", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $timeEligible = 0;
	
	/**
	 * @ORM\Column(name="time_start", type="int", nullable=false, options={"default":0})
	 */
	private $timeStart = 0;
	
	/**
	 * @ORM\Column(name="time_end", type="int", nullable=false, options={"default":0})
	 */
	private $timeEnd = 0;
	
	/**
	 * @ORM\Column(name="time_suspended", type="int", nullable=false, options={"unsigned":true, "default":0})
	 */
	private $timeSuspended = 0;
	
	/**
	 * @ORM\Column(name="gres_req", type="string", nullable=false)
	 */
	private $gresReq;
	
	/**
	 * @ORM\Column(name="gres_alloc", type="string", nullable=false)
	 */
	private $gresAlloc;
	
	/**
	 * @ORM\Column(name="gres_used", type="string", nullable=false)
	 */
	private $gresUsed;
	
	/**
	 * @ORM\Column(name="wckey", type="string", nullable=false)
	 */
	private $wckey;
	
	/**
	 * @ORM\Column(name="track_steps", type="boolean", options={"default":false})
	 */
	private $deleted = false;
}
?>
