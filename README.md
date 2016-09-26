
-------------------------------------------------------------------------------
### **FastFUCCI-cellcycle (draft version)**
Set of macros to quantify FastFUCCI cell cycle distribution with ImageJ/Fiji and Columbus(TM) software (Perkin Elmer).
Codes are in the order of use. Further details included in macros and in original publication XX.

1. ImageJ/Fiji macro for **image processing**. Initial data should be multichannel timelapse for individual stage positions. First channel has to be green, second one red. Other channels are not taken in account.

2. ImageJ/Fiji macro for **image formatting**. Mainly merging green and red channels in an extra one. Combines all channels in one TIFF file.

3. Columbus(TM) **analysis script**. First channel is red-green merge, second one is green, third is red (output of previous macro). Once uploaded in Columbus "image analysis" mode, check that each step is well suited to your dataset, especially intensity thresholds. Gaussian filtering at the beginning is optional.
