analyzeAndPlot();

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