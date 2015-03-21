<?php

namespace AppGanttBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;


class DefaultController extends Controller {
    public function indexAction($name) {
        return $this->render('AppGanttBundle:Default:index.html.twig', 
        	array(
        		'name' => $name
       	));
    }


    public function pageAction($page) {
    	return $this->render('AppGanttBundle:Default:page.html.twig',
    		array(
    			'page' => $page
    	));
    }
}

?>