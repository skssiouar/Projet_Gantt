<?php
// src/AppGanttBundle/Entity/Cluster.php

namespace AppGanttBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * Cluster
 *
 * @ORM\Table(name="cluster_table")
 * @ORM\Entity(repositoryClass="AppGanttBundle\Entity\ClusterRepository")
 */
class Cluster {
	/**
	 * @ORM\Column(name="creation_time", type="int", options={"unsigned":true}, nullable=false)
	 */
	private $creationTime;

	/**
	 * @ORM\Column(name="mod_time", type="int", options={"default":0, "unsigned":true} , nullable=false)
	 */
	private $modTime = 0;

	/**
	 * @ORM\Column(name="deleted", type="boolean", options={"default:"false})
	 */
	private $deleted = false;

	/**
	 * @ORM\Column(name="name", type="string", length=20, nullable=false)
	 * @ORM\Id
	 */
	private $name;

	/**
	 * @ORM\Column(name="control_host", type="string", nullable=false)
	 */
	private $controlHost;

	/**
	 * @ORM\Column(name="control_port", type="int", options={"default":0, "unsigned":true}, nullable=false)
	 */
	private $controlPort = 0;

	/**
	 * @ORM\Column(name="last_port", type="int", options={"default":0, "unsigned":true}, nullable=false)
	 */
	private $lastPort = 0;

	/**
	 * @ORM\Column(name="rpc_version", type="smallint", options={"default":0, "unsigned":true}, nullable=false)
	 */
	private $rpcVersion = 0;

	/**
	 * @ORM\Column(name="classification", type="smallint", options={"default":0, "unsigned":true})
	 */
	private $classification = 0;

	/**
	 * @ORM\Column(name="dimensions", type="smallint", options={"default":1, "unsigned":true})
	 */
	private $dimensions = 1;

	/**
	 * @ORM\Column(name="plugin_id_select", type="smallint", options={"default":0, "unsigned":true})
	 */
	private $pluginIdSelect = 0;

	/**
	 * @ORM\Column(name="flags", type="int", options={"default":0})
	 */
	private $flags = 0;


	public function __construct() {}


    /**
     * Get creationTime
     *
     * @return \int 
     */
    public function getCreationTime() {
        return $this->creationTime;
    }


    /**
     * Get modTime
     *
     * @return \int 
     */
    public function getModTime() {
        return $this->modTime;
    }


    /**
     * Get deleted
     *
     * @return \int 
     */
    public function getDeleted() {
        return $this->deleted;
    }


    /**
     * Get name
     *
     * @return string 
     */
    public function getName() {
        return $this->name;
    }


    /**
     * Get controlHost
     *
     * @return string 
     */
    public function getControlHost() {
        return $this->controlHost;
    }

    
    /**
     * Get controlPort
     *
     * @return \int 
     */
    public function getControlPort() {
        return $this->controlPort;
    }


    /**
     * Get lastPort
     *
     * @return \int 
     */
    public function getLastPort() {
        return $this->lastPort;
    }


    /**
     * Get rpcVersion
     *
     * @return \int 
     */
    public function getRpcVersion() {
        return $this->rpcVersion;
    }


    /**
     * Get classification
     *
     * @return \int 
     */
    public function getClassification() {
        return $this->classification;
    }


    /**
     * Get dimensions
     *
     * @return \int 
     */
    public function getDimensions() {
        return $this->dimensions;
    }


    /**
     * Get pluginIdSelect
     *
     * @return \int 
     */
    public function getPluginIdSelect() {
        return $this->pluginIdSelect;
    }


    /**
     * Get flags
     *
     * @return \int 
     */
    public function getFlags() {
        return $this->flags;
    }
}
?>
