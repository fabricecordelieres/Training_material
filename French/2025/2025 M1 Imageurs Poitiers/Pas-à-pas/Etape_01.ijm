//Le cas échéant, vider le ROI Manager.
//Activer l’outil de sélection multi-point.
//Le cas échéant, éliminer de l’image toute ROI déjà présente.
//Demander à l’utilisateur de dessiner une région d’intérêt sur l’image.
//Ajouter la région au ROI Manager
//Une fois la région multi-point dans le ROI Manager, l’activer, puis extraire les coordonnées XY des points qui la constituent.
//Définir une variable "size" : elle contiendra la taille du carré à centrer autour de chacun des points de la sélection.
//Pour chacun des jeux de coordonnées :
	//Créer une sélection rectangulaire centrée sur la coordonnée XY courante et de côté "size".
	//Dupliquer la portion d’image contenant la région et la nommer "Particle_ZZ" (où ZZ est un index unique associé à la particule courante).
//Une fois toutes les vignettes générées, les assembler en une seule pile d’images nommée "Thumbnails"