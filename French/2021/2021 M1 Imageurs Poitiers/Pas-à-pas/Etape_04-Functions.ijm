//Initialisation
init();

//Stockage du nom de l'image courante
ori=getTitle();

Stack.setDisplayMode("composite"); //Modifie le mode de visualisation

//Choix d'un répertoire de sortie
out=getDirectory("Pointer le répertoire de sortie");

//Réaliser une projection de l'image courante
run("Z Project...", "projection=[Max Intensity]");

//Obtenir et sauvegarder les ROIs
getROIs(out, ori);

//Analyser en 2D
analyze2D(out, ori);



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
	saveAs("Results", out+removeExtension(ori)+"_Results.csv");
}

//------------------------------------------------------------------------------------------
//Eliminer l'extension du titre de l'image
function removeExtension(input){
	output=replace(input, ".tif", "");
	output=replace(output, ".TIF", "");
	return output;
}
