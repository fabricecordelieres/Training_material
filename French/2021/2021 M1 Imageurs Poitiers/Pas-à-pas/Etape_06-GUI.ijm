//Initialisation
init();

//Stockage du nom de l'image courante
ori=getTitle();

Stack.setDisplayMode("composite"); //Modifie le mode de visualisation

//Variables globales stockant les paramètres d'analyse
var outDir="";
var analysisMode="2D";
var projMeth=newArray("Average Intensity", "Max Intensity", "Min Intensity", "Sum Slices", "Standard Deviation", "Median");
var projMode="Sum Slices";

//------------------------------------------------------------------------------------------
//Corps de la macro

GUI();

//Réaliser une projection de l'image courante
run("Z Project...", "projection=["+projMode+"]");

//Obtenir et sauvegarder les ROIs
getROIs(outDir, ori);

//Adaptation du comportement de la macro: analyse 2D ou 3D
if(analysisMode=="2D"){
	//Analyser en 2D
	analyze2D(outDir, ori);
}else{
	//Analyser en 3D
	analyze3D(outDir, ori);
}



//------------------------------------------------------------------------------------------
//Création d'une interface graphique et extraction des paramètres utilisateur
function GUI(){
	//Création de la GUI
	Dialog.create("Analyse de ROIs");
	Dialog.addDirectory("Sélectionner le répertoire de sortie", outDir);
	Dialog.addRadioButtonGroup("Mode d'analyse", newArray("2D", "3D"), 1, 2, analysisMode);
	Dialog.addChoice("Mode de projection", projMeth, projMode);
	Dialog.show();
	
	//Stockage des paramètres utilisateur
	outDir=Dialog.getString();
	analysisMode=Dialog.getRadioButton();
	projMode=Dialog.getChoice();
}

//------------------------------------------------------------------------------------------
//Initialisation
function init(){
	close("\\Others");
	roiManager("Reset");
	run("Clear Results");
}

//------------------------------------------------------------------------------------------
//Obtenir et sauvegarder les ROIs
function getROIs(out, ori){
	//Dessiner les régions à analyser
	setTool("oval"); //Active l'outil de sélection
	
	//Demander à l'utilisateur d'ajouter les ROIs au ROI Manager
	while(roiManager("Count")==0){
		waitForUser("1-Tracer les ROIs à analyser\n2-Les ajouter au ROI Manager en pressant 't'\n3-Répéter 1-2\n4-Cliquer sur Ok pour passer à la suite");
	}
	
	//Sauver les régions
	roiManager("Show All with labels");
	roiManager("Deselect");
	roiManager("Save", out+removeExtension(ori)+"_RoiSet.zip");
}

//------------------------------------------------------------------------------------------
//Analyser en 2D
function analyze2D(out, ori){
	//Option 1: Réaliser les mesures d'intensités dans les régions, en 2D sur la projection
	run("Set Measurements...", "area mean standard modal min redirect=None decimal=3");
	roiManager("multi-measure measure_all");
	
	//Sauvegarder les résultats dans un fichier csv
	saveAs("Results", out+removeExtension(ori)+"_Results_2D.csv");
}

//------------------------------------------------------------------------------------------
//Analyser en 3D
function analyze3D(out, ori){
	//Important: sélectionner l'image d'origine
	selectWindow(ori);
	
	//Stockage des dimensions
	Stack.getDimensions(width, height, channels, slices, frames);
	
	//Séparation des canaux
	run("Split Channels");

	//Pour chaque canal
	for(c=1; c<=channels; c++){
		selectWindow("C"+c+"-"+ori);
		
		//Pour chaque ROI
		for(r=0; r<roiManager("count"); r++){
			//Activation de la ROI
			roiManager("Select", r);
			
			//Mesures
			Stack.getStatistics(voxelCount, mean, min, max, stdDev);
			
			//Ajout au tableau de résultats
			//Volume
			setResult("Volume", nResults, voxelCount);
			
			//Mean
			setResult("Mean", nResults-1, mean);
			
			//StdDev
			setResult("StdDev", nResults-1, stdDev);
			
			//Min
			setResult("Min", nResults-1, min);
			
			//Max
			setResult("Max", nResults-1, max);
			
			//Ch
			setResult("C", nResults-1, c);
		}
	}

	//Sauvegarder les résultats dans un fichier csv
	saveAs("Results", out+removeExtension(ori)+"_Results_3D.csv");
}

//------------------------------------------------------------------------------------------
//Eliminer l'extension du titre de l'image
function removeExtension(input){
	output=replace(input, ".tif", "");
	output=replace(output, ".TIF", "");
	return output;
}
