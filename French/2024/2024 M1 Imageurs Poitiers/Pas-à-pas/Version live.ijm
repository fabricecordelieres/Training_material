close("\\Others");
 
 
Dialog.create("Mon nom est GUI");
Dialog.addMessage("Premier canal à analyser");
Dialog.addSlider("Premier canal", 1, 4, 1);
Dialog.addNumber("Median, premier canal", 2);
Dialog.addNumber("Bckgd, premier canal", 5);
Dialog.addNumber("Prominence, premier canal", 150);

Dialog.addMessage("Second canal à analyser");
Dialog.addSlider("Second canal", 1, 4, 2);
Dialog.addNumber("Median, second canal", 2);
Dialog.addNumber("Bckgd, second canal", 5);
Dialog.addNumber("Prominence, second canal", 150);

Dialog.addMessage("Rayons limites");
Dialog.addNumber("Coloc", 3);
Dialog.addNumber("Prox", 6);

Dialog.show();

C1=Dialog.getNumber();
med1=Dialog.getNumber();
bkgd1=Dialog.getNumber();
prom1=Dialog.getNumber();

C2=Dialog.getNumber();
med2=Dialog.getNumber();
bkgd2=Dialog.getNumber();
prom2=Dialog.getNumber();

coloc=Dialog.getNumber();
prox=Dialog.getNumber();
 
 prepareImage();
 selectWindow("C"+C1+"-Copie");
 analyzeImg(med1, bkgd1, prom1);
 selectWindow("C"+C2+"-Copie");
 analyzeImg(med2, bkgd2, prom2);
 
 
imgROI="C"+C1+"-Copie"; imgPts="C"+C2+"-Copie_detections";
 colocProx(imgROI, imgPts, coloc, prox);
 
 imgROI="C"+C2+"-Copie"; imgPts="C"+C1+"-Copie_detections";
 colocProx(imgROI, imgPts, coloc, prox);
 
 //---------------------------------------------------------
 function prepareImage(){
	 //demander à l'utilisateur de dessiner une ROI
	 run("Select None");
	 
	 while(selectionType()==-1){
	 	waitForUser("Dessiner une ROI\npuis cliquer sur Ok");
	 }
	 
	 //Créer une copie
	 run("Duplicate...", "title=Copie");
	 
	 //Séparer les canaux
	 run("Split Channels");
 }
 
 //---------------------------------------------------------
 function analyzeImg(medRad, subBkgd, prom){
	ori=getTitle();
	
	//Filtre médian
	run("Median...", "radius="+medRad);
	
	//Soustraction de fond
	run("Subtract Background...", "rolling="+subBkgd);
	
	//Détection et sortie 2: find maxima/Single points (image)
	run("Find Maxima...", "prominence="+prom+" output=[Single Points]");
	
	//Renommer l'image de sortie
	rename(ori+"_detections");
	
	//Revenir à l'image d'origine
	selectWindow(ori);
	
	//Détection et sortie 1: find maxima/Point selection (ROI)
	run("Find Maxima...", "prominence="+prom+" output=[Point Selection]");
}

//---------------------------------------------------------
 function colocProx(imgROI, imgPts, coloc, prox){
	//Activer l'image imgROI
	selectWindow(imgROI);
	
	//A partir la ROI, obtenir les coordonnées de chaque point
	getSelectionCoordinates(xpoints, ypoints);
	
	//Création du tableau de résultats
	Table.create("ROI_"+imgROI+"-Detec_"+imgPts);
	
	
	accumColoc=0;
	accumProx=0;
	
	//Pour chaque point, faire:
	for(i=0; i<xpoints.length; i++){
		//Activer l'image imgPts
		selectWindow(imgPts);
		
		//Placer une région circulaire de rayon coloc
		makeOval(xpoints[i]-coloc, ypoints[i]-coloc, 2*coloc+1, 2*coloc+1);
		
		//Rappatrier les statistiques (brutes) de la région (intensité totale)
		getRawStatistics(nPixels, mean, min, max, std, histogram);
		
		//Convertir l'intensité totale en nombre de points
		nColoc=mean*nPixels/255;
		accumColoc=accumColoc+nColoc;
		
		//Placer une région circulaire de rayon prox
		makeOval(xpoints[i]-prox, ypoints[i]-prox, 2*prox+1, 2*prox+1);
		
		//Rappatrier les statistiques (brutes) de la région (intensité totale)
		getRawStatistics(nPixels, mean, min, max, std, histogram);
		
		//Convertir l'intensité totale en nombre de points
		nProx=mean*nPixels/255;
		accumProx=accumProx+nProx;
		
		//Logger les résultats
		selectWindow("ROI_"+imgROI+"-Detec_"+imgPts);
		Table.set("Label", i, "Spot_"+(i+1));
		Table.set("nb_Coloc", i, nColoc);
		Table.set("nb_Prox", i, nProx);
		Table.update;
	}
	
	print("---------------------------");
	print("ROI_"+imgROI+"-Detec_"+imgPts);
	print("Nb spots: "+xpoints.length);
	print("Nb spots coloc: "+accumColoc);
	print("Nb spots prox: "+accumProx);
	print("---------------------------");
}
 
 
 
 
 
 
 //Segmenter/résumer les objets sous forme de points
 
 //Récupérer les localisations
 
 //Définir les zones de coloc/prox
 
 //Dénombrer
 
 