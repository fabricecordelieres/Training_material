var outDir="";
var analysisModes=newArray("2D", "3D");
var analysis="2D";
var projModes=newArray("Average Intensity", "Max Intensity", "Min Intensity", "Sum Slices", "Standard Deviation", "Median");
var proj="Max Intensity";


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
}