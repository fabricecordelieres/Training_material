minSize=50;
channel=2;
dMax=150;




img=getTitle();
unwrapAllNuclei(img, minSize, channel, dMax);

//-------------------------------------------------------------------------------
//Identifier tous les noyaux puis créer l'image dépliée pour tous
function unwrapAllNuclei(img, minSize, channel, dMax){
	selectWindow(img);
	detectNuclei(minSize);
	x=Table.getColumn("X");
	y=Table.getColumn("Y");
	
	for(i=0; i<x.length; i++){
		selectWindow(img);
		Stack.setChannel(channel);
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