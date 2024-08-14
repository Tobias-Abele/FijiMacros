///// Choose the channel that you want to save seperately
des_channel = 1;
///// Looping over all images, reading directory and title for saving
n=nImages;
for (i = 0; i < n; i++) {
	dir=getDirectory("image");
	title=getTitle();
	getDimensions(width, height, channels, slices, frames);
///// Separating channels
	run("Split Channels");
	selectWindow("C"+des_channel+"-"+title);
	saveAs("Tiff", dir+replace(title,".tif","_Red.tif"));
	close();
	for (j = 1; j < channels+1; j++) {
		if (j == des_channel) {
			continue;
		}
		selectWindow("C"+j+"-"+title);
		close();
	}
}