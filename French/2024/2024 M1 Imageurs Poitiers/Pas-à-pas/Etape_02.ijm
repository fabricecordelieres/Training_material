waitForUser("Sélectionner un plan, dessiner la ROI puis cliquer sur Ok");
roiManager("Add");
run("Duplicate...", "title=Slice");
run("Split Channels");