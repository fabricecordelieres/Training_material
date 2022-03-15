getPctColoc();

//*************** CALCULER LE % DE COLOCALISATION ***************
function getPctColoc(){
	columns=split(Table.headings, "\t");
	for(i=0; i<columns.length; i++){
		if(indexOf(columns[i], "-")!=-1){
			//Extraire le type de ROI et les canaux
			roi=substring(columns[i], indexOf(columns[i], "_")+1);
			channels=replace(columns[i], "_"+roi, "");
			channelsArray=split(channels, "-");
			for(j=0; j<channelsArray.length; j++){
				Table.applyMacro("Coloc_"+replace(columns[i],"-", "_")+"_over_"+channelsArray[j]+"_"+roi+"="+replace(columns[i], "-", "_")+"/"+channelsArray[j]+"_"+roi+";");
			}
		}
	}
}