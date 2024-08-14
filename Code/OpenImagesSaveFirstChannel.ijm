n=nImages
for (i = 0; i < n; i++) {
	dir=getDirectory("image");
	title=getTitle();
	run("Split Channels");
	selectWindow("C1-"+title);
	saveAs("Tiff", dir+replace(title,".tif","_Red.tif"));
	close();
	selectWindow("C2-"+title);
	close();
	selectWindow("C3-"+title);
	close();
}




