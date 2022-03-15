//Déclaration de variables
bandWidth=10; //Exprimée en pixels
outPath="/Users/fab/Dropbox/Data/Formations/2022 M1 Poitiers/"; //Répertoire de sortie
baseName="Cell_"; //Nom de base des fichiers de sortie
index=1; //Identifiant numérique du fichier de sortie

//*************** APPEL DES FONCTIONS ***************
//Demander un répertoire de sortie
outPath=getDirectory("Où stocker les sorties ?");

//Stocker le nom de l'image courante
ori=getTitle();

//Créer le nom de base en éliminant l'extension
baseName=substring(ori, 0, lastIndexOf(ori, "."));

init();
getROIs(outPath, baseName);
cutOutROIs(bandWidth, outPath, baseName);






//*************** INITIALISATION ***************
function init(){
	//Fermer les images, sauf l'image courante
	close("\\Others");
	
	//Réinitialiser le ROI Manager
	roiManager("Reset");
	
	//Réinitialiser la table de résultats
	run("Clear Results");
}
	
//*************** METTRE L'EXECUTION EN PAUSE ***************
function getROIs(outPath, baseName){
	while(roiManager("Count")==0){
		waitForUser("1-Dessiner une ROI\n2-L'ajouter au ROI anager en pressant 't'\n3-Répéter\n4-Presser 'Ok' pour continuer");
	}
	roiManager("Save", outPath+baseName+"_RoiSet.zip");
}

//*************** DECOUPER & SAUVER LES IMAGETTES ***************
function cutOutROIs(bandWidth, outPath, baseName){
	//Stocker le nom de l'image courante
	ori=getTitle();

	for(i=0;i<roiManager("Count"); i++){
		//Sélectionner l'image de base
		selectWindow(ori);
	
		//Activer la i-ème ROI
		roiManager("Select", i);
		
		//Déterminer les contours sur plan focal (pas toujours le même plan d’une série Z)
		run("Duplicate...", "title=Cell");
		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
		run("Properties... ", "name=Cell");
		run("Add Selection...");
		run("Enlarge...", "enlarge=-"+bandWidth+" pixel");
		run("Properties... ", "name=Cytoplasm");
		run("Add Selection...");
		getPixelSize(unit, pixelWidth, pixelHeight);
		run("Make Band...", "band="+bandWidth*pixelWidth);
		run("Properties... ", "name=Membrane");
		run("Add Selection...");
		
		saveAs("Tiff", outPath+baseName+"_Cell-"+(i+1)+".tif");
	
		//Fermer l'imagette
		close();
	}
}






//Faire le seuillage de chaque couleur (création d’un masque spatial)
//Calculer le pourcentage de colocalisation RV, VB, RB, RVB
//Sauvegarder les ROIs et résultats dans un dossier portant le nom de l’image