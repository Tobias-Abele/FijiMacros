///// This macro can be used to manually align two images with each other
///// This macro has to be adapted accordiing to the file format used (here .czi)
///// I used this macro to align two stitched tile images taken at two different time points

/// First line, reference image
waitForUser("Please draw a line between two reference points in your reference image. Add it to the ROi manager (press 'T'). Press OK afterwards");
title1=getTitle();
dir1=getDirectory("image");
/// Second line, image to be rotated and shifted
waitForUser("Now, please select the second image and draw a line between the two reference points there. Add it to the ROi manager (press 'T'). Afterwards, press OK again");
title2=getTitle();
dir2=getDirectory("image");

/// Evaluation of the difference in rotation
roiManager("select", 0);
Roi.getCoordinates(xpoints, ypoints);
angle1 = Math.atan((ypoints[1]-ypoints[0])/(xpoints[1]-xpoints[0]));
roiManager("select", 1);
Roi.getCoordinates(xpoints2, ypoints2);
angle2 = Math.atan((ypoints2[1]-ypoints2[0])/(xpoints2[1]-xpoints2[0]));
angle=angle2-angle1;
degree = angle * 180/PI;
degree= -degree;

/// Correction of the rotation
run("Rotate... ", "angle="+degree+" grid=1 interpolation=None");

/// Third line, second image, to adjust x and y shift
waitForUser("Select the image to be modified and draw the line between your two reference points again. Add it to the ROi manager (press 'T'). Press OK afterwards");
roiManager("select", 2);
Roi.getCoordinates(xpoints2, ypoints2);
xdiff = -(xpoints2[0]-xpoints[0] + xpoints2[1]-xpoints[1])/2
ydiff = -(ypoints2[0]-ypoints[0] + ypoints2[1]-ypoints[1])/2
run("Translate...", "x="+xdiff+" y="+ydiff+" interpolation=None");

/// Save and close everything
selectWindow(title1);
saveAs("Tiff", dir1+replace(title1, ".czi", "")+".tif");
close();
selectWindow(title2);
saveAs("Tiff", dir2+replace(title2, ".czi", "")+"_corrected.tif");
close();
selectWindow("ROI Manager");
run("Close");


