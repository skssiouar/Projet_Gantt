<?php
// src/AppGanttBundle/Entity/User.php

namespace AppGanttBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * User
 *
 * @ORM\Table(name="user_table")
 * @ORM\Entity(repositoryClass="AppGanttBundle\Entity\UserRepository")
 */
class User {
	/**
	 * @ORM\Column(name="creation_time", type="int", options={"unsigned":true}, nullable=false)
	 */
	private $creationTime;

	/**
	 * @ORM\Column(name="mod_time", type="int", options={"default":0, "unsigned":true} , nullable=false)
	 */
	private $modTime = 0;

	/**
	 * @ORM\Column(name="deleted", type="int", options={"default:0"})
	 */
	private $deleted = 0;

	/**
	 * @ORM\Column(name="name", type="string", length=20, nullable=false)
	 * @ORM\Id
	 */
	private $name;

	/**
	 * @ORM\Column(name="admin_level", type="int", options={"default:1"}, nullable=false)
	 */
	private $adminLevel = 1;


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


	public function getAdminLevel() {
		return $this->adminLevel;
	}

}
?>
