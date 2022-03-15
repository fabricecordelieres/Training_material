prepareData(5);
combineMasks();



//*************** CREER LES MASQUES BINAIRES ***************
function prepareData(subBkgdRad){
	roiManager("Reset");
	run("To ROI Manager");
	ori=getTitle();
	run("Split Channels");
	
	row=nResults;
	for(i=2; i<=4; i++){
		selectWindow("C"+i+"-"+ori);
		run("Subtract Background...", "rolling="+subBkgdRad);
		roiManager("Select", 2);
		setAutoThreshold("Li dark");
		setOption("BlackBackground", false);
		run("Convert to Mask");
		rename("C"+i);
		setResult("Label", row, ori);
		measureInROIS(row);
	}
	run("Tile");
}

//*************** COMBINER LES MASQUES ***************
function combineMasks(){
	row=nResults;
	//Combinaison "intelligente" des masques 2 à 2
	for(i=2; i<=4; i++){
		for(j=i+1; j<=4; j++){
			imageCalculator("AND create", "C"+i,"C"+j);
			rename("C"+i+"-C"+j);
			measureInROIS(row-1);
		}
	}

	//La triple combinaison est effectuée indépendamment
	imageCalculator("AND create", "C2-C3","C4");
	rename("C2-C3-C4");
	measureInROIS(row-1);
	run("Tile");
}

//*************** MESURER DANS TOUTES LES ROIS ***************
function measureInROIS(row){
	for(i=0; i<roiManager("Count"); i++){
		roiManager("Select", i);
		roiName=Roi.getName;
		img=getTitle();
		setAutoThreshold("Default");
		List.setMeasurements("limit");
		area=List.getValue("Area");
		resetThreshold();
		setResult(img+"_"+roiName, row, area);
		run("Select None");
	}
}
