//Déclaration de variables
bandWidth=10; //Exprimée en pixels
outPath="/Users/fab/Dropbox/Data/Formations/2022 M1 Poitiers/"; //Répertoire de sortie
baseName="Cell_"; //Nom de base des fichiers de sortie
index=1; //Identifiant numérique du fichier de sortie
subBkgd=5; //Rayon pour la soustraction de fond

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

//*************** REPETER POUR TOUTES LES IMAGETTES ***************
files=getFileList(outPath);
for(i=0; i<files.length; i++){
	if(endsWith(files[i], ".tif")){ //N'appliquer qu'aux fichiers tif
		open(outPath+files[i]);
		prepareData(subBkgd);
		combineMasks();
		updateResults(); //Forcer à mettre à jour et montrer le tableau
		run("Close All");
	}
}

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

//*************** CREER LES MASQUES BINAIRES ***************
function prepareData(subBkgdRad){
	roiManager("Reset");
	run("To ROI Manager");
	ori=getTitle();
	run("Split Channels");
	
	row=nResults;
	for(i=2; i<=4; i++){
		selectWindow("C"+i+"-"+ori);
		run("Subtract Background...", "rolling="+subBkgdRad);
		roiManager("Select", 2);
		setAutoThreshold("Li dark");
		setOption("BlackBackground", false);
		run("Convert to Mask");
		rename("C"+i);
		setResult("Label", row, ori);
		measureInROIS(row);
	}
	run("Tile");
}

//*************** COMBINER LES MASQUES ***************
function combineMasks(){
	row=nResults;
	//Combinaison "intelligente" des masques 2 à 2
	for(i=2; i<=4; i++){
		for(j=i+1; j<=4; j++){
			imageCalculator("AND create", "C"+i,"C"+j);
			rename("C"+i+"-C"+j);
			measureInROIS(row-1);
		}
	}

	//La triple combinaison est effectuée indépendamment
	imageCalculator("AND create", "C2-C3","C4");
	rename("C2-C3-C4");
	measureInROIS(row-1);
	run("Tile");
}

//*************** MESURER DANS TOUTES LES ROIS ***************
function measureInROIS(row){
	for(i=0; i<roiManager("Count"); i++){
		roiManager("Select", i);
		roiName=Roi.getName;
		img=getTitle();
		setAutoThreshold("Default");
		List.setMeasurements("limit");
		area=List.getValue("Area");
		resetThreshold();
		setResult(img+"_"+roiName, row, area);
		run("Select None");
	}
}
