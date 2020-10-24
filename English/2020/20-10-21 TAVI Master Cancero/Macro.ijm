open("/Users/fab/Desktop/TP_MIH_IF/ALMI/ATRA DAPI x20.tif");
rename("DAPI");
open("/Users/fab/Desktop/TP_MIH_IF/ALMI/ATRA Ki67 x20.tif");
rename("Ki67");
open("/Users/fab/Desktop/TP_MIH_IF/ALMI/ATRA P16 x20.tif");
rename("p16");
selectWindow("DAPI");
run("8-bit");
selectWindow("Ki67");
run("8-bit");
selectWindow("p16");
run("8-bit");
selectWindow("DAPI");
run("Enhance Contrast", "saturated=0.35");
selectWindow("Ki67");
run("Enhance Contrast", "saturated=0.35");
selectWindow("p16");
run("Enhance Contrast", "saturated=0.35");
run("Merge Channels...", "c1=p16 c2=Ki67 c3=DAPI create");
setSlice(3);
selectWindow("Composite");
run("Duplicate...", "title=DAPI_Mask duplicate channels=3");
run("Median...", "radius=7");
setAutoThreshold("Triangle dark");
//run("Threshold...");
//setThreshold(73, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Fill Holes");
run("Watershed");
run("Analyze Particles...", "size=1500-Infinity show=Nothing exclude add");
close();
selectWindow("Composite");
setSlice(1);
roiManager("Deselect");
roiManager("Measure");
run("Distribution...", "parameter=Mean automatic");
Table.rename("Results", "Channel1");
selectWindow("Composite");
setSlice(2);
roiManager("Deselect");
roiManager("Measure");
run("Distribution...", "parameter=Mean automatic");
Table.rename("Results", "Channel2");