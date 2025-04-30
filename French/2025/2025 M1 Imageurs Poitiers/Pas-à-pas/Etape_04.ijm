//Le cas échéant, vider le ROI Manager.
roiManager("Reset");

//Activer l’outil de sélection multi-point.
setTool("multipoint");

//GESTION DES EXCEPTIONS: si aucune image n'est ouverte
if(nImages==0) exit("Aucune image n'est ouverte");

//Le cas échéant, éliminer de l’image toute ROI déjà présente.
run("Select None");

//Demander à l’utilisateur de dessiner une région d’intérêt sur l’image.
waitForUser("1-Cliquer sur toutes les structures\n2-Cliquer sur Ok");

//GESTION DES EXCEPTIONS: si aucune ROI n'est présente à l'image
if(selectionType()==-1) exit("Aucune structure à isoler");

//Ajouter la région au ROI Manager
roiManager("Add");

//Définir une variable "size" : elle contiendra la taille du carré à centrer autour de chacun des points de la sélection.
size=64;

generateThumbnails(size);

//---------------------------------------------------------------------------------------------------------
function generateThumbnails(size){
	//GESTION DES EXCEPTIONS: si aucune ROI n'est présente dans le ROI Manager
	if(roiManager("Count")==0) exit("Aucune ROI dans le ROI Manager");
	
	//Une fois la région multi-point dans le ROI Manager, l’activer, puis extraire les coordonnées XY des points qui la constituent.
	roiManager("Select", 0);
	Roi.getCoordinates(xpoints, ypoints);
	
	//GARDER UNE TRACE DE L'IMAGE ORIGINALE
	ori=getTitle();
	
	//Pour chacun des jeux de coordonnées :
	for(i=0; i<xpoints.length; i++){
		//ACTIVER L'IMAGE D'ORIGINE
		selectWindow(ori);
		
		//Créer une sélection rectangulaire centrée sur la coordonnée XY courante et de côté "size".
		makeRectangle(xpoints[i]-size/2, ypoints[i]-size/2, size, size);
		
		//Dupliquer la portion d’image contenant la région et la nommer "Particle_ZZ" (où ZZ est un index unique associé à la particule courante).
		run("Duplicate...", "title=Particle_"+(i+1));	
	}
	
	//Une fois toutes les vignettes générées, les assembler en une seule pile d’images nommée "Thumbnails"
	run("Images to Stack", "name=Thumbnails title=Particle_ use");
}