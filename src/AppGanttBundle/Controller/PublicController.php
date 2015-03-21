<?php

// src/AppGanttBundle/Controller/PublicController.php

namespace AppGanttBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;


class PublicController extends Controller {

    public function indexAction() {
        return $this->render('AppGanttBundle:Public:index.html.twig');
    }


    public function main_diagramAction() {
    	return $this->render('AppGanttBundle:Public:main_diagram.html.twig');
    }


    public function node_infoAction() {
    	return $this->render('AppGanttBundle:Public:node_info.html.twig');
    }


    public function free_nodesAction() {
    	return $this->render('AppGanttBundle:Public:free_nodes.html.twig');
    }
}

?>