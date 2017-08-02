# UCLH Stroke EIT Dataset
This Multifrequency EIT data was collected as part of clinical trial in collaboration with the Hyper Acute Stroke unit (HASU) at University College London Hospital (UCLH).

An overview of this dataset along with a more detailed description of the data collection methodology is given in the accompanying publication [HERE BROKEN LINK](badbad)

## Processed dataset



All processing steps are covered in the _processing_ section below


### Using processed dataset

`UCL_EIT_Dataset.mat`

So for example, to plot the full spectrum data for patient 7: `plot(EIT(7).BV)`



## Raw data files
The raw `.bdf` files are available should you wish to recreate or alter the processing of this dataset. In total the dataset is **~150GB**, and is thus split into parts based on the Zenodo 50 GB file limit.  Please download the following zip files and extract them into the corresponding folders.

-   Subject data:  DOI [10.5281/zenodo.836842](10.5281/zenodo.836842)
-   Patient data (part 1): DOI [10.5281/zenodo.836842](10.5281/zenodo.836842)
-   Patient data (part 2): DOI [10.5281/zenodo.836842](10.5281/zenodo.836842)

Example structures for these directories are given in the readmes.

## Processing raw data
The data were collected using the [UCL ScouseTom System](https://github.com/EIT-team/ScouseTom). All processing code is located in the [Load_data repository](https://github.com/EIT-team/Load_data). Please ensure you follow the installation instructions there, and verify the example datasets load correctly.

### Demodulating

Individual files can be
