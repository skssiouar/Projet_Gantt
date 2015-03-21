# Projet Gantt
===
Répertoire racine du projet INFO2.

## Description du projet
Créer une application web permettant d'afficher l'état de réservation des noeuds d'un Cluster.

## Description des pages du site

### La page de connexion
C'est la page de connexion du site. Pas grand chose à faire dessus.

### La page d'affichage d'un diagramme de Gantt
Après s'être connecté à l'application, on arrive sur cette page.
On a accès à une liste de checkBox correspondant aux noeuds du cluster. Cela permet à l'utilisateur de choisir les noeuds qu'il souhaite
voir dans le diagramme. Si tout ou rien n'est sélectionné, alors on construit un diagramme de Gantt de tous les noeuds.
On peut aussi développer un système de filtrage par rapport à des jobs ou des utilisateurs. Si quelqu'un a d'autres idées de filtre, qu'il l'écrive dans ce fichier juste en dessous de ce paragraphe, mentionnée par "Idée de filtre: ..."

### La page des détails d'un noeuds
En cliquant sur un noeud sur le diagramme de Gantt, on est redirigé sur cette page affichant les informations complètes sur le noeud.
On pourrait afficher un petit diagramme de Gantt des jobs de ce noeud, la liste des ses jobs en attente.

### La page des noeuds libres
On pourrait afficher la liste des noeuds libres du cluster, c'est à dire sans réservation.

Si quelqu'un a d'autres idées de page, qu'il les mette à la fin de ce fichier.
