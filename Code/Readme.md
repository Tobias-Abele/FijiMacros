In this folder, all files can be found.

# A) PeripheralIntensityDetermination_TimeSeries_Simplified.ijm
This macro can be used to quantify the peripheral fluorescence intensity of vesicles over time, originally used with single microscopy stacks in .czi format.
This macro 
  1. segments vesicles and 
  2. draws line orthogonally to the detected rings and 
  3. averages the detected maximum of these lines as a value for the membrane fluorescence intensity, 
  4. stores them in a table (Maxi), together with their standard deviation per vesicle (MaxStd), the frame number and the position, before
  5. saving the image as a tif file, the ROi set and the results in .csv format

B) RotateAndTranslateImage.ijm
This macro can be used to manually align two images with each other, originally used with two .czi files
Example of usage: Align two stitched tile images taken at two different time points, afterwards manual stacking of both images and saving the new stack

C) SplitMultiPositionStackIntoSinglePositions.ijm
This macro can be used for splitting multi-position microscopy stacks into single positions, that are being being loaded and saved seperately.
This requires to to know the number of positions before running the script.
Example of usage: Splitting multi-position experiment files that are too large to handle for the computer all at once.