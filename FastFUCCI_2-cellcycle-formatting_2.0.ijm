// Written by Patrice Mascalchi, June 2016, CRUK Cambridge Institute - Bordeaux Imaging Center, University of Bordeaux
// Macro to format timelapse images in a 3-channel one
// IMPORTANT: to be run after FastFUCCI-processing macro

// Parameters to be modified by user
mainpath = "E:\\Siang\\Exp59\\";		// directly containing images
// --------------------------------------------------------------------------------------------------------------

outG = mainpath + "green\\";
outR = mainpath + "red\\";
outCC = mainpath + "cell-cycle\\";
if (!File.exists(outCC)) File.makeDirectory(outCC);

setBatchMode(true);

flist = SortFileList(mainpath, "_green.tif");

for (f = 0; f < flist.length; f++) {
		Gn = flist[f];
		open(outG + Gn);
		run("Make Substack...", "slices=1-" + nSlices + "-4");
		t = getTitle();
		close(Gn);
		selectWindow(t);
		rename(Gn);
		run("8-bit");
		
		Rn = replace(Gn, "_green.tif", "_red.tif");
		open(outR + Rn);
		run("Make Substack...", "slices=1-" + nSlices + "-4");
		t = getTitle();
		close(Rn);
		selectWindow(t);
		nSl = nSlices;
		rename(Rn);
		run("8-bit");
		
		run("Concatenate...", "  title=for-rgb keep image1="+Gn+" image2="+Rn+" image3=[-- None --]");
		run("Stack to Hyperstack...", "order=xytcz channels=2 slices=1 frames=" + nSl + " display=Composite");
		run("Stack to RGB", "frames");
		run("8-bit");
		
		run("Concatenate...", "  title=final image1=for-rgb image2="+Gn+" image3="+Rn+" image4=[-- None --]");
		run("Stack to Hyperstack...", "order=xytcz channels=3 slices=1 frames=" + nSl + " display=Composite");
		
		saveAs("Tiff", outCC + replace(Gn, "_green.tif", ".tif");
		run("Close All");

}

setBatchMode(false);
waitForUser("done!");

// ------------------------------------------------------------------------------------------
// --------------------------- functions ----------------------------------------------------

function SortFileList(path, filter) {		// Sort with endsWith
	flist = getFileList(path);
	OutAr = newArray(flist.length);
	ind = 0;
	for (f=0; f<flist.length; f++) {
		//print(flist[f] + " : "+endsWith(flist[f], filter));
		if (endsWith(flist[f], filter)) {
			OutAr[ind] = flist[f];
			ind++;
		}
	}
	return Array.trim(OutAr, ind);
}
