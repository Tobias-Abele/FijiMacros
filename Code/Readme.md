In this folder, all Fiji macro files in _.ijm_ format can be found.

### A) PeripheralIntensityDetermination_TimeSeries_Simplified.ijm
This macro can be used to quantify the peripheral fluorescence intensity of vesicles over time, originally used with single microscopy stacks in _.czi_ format.
This macro 
  1. segments vesicles and 
  2. draws line orthogonally to the detected rings and 
  3. averages the detected maximum of these lines as a value for the membrane fluorescence intensity, 
  4. stores them in a table (Maxi), together with their standard deviation per vesicle (MaxStd), the frame number and the position, before
  5. saving the image as a tif file, the ROi set and the results in _.csv_ format

### B) RotateAndTranslateImage.ijm
This macro can be used to manually align two images with each other, originally used with two _.czi_ files
Example of usage: Align two stitched tile images taken at two different time points, afterwards manual stacking of both images and saving the new stack

### C) SplitMultiPositionStackIntoSinglePositions.ijm
This macro can be used for splitting multi-position microscopy stacks into single positions, that are being being loaded and saved seperately.
This requires to to know the number of positions before running the script.
Example of usage: Splitting multi-position experiment files that are too large to handle for the computer all at once.

### D) OpenImagesSaveFirstChannel.ijm
This macro can be used to save a desired channel (e.g., the first one) of a microscopy stack for all open images.
This requries a .tif file in the beginning..
Example of usage: Open all your stacks of an experiment and save only the first channel for each of them.
