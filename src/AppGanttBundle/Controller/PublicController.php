<?php

// src/AppGanttBundle/Controller/PublicController.php

namespace AppGanttBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;


class PublicController extends Controller {

    public function indexAction() {
        $content = $this->get('templating')->render('AppGanttBundle:Public:index.html.twig');
        return new Response($content);
    }


    public function mainDiagramAction() {
    	$content = $this->get('templating')->render('AppGanttBundle:Public:main_diagram.html.twig');
    	return new Response($content);
    }


    public function nodeInfoAction() {
    	$content = $this->get('templating')->render('AppGanttBundle:Public:node_info.html.twig');
    	return new Response($content);
    }


    public function freeNodesAction() {
    	$content = $this->get('templating')->render('AppGanttBundle:Public:free_nodes.html.twig');
    	return new Response($content);
    }
}

?>