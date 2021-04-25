Stack.setDisplayMode("composite"); //Modifie le mode de visualisation

//Réaliser une projection de l'image courante
run("Z Project...", "projection=[Max Intensity]");

//Dessiner les régions à analyser
setTool("oval"); //Active l'outil de sélection

makeOval(227, 44, 133, 140);
roiManager("Add");
makeOval(81, 276, 127, 128);
roiManager("Add");
makeOval(629, 399, 144, 161);
roiManager("Add");
makeOval(143, 628, 181, 185);
roiManager("Add");

//Sauver les régions
roiManager("Show All with labels");
roiManager("Deselect");
roiManager("Save", "/2021 M1 Imageurs Poitiers/RoiSet.zip");

//Option 1: Réaliser les mesures d'intensités dans les régions, en 2D sur la projection
run("Set Measurements...", "area mean standard modal min redirect=None decimal=3");
roiManager("multi-measure measure_all");

//Option 2: Réaliser les mesures d'intensités dans les régions, en 3D sur la pile d'origine

//Sauvegarder les résultats dans un fichier csv
saveAs("Results", "/2021 M1 Imageurs Poitiers/Results.csv");
