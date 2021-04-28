init();
outDir=getDirectory("Sélectionner le répertoire de sortie");
ori=getTitle();
getROIs(ori);
analyze2D(outDir, ori);

//================ FUNCTIONS ======================
/*
 * ------------------------------------
 * INIT
 * ------------------------------------
 */
 function init(){
	//Initialisation
	//Vider le ROI Manager
	roiManager("Reset");
	
	//Vider le tableau de résultats
	run("Clear Results");
	
	//Fermer toutes les images SAUF l'image courante
	close("\\Others");
 }

 /*
 * ------------------------------------
 * getROIs
 * ------------------------------------
 */
 function getROIs(img){
	//Modifier le mode d'affichage
	Stack.setDisplayMode("composite");
	
	//Réaliser la projection
	run("Z Project...", "projection=[Max Intensity]");
	
	//Dessiner et stocker les ROIs
	selectWindow("MAX_"+img);
	setTool("oval");
	
	while(roiManager("count")==0){
		//Demander à l'utilisateur de tracer et pousser les ROIs vers le ROI Manager
		waitForUser("Dessiner les ROIs,\nAjouter au ROI Manager (t),\nRépéter,\nCliquer sur Ok\nSi t'en as marre, presse ESC");
 	}
 }

 /*
 * ------------------------------------
 * analyze2D
 * ------------------------------------
 */
 function analyze2D(dir, img){
	//Paramétrer les mesures
	run("Set Measurements...", "area mean standard modal min integrated redirect=None decimal=3");
	
	//Réaliser les mesures
	roiManager("Deselect");
	roiManager("multi-measure measure_all");
	
	//Sauvegarder les sorties
	imgWoXT=removeExtension(img);
	roiManager("Save", dir+imgWoXT+"_RoiSet.zip");
	saveAs("Results", dir+imgWoXT+"_Results.csv");
 }	

 /*
 * ------------------------------------
 * removeExtension string ==> removeExtension ==> string
 * ------------------------------------
 */
function removeExtension(chaine){
	elements=split(chaine, ".");
	elements[elements.length-1]="";
	newName=String.join(elements, "");
	return newName;
}
