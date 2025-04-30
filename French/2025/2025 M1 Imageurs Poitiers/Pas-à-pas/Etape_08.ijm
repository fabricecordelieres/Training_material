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
size=getNumber("Taille du carré", 64);

generateThumbnails(size);

getIntensityProfiles();



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

//---------------------------------------------------------------------------------------------------------
function getIntensityProfiles(){
	//Définir une série de couleurs à utiliser au moyen d'une variable de type tableau
	colors=newArray("black", "blue", "cyan", "darkGray", "gray", "green", "lightGray", "magenta", "orange", "pink", "red", "white", "yellow");
	
	//GARDER UNE TRACE DE L'IMAGE ORIGINALE
	ori=getTitle();
	
	//Rapatrier la calibration de l'image.
	getPixelSize(unit, pixelWidth, pixelHeight);
	
	//Créer une variable de type tableau, nommée x, et remplir chaque cellule avec la distance calibrée du pixel au bord gauche de l'image.
	x=newArray(getWidth());
	for(i=0; i<x.length; i++) x[i]=i*pixelWidth;
	
	
	//Initialiser un graph ayant pour titre "Intensity over an horizontal mid-line", pour légende des abscisses "Position in x (unité)", et pour légende des ordonnées "Intensity (AU)".
	Plot.create("Intensity over an horizontal mid-line", "Position in x ("+unit+")", "Intensity (AU)");
	
	//Créer un accumulateur qui permettra de conserver la somme des intensités, pour le calcul de moyenne
	moyenne=newArray(getWidth());
	
	//Pour toutes les images de la pile:
	for(i=1; i<=nSlices;i++){
		//ACTIVER L'IMAGE D'ORIGINE
		selectWindow(ori);
		
		//Activer la i-ème image de la pile.
		setSlice(i);
		
		//Positionner une sélection de type ligne horizontalement, passant par le centre de l'image.
		makeLine(0, getHeight()/2, getWidth()-1, getHeight()/2);
		
		//Rapatrier les valeurs d'intensités le long de la ligne et les stocker dans une variable de type tableau, nommée "intensityProfile".
		intensityProfile=getProfile();
		
		//En amont de l'ajout du tracé, on peut modifier sa future couleur d'affichage.
		Plot.setColor(colors[i%colors.length]);
		
		//Ajouter au graph précédent le tracé de type "line", à partir des données (x, intensityProfile).
		Plot.add("line", x, intensityProfile);
		
		//Alimenter l'accumulateur
		for(j=0; j<intensityProfile.length; j++) moyenne[j]+=intensityProfile[j];
		
	}
	
	//Ajuster les axes
	Plot.setLimitsToFit();
	
	//Afficher le graph.
	Plot.show();
	
	//Calculer les moyennes des profils d'intensités
	for(i=0; i<moyenne.length; i++) moyenne[i]/=nSlices;
	
	//Tracer le graph des moyennes des profils
	Plot.create("Averaged intensity over an horizontal mid-line", "Position in x ("+unit+")", "Intensity (AU)", x, moyenne);
	Plot.show();
}