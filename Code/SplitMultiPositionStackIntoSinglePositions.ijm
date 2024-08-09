///// This macro can be used for splitting multi-position microscopy stacks into
///// single positions. Single positions are being loaded and saved seperately.

///// IT IS NECCESSARY TO KNOW THE NUMBER OF POSITIONS BEFORE RUNNING THE MACRO


///// Change the number of positions of your multi-position image /////
positions = 18

path = File.openDialog("Select a File");
for (i = 1; i < positions+1; i++) {
	run("Bio-Formats", "open="+path+" color_mode=Colorized rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_"+i);
///// Change .czi in the enxt line according to the file format you are using /////
	saveAs("Tiff", replace(path, ".czi", "_Scene"+i+".tif"));
	close();
}