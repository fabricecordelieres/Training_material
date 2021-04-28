//================ VARIABLES GLOBALES ======================
var outDir=call("ij.Prefs.get", "macroPoitiers.outDir", "");
var analysisModes=newArray("2D", "3D");
var analysis=call("ij.Prefs.get", "macroPoitiers.analysis", "2D");
var projModes=newArray("Average Intensity", "Max Intensity", "Min Intensity", "Sum Slices", "Standard Deviation", "Median");
var proj=call("ij.Prefs.get", "macroPoitiers.proj", "Max Intensity");

//================ CORPS DE LA MACRO ======================
init();
ori=getTitle();
GUI();
getROIs(proj);

if(analysis=="2D"){
	analyze2D();
}else{
	analyze3D(ori);
}

saveData(outDir, ori);

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
 * GUI
 * ------------------------------------
 */
 function GUI(){
	// Créer une boite de dialogue
	Dialog.create("Analyse 2D/3D");
	
	// Choose directory
	Dialog.addDirectory("Sélectionner le répertoire de sortie", outDir);
	
	// 2D ou 3D ? Radio Buttons
	Dialog.addRadioButtonGroup("Type d'analyse", analysisModes, 1, 2, analysis);
	
	// Mode projection ? Menu déroulant
	Dialog.addChoice("Type de projection", projModes, proj);
	
	// Afficher la boite de dialogue
	Dialog.show();
	
	
	// Extraire les entrées utilisateur
	outDir=Dialog.getString();
	analysis=Dialog.getRadioButton();
	proj=Dialog.getChoice();

	// Stocke les préférences
	call("ij.Prefs.set", "macroPoitiers.outDir", outDir);
	call("ij.Prefs.set", "macroPoitiers.analysis", analysis);
	call("ij.Prefs.set", "macroPoitiers.proj", proj);
}

 /*
 * ------------------------------------
 * getROIs
 * ------------------------------------
 */
 function getROIs(projMeth){
	//Modifier le mode d'affichage
	Stack.setDisplayMode("composite");
	
	//Réaliser la projection
	run("Z Project...", "projection=["+projMeth+"]");
	
	//Dessiner et stocker les ROIs
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
 function analyze2D(){
	//Paramétrer les mesures
	run("Set Measurements...", "area mean standard modal min integrated redirect=None decimal=3");
	
	//Réaliser les mesures
	roiManager("Deselect");
	roiManager("multi-measure measure_all");
 }

 /*
 * ------------------------------------
 * analyze3D
 * ------------------------------------
 */
 function analyze3D(img){
	//Activer l'image originale
	selectWindow(img);
 	
	//Collecter les dimensions de l'image
	Stack.getDimensions(width, height, channels, slices, frames);
	
	//Séparer les canaux
	run("Split Channels");
	
	//Pour tous les canaux
	for(j=1; j<=channels; j++){
		//Sélectionner le j-ème canal
		selectWindow("C"+j+"-"+img);
			
		//Pour toutes les ROIs
		for(i=0; i<roiManager("Count"); i++){
	
			//Sélectionner la i-ème ROIs
			roiManager("Select", i);
		
			//Extraire les stats
			Stack.getStatistics(voxelCount, mean, min, max, stdDev);
		
			//Pousser les données vers un tableau
			//voxelCount
			setResult("voxelCount", nResults, voxelCount);
			//mean
			setResult("mean", nResults-1, mean);
			//min
			setResult("min", nResults-1, min);
			//max
			setResult("max", nResults-1, max);
			//stdDev
			setResult("stdDev", nResults-1, stdDev);
			//Roi
			setResult("ROI", nResults-1, i+1);
			//Ch
			setResult("Ch", nResults-1, j);
		}
	}
}

 /*
 * ------------------------------------
 * saveData
 * ------------------------------------
 */
function saveData(dir, img){
	//Sauvegarder les sorties
	imgWoXT=removeExtension(img);
	roiManager("Save", dir+imgWoXT+"_RoiSet.zip");
	saveAs("Results", dir+imgWoXT+"_Results.csv");	
	selectWindow("Results");
	run("Close");
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
