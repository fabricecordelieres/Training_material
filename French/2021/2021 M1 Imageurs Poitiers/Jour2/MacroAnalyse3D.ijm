//Nom de l'image d'origine
img=getTitle();

//Collecter les dimensions de l'image
Stack.getDimensions(width, height, channels, slices, frames);

//Séparer les canaux
run("Split Channels");

//Pour tous les canaux
for(j=1; j<=channels; j++){
	//Sélectionner le j-ème canal
	selectWindow("C"+j+"-"+img);
		
	//Pour toutes les ROIs
	for(i=0; i<roiManager("Count"); i++){

		//Sélectionner la i-ème ROIs
		roiManager("Select", i);
	
		//Extraire les stats
		Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	
		//Pousser les données vers un tableau
		//voxelCount
		setResult("voxelCount", nResults, voxelCount);
		//mean
		setResult("mean", nResults-1, mean);
		//min
		//max
		//stdDev
		//Ch
	}
}	
	