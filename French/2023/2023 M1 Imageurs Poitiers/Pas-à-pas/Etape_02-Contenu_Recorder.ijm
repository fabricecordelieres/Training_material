open("/Users/fab/BIC Photonique Dropbox/Fabrice Cordelières/Data/02-Formations/2023 M1 Poitiers/CFBE WT H TRPA1 ZO1 x60.oir");
selectWindow("CFBE WT H TRPA1 ZO1 x60.oir");
run("Duplicate...", "title=Noyaux");
setAutoThreshold("Triangle dark");
run("Set Measurements...", "centroid display redirect=None decimal=4");
run("Analyze Particles...", "size=50.00-Infinity display exclude clear");