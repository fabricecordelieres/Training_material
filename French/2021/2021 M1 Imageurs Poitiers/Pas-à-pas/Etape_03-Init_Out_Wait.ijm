//Initialisation
close("\\Others");
roiManager("Reset");
run("Clear Results");

//Stockage du nom de l'image courante
ori=getTitle();

Stack.setDisplayMode("composite"); //Modifie le mode de visualisation

//Choix d'un répertoire de sortie
out=getDirectory("Pointer le répertoire de sortie");

//Réaliser une projection de l'image courante
run("Z Project...", "projection=[Max Intensity]");

//Dessiner les régions à analyser
setTool("oval"); //Active l'outil de sélection

//Demander à l'utilisateur d'ajouter les ROIs au ROI Manager
while(roiManager("Count")==0){
	waitForUser("1-Tracer les ROIs à analyser\n2-Les ajouter au ROI Manager en pressant 't'\n3-Répéter 1-2\n4-Cliquer sur Ok pour passer à la suite");
}

//Sauver les régions
roiManager("Show All with labels");
roiManager("Deselect");
roiManager("Save", out+ori+"_RoiSet.zip");

//Option 1: Réaliser les mesures d'intensités dans les régions, en 2D sur la projection
run("Set Measurements...", "area mean standard modal min redirect=None decimal=3");
roiManager("multi-measure measure_all");

//Option 2: Réaliser les mesures d'intensités dans les régions, en 3D sur la pile d'origine

//Sauvegarder les résultats dans un fichier csv
saveAs("Results", out+ori+"_Results.csv");
