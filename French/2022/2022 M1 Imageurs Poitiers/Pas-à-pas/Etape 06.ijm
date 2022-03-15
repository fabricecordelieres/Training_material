prepareData(5);

//*************** CREER LES MASQUES BINAIRES ***************
function prepareData(subBkgdRad){
	roiManager("Reset");
	run("To ROI Manager");
	ori=getTitle();
	run("Split Channels");
	
	for(i=2; i<=4; i++){
		selectWindow("C"+i+"-"+ori);
		run("Subtract Background...", "rolling="+subBkgdRad);
		roiManager("Select", 2);
		setAutoThreshold("Li dark");
		setOption("BlackBackground", false);
		run("Convert to Mask");
		rename("C"+i);
	}
	run("Tile");
}