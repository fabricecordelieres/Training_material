var minSize=50;
var chNuclei=1;
var chSgl=2;
var dMax=200;



run("Select None");
close("\\Others");
GUI();
img=getTitle();
unwrapAllNuclei(img, minSize, chNuclei, chSgl, dMax);
analyzeAndPlot();

//-------------------------------------------------------------------------------
//Afficher l'interface utilisateur
function GUI(){
	Dialog.create("Analyse d'intensité autour du noyau");
	Dialog.addNumber("Taille minimale du noyau (pixels)", minSize);
	Dialog.addNumber("Canal des noyaux", chNuclei);
	Dialog.addNumber("Canal à quantifier", chSgl);
	Dialog.addNumber("Distance maximale d'analyse", dMax);
	Dialog.show();
	
	minSize=Dialog.getNumber();
	chNuclei=Dialog.getNumber();
	chSgl=Dialog.getNumber();
	dMax=Dialog.getNumber();
}

//-------------------------------------------------------------------------------
//Identifier tous les noyaux puis créer l'image dépliée pour tous
function unwrapAllNuclei(img, minSize, chNuclei, chSgl, dMax){
	selectWindow(img);
	Stack.setChannel(chNuclei);
	
	detectNuclei(minSize);
	x=Table.getColumn("X");
	y=Table.getColumn("Y");
	
	for(i=0; i<x.length; i++){
		selectWindow(img);
		Stack.setChannel(chSgl);
		unwrapImage(img, x[i], y[i], dMax);
		rename("Nucleus_"+(i+1));
	}
	run("Images to Stack", "  title=Nucleus use");
}


//-------------------------------------------------------------------------------
//Identifier les noyaux individuels et en définir le centre
function detectNuclei(minSize){
	if(nImages==0){
		exit("Ouvrir une image avant de lancer la macro");
	}
	run("Duplicate...", "title=Noyaux");
	setAutoThreshold("Triangle dark");
	run("Set Measurements...", "centroid display redirect=None decimal=4");
	run("Analyze Particles...", "size="+minSize+"-Infinity display exclude clear");
}



//-------------------------------------------------------------------------------
//Pour un noyau, tracer des rayons partants du centre, vers la périphérie (distance à définir), à angle variable (de 0° à 360°, pas à définir).
function unwrapImage(img, xCent, yCent, dMax){
	setBatchMode(true);
	selectWindow(img);
	getPixelSize(unit, pixelWidth, pixelHeight);
	newImage("Out", "16-bit black", 360, dMax, 1);
	for(i=0; i<360; i++){
		selectWindow(img);
		x1=xCent/pixelWidth;
		y1=yCent/pixelHeight;
		x2=x1+dMax*cos(i/180*PI);
		y2=y1+dMax*sin(i/180*PI);
		makeLine(x1, y1, x2, y2);
		values=getProfile();
		selectWindow("Out");
		for(j=0; j<values.length; j++){
			setPixel(i, j, values[j]);
		}
	}
	resetMinAndMax;
	setBatchMode("exit and display");
}

//-------------------------------------------------------------------------------
//Crée la projection, releve les données et les tracer sur un graph
function analyzeAndPlot(){
	//Faire la projection
	selectWindow("Stack");
	run("Z Project...", "projection=[Average Intensity]");
	rename("Moyenne");
	
	//Extraire les données
	dist=newArray(getHeight());
	mean=newArray(getHeight());
	stdDev=newArray(getHeight());
	
	for(i=0; i<getHeight(); i++){
		makeLine(0, i, getWidth()-1, i);
		profil=getProfile();
		Array.getStatistics(profil, min, max, mean[i], stdDev[i]);
		dist[i]=i;
	}
	
	//Tracer les données
	Plot.create("Intensité moyenne vs distance au noyau", "Distance au noyau (pixels)", "Intensité moyenne (UA)", dist, mean);
	Plot.add("error bars", dist, stdDev);
	Plot.show();
}