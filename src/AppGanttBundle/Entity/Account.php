<?php
// src/AppGanttBundle/Entity/Account.php

namespace AppGanttBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * Account
 *
 * @ORM\Table(name="acct_table")
 * @ORM\Entity(repositoryClass="AppGanttBundle\Entity\AccountRepository")
 */
class Account {
	/**
	 * @ORM\Column(name="creation_time", type="int", options={"unsigned":true}, nullable=false)
	 */
	private $creationTime;

	/**
	 * @ORM\Column(name="mod_time", type="int", options={"default":0, "unsigned":true} , nullable=false)
	 */
	private $modTime = 0;

	/**
	 * @ORM\Column(name="deleted", type="boolean", options={"default":false})
	 */
	private $deleted = false;

	/**
	 * @ORM\Column(name="name", type="string", length=20, nullable=false)
	 * @ORM\Id
	 */
	private $name;

	/**
	 * @ORM\Column(name="description", type="string", nullable=false)
	 */
	private $description;
	
	/**
	 * @ORM\Column(name="organization", type="string", nullable=false)
	 */
	private $organization;


	public function __construct() {}


	public function getCreationTime() {
		return $this->creationTime;
	}


	public function getModTime() {
		return $this->modTime;
	}


	public function getDeleted() {
		return $this->deleted;
	}


	public function getName() {
		return $this->name;
	}


	public function getDescription() {
		return $this->description;
	}
	
	
	public function getOrganization() {
		return $this->organization;
	}

}
?>
