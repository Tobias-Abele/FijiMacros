///// This macro can be used to quantify the peripheral fluorescence intensity of vesicles over time
///// This macro only runs a single microscopy stack and was written for images in the zeiss .czi format
///// Change file endings, channels to be selected/deleted nad the number of drawn lines for quantifying the intensity according to your needs

///// This macro segments vesicles and draws line orthogonally to the detected rings and averages the detected maximum of these lines as a value for the membrane fluorescence intensity
///// This values are stored in a table (Maxi), together with their standard deviation per vesicle (MaxStd), the frame number and the position
///// In addition, the image is saved as a tif file, as well as the ROi set and the results in csv format



///// Change for different sizes and circularities of objects
minsize = 100.00;
mincircularity = 0.40;



run("Clear Results");
title=getTitle();
dir=getDirectory("image");
///// Change .czi to your preferred file format
saveAs("Tiff", dir+replace(title, ".czi", "")+".tif");
title=getTitle();
dir=getDirectory("image");

run("Split Channels");
///// Change the channel C1 to C2, C3,... to the channel based on which objects should be detected
selectWindow("C1-"+title);
run("Enhance Contrast", "saturated=0.35");
///// Change thresholding method according to your needs, e.g. Otsu instead of Triangle
setAutoThreshold("Triangle dark");
setOption("BlackBackground", true);
///// Change thresholding method according to your needs, e.g. Otsu instead of Triangle
run("Convert to Mask", "method=Triangle background=Dark calculate black");
///// Add filtering or different binary processing options according to your needs
run("Fill Holes", "stack");
run("Watershed", "stack");
run("Analyze Particles...", "size="+minsize+"-Infinity circularity="+mincircularity+"-1.00 exclude clear include add stack");
roiManager("Save", dir+replace(title, ".tif", "") + "ROI.zip" );
n = roiManager("count");
roiManager("deselect");
roiManager("delete");

///// Change the channels or close more channels according to how many channels your image has.
///// Keep the channel you want to quantify though ;)
selectWindow("C1-"+title);
close();
selectWindow("C3-"+title);
close();
run("Clear Results");
for (i = 0; i < n; i++) {
	roiManager("Open", dir+replace(title, ".tif", "") + "ROI.zip" );
///// Change channel accroding to your needs. Check whether you clsoed it by accident further up in the code
	selectWindow("C2-"+title);
    roiManager("select", i);
    selectWindow("C2-"+title);
    Stack.getPosition(channel, slice, frame);
	roiframe=frame;
	Roi.getBounds(x, y, width, height);
    middlex = x+width/2;
    middley = y+height/2;
    diameter = (width+height)/2;
    area = (diameter/2) * (diameter/2) * PI;

    roiManager("deselect");
    roiManager("delete");
    
///// The lines will be drawn now and their maximum averaged per ROI.
    lines = 20; // Number of lines to be drawn -> Mainly determines the execution time of the code
    maxivalues=newArray();
    for (p = 0; p < lines; p++) {
///// Change the line thickness according to your needs
        run("Line Width...", "line=6"); // A bigger line helps to get a better signal-to-noise ratio for the intensity profiles across the lines
        roiManager("show all with labels");
//// Change the start and end positions of the lines: Exchange 1.2 and 0.1 for other values..
        makeLine(middlex+1.2*0.5*diameter*cos(p/(lines*0.5)*PI), middley+1.2*0.5*diameter*sin(p/(lines*0.5)*PI), middlex+0.1*0.5*diameter*cos(p/(lines*0.5)*PI), middley+0.1*0.5*diameter*sin(p/(lines*0.5)*PI));
        roiManager("add");
        
        ypoints=getProfile();
        y1points=getProfile();
        xpoints=Array.getSequence(ypoints.length);
        Array.sort(y1points);
        Array.getStatistics(y1points, min, max, mean, stdDev);
        maxi=max;
        maxivalues=Array.concat(maxivalues,maxi);
    	};
    Array.getStatistics(maxivalues, min, max, mean, stdDev); // Averaging the maximum values per ROI -> 1 maximum value per ROI
    maximean1=mean;
    Array.getStatistics(maxivalues, min, max, mean, stdDev);
    maxistd1=stdDev;
	
	
	//setResult("Area", i, area);
    setResult("X", i, middlex);
    setResult("Y", i, middley);
    
    setResult("Maxi", i, maximean1);
    setResult("MaxStd", i, maxistd1);
    setResult("Frame", i, roiframe);
    updateResults();
	};

saveAs("Results", dir+replace(title, ".czi", "")+"_Results.csv");
updateResults();