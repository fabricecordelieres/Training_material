//Déclaration de variables
bandWidth=10; //Exprimée en pixels
outPath="/Users/fab/Dropbox/Data/Formations/2022 M1 Poitiers/"; //Répertoire de sortie
baseName="Cell_"; //Nom de base des fichiers de sortie
index=1; //Identifiant numérique du fichier de sortie

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

saveAs("Tiff", outPath+basename+index+".tif");

//Faire le seuillage de chaque couleur (création d’un masque spatial)
//Calculer le pourcentage de colocalisation RV, VB, RB, RVB
//Sauvegarder les ROIs et résultats dans un dossier portant le nom de l’image