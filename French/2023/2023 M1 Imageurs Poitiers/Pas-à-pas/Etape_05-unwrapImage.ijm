img="CFBE WT H TRPA1 ZO1 x60.oir";
xCent=75; //Attention: coordonnée exprimée en unités de distance !
yCent=55; //Attention: coordonnée exprimée en unités de distance !
dMax=75;


unwrapImage(img, xCent, yCent, dMax);


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