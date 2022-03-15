//Déclaration de variables GLOBALES
var bandWidth=call("ij.Prefs.get", "macroPoitiers.bandWidth", 10); //Exprimée en pixels
var outPath=call("ij.Prefs.get", "macroPoitiers.outPath", ""); //Répertoire de sortie
var baseName=call("ij.Prefs.get", "macroPoitiers.baseName", "Cell_"); //Nom de base des fichiers de sortie
var subBkgd=call("ij.Prefs.get", "macroPoitiers.subBkgd", 5); //Rayon pour la soustraction de fond

GUI();

//*************** INTERFACE UTILISATEUR ***************
function GUI(){
	//Interface graphique
	Dialog.create("Analyse de co-localisation");
	Dialog.addString("Nom_de_base_des_sorties", baseName);
	Dialog.addDirectory("Répertoire_de_sortie", outPath);
	Dialog.addNumber("Largeur_de_la_bande_membranaire", bandWidth);
	Dialog.addNumber("Rayon_de_la_soustraction_de_fond", subBkgd);
	Dialog.show();

	//Stockage des choix utilisateurs
	baseName=Dialog.getString();
	outPath=Dialog.getString();
	bandWidth=Dialog.getNumber();
	subBkgd=Dialog.getNumber();

	//Stockage des préférences
	call("ij.Prefs.set", "macroPoitiers.bandWidth", bandWidth);
	call("ij.Prefs.set", "macroPoitiers.outPath", outPath);
	call("ij.Prefs.set", "macroPoitiers.baseName", baseName);
	call("ij.Prefs.set", "macroPoitiers.subBkgd", subBkgd);
}