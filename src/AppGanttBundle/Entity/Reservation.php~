<?php
// src/AppGanttBundle/Entity/Reservation.php

namespace AppGanttBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * Reservation
 *
 * @ORM\Table(name="resv_table")
 * @ORM\Entity(repositoryClass="AppGanttBundle\Entity\ReservationRepository")
 */
class Reservation {
	/**
	 * @ORM\Column(name="id_resv", type="int", nullable=false, options={"default":0})
	 * @ORM\Id
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id = 0;
	
	/**
	 * @ORM\Column(name="deleted", type="boolean", nullable=false, options={"default":false})
	 */
	private $deleted = false;
	
	/**
	 * @ORM\Column(name="assoclist", type="string", nullable=false)
	 */
	private $assoclist;
	
	/**
	 * @ORM\Column(name="cpus", type="int", nullable=false, options={"unsigned":false})
	 */
	private $cpus;
	
	/**
	 * @ORM\Column(name="flags", type="smallint", nullable=false, options={"default":0})
	 */
	private $flags = 0;
	
	/**
	 * @ORM\Column(name="nodelist", type="string", nullable=false)
	 */
	private $nodelist;
	
	/**
	 * @ORM\Column(name="node_inx", type="string", nullable=false)
	 */
	private $nodeInx;
	
	/**
	 * @ORM\Column(name="node_name", type="string", nullable=false)
	 */
	private $resvName
	
	/**
	 * @ORM\Column(name="time_start", type="int", nullable=false, options={"default":0})
	 * @ORM\Id
	 * @GeneratedValue(strategy="NONE")
	 */
	private $timeStart = 0;
	
	/**
	 * @ORM\Column(name="time_end", type="int", nullable=false, options={"default":0})
	 */
	private $timeEnd = 0;

}
?>
