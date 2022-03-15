//Déterminer les contours sur plan focal (pas toujours le même plan d’une série Z)
run("Duplicate...", "title=Cell");
setBackgroundColor(0, 0, 0);
run("Clear Outside");
run("Properties... ", "name=Cell");
run("Add Selection...");
run("Enlarge...", "enlarge=-10 pixel");
run("Properties... ", "name=Cytoplasm");
run("Add Selection...");
run("Make Band...", "band=1.26");
run("Properties... ", "name=Membrane");
run("Add Selection...");

saveAs("Tiff", "/Users/fab/Dropbox/Data/Formations/2022 M1 Poitiers/Cell.tif");

//Faire le seuillage de chaque couleur (création d’un masque spatial)
//Calculer le pourcentage de colocalisation RV, VB, RB, RVB
//Sauvegarder les ROIs et résultats dans un dossier portant le nom de l’image