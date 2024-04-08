prepareImages();
preprocessImage("C2-Slice", median1, bkgd1, prominence1);
preprocessImage("C3-Slice", median2, bkgd2, prominence2);
colocProx(1, "C3-Slice-points", coloc, prox);
colocProx(2, "C2-Slice-points", coloc, prox);


//----------------------------------------------------------------------------
function prepareImages(){
	run("Select None");
	while(selectionType==-1){
		waitForUser("Sélectionner un plan, dessiner la ROI puis cliquer sur Ok");
	}
	roiManager("Add");
	run("Duplicate...", "title=Slice");
	run("Split Channels");
}

//----------------------------------------------------------------------------
function preprocessImage(image, median, bkgd, prominence){
	selectImage(image);
	run("Duplicate...", "title="+image+"-Processed");
	run("Median...", "radius="+median);
	run("Subtract Background...", "rolling="+bkgd);
	roiManager("Select", 0);
	run("Find Maxima...", "prominence="+prominence+" output=[Single Points]");
	rename(image+"-points");
	selectImage(image+"-Processed");
	run("Find Maxima...", "prominence="+prominence+" output=[Point Selection]");
	roiManager("Add");
}

//----------------------------------------------------------------------------
function colocProx(roiNb, image, coloc, prox){
	Table.create("Roi_"+roiNb+"-Image_"+image);
	selectWindow(image);
	run("Remove Overlay");
	
	getPixelSize(unit, pixelWidth, pixelHeight);
	colocPix=coloc/pixelWidth;
	proxPix=prox/pixelWidth;
	
	roiManager("Select", roiNb);
	Roi.getCoordinates(xpoints, ypoints);
	for(i=0; i<xpoints.length; i++){
		makeOval(xpoints[i]-colocPix, ypoints[i]-colocPix, 2*colocPix+1, 2*colocPix+1);
		Roi.setStrokeColor("Green");
		run("Add Selection...");
		getRawStatistics(nPixels, mean, min, max, std, histogram);
		nbColoc=nPixels*mean/255;
		
		makeOval(xpoints[i]-proxPix, ypoints[i]-proxPix, 2*proxPix+1, 2*proxPix+1);
		Roi.setStrokeColor("Red");
		run("Add Selection...");
		getRawStatistics(nPixels, mean, min, max, std, histogram);
		nbProx=floor(nPixels*mean/255-nbColoc);
		
		Table.set("Label", i, "Spot_"+(i+1));
		Table.set("X", i, xpoints[i]);
		Table.set("Y", i, ypoints[i]);
		Table.set("Coloc_"+coloc, i, nbColoc);
		Table.set("Prox_"+prox, i, nbProx);
		Table.update;
	}
	run("Select None");
}