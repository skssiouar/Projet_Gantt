# Projet Gantt
===
Répertoire racine du projet INFO2.

## Description du projet
---
Créer une application web permettant d'afficher l'état de réservation des noeuds d'un Cluster.

## Description des pages du site
---

### La page de connexion
C'est la page de connexion du site. Pas grand chose à faire dessus. <br />
**Vue -> index.html.twig**

### La page d'affichage d'un diagramme de Gantt
Après s'être connecté à l'application, on arrive sur cette page.
On a accès à une liste de checkBox correspondant aux noeuds du cluster. Cela permet à l'utilisateur de choisir les noeuds qu'il souhaite
voir dans le diagramme. Si tout ou rien n'est sélectionné, alors on construit un diagramme de Gantt de tous les noeuds. <br />
On peut aussi développer un système de filtrage par rapport à des jobs ou des utilisateurs. Si quelqu'un a d'autres idées de filtre, qu'il l'écrive dans ce fichier juste en dessous de ce paragraphe, mentionnée par "Idée de filtre: ..." <br />
**Vue -> main_diagram.html.twig**

### La page des détails d'un noeud
En cliquant sur un noeud sur le diagramme de Gantt, on est redirigé sur cette page affichant les informations complètes sur le noeud. <br />
On pourrait afficher un petit diagramme de Gantt des jobs de ce noeud, la liste des ses jobs en attente. <br />
**Vue -> node_info.html.twig**

### La page des détails d'un job
En cliquant sur un job sur le diagramme de Gantt, on est redirigé sur cette page affichant les informations complètes sur le job.
**Vue -> job_info.html.twig**

### La page des noeuds libres
On pourrait afficher la liste des noeuds libres du cluster, c'est à dire sans réservation. <br />
**Vue -> free_nodes.html.twig**


* Si quelqu'un a d'autres idées de page, qu'il les mette à la fin de ce fichier.
