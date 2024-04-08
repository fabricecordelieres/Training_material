prepareImages();
preprocessImage("C2-Slice", median1, bkgd1, prominence1);
preprocessImage("C3-Slice", median2, bkgd2, prominence2);


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