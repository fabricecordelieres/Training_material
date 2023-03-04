minSize=50;


//Identifier les noyaux individuels et en définir le centre
if(nImages==0){
	exit("Ouvrir une image avant de lancer la macro");
}
run("Duplicate...", "title=Noyaux");
setAutoThreshold("Triangle dark");
run("Set Measurements...", "centroid display redirect=None decimal=4");
run("Analyze Particles...", "size="+minSize+"-Infinity display exclude clear");