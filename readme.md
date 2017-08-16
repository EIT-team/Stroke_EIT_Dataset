# UCLH Stroke EIT Dataset
This Multifrequency Electrical Impedance Tomography (EIT) data was collected as part of clinical trial in collaboration with the Hyper Acute Stroke unit (HASU) at University College London Hospital (UCLH).

An overview of EIT along with a more detailed description of the data collection methodology and clinical context is given in the accompanying publication [HERE BROKEN LINK](badbad).

This repository contains the already processed data ready for analysis or use in imaging or classification studies, as well as the code to process all of the raw voltages.

## Processed dataset

All processing steps are covered in the _processing_ section below


### Using processed dataset

`UCL_EIT_Dataset.mat`

So for example, to plot the full spectrum data for patient 7: `plot(EIT(7).BV)`

## Raw data files
The raw `.bdf` files are available should you wish to recreate or alter the processing of this dataset. In total the dataset is **~150GB**, and is thus split into parts based on the Zenodo 50 GB file limit.  Please download the following zip files and extract them into the corresponding folders.

-   Subject data:  DOI [10.5281/zenodo.836842](10.5281/zenodo.836842) into the ./Subjects folder
-   Patient data (part 1): DOI [10.5281/zenodo.838176](10.5281/zenodo.838176) into the ./Patients folder
-   Patient data (part 2): DOI [10.5281/zenodo.838184](10.5281/zenodo.838184) into the ./Patients folder

Example structures for these directories are given in the readmes.

## Processing raw data
The data were collected using the [UCL ScouseTom System](https://github.com/EIT-team/ScouseTom). All processing code is written in Matlab and is located in the [Load_data repository](https://github.com/EIT-team/Load_data). Please ensure you follow the installation instructions there, and verify the example datasets load correctly.

The processing is done in two separate parts:
1. **Demodulation** - converting the "raw" sine waves into averaged impedance signals with magnitude and phase.
2. **Correction** and extraction of real component - these are the form necessary for reconstruction. Correction for the BioSemi gain and the changing injected current amplitude.


## Data types
For each subject and patient, there are three types of recordings:

1.  Full spectrum **"Multi-Frequency"** datasets. These have the `-MF` suffix, e.g. `S1a_MF1.bdf` or `P6-MF2.bdf`
2.  Reduced spectrum **"Time Difference"** datasets. These have the `-TD` suffix e.g. `S2b-TD1.bdf` or `P19-TD1.bdf`
3.  Contact impedance checks  or **"Z Checks"**, with the suffix `-Z` e.g. `S6-Z2.bdf` or `P11-Z4.bdf`.

#### 1. Multi-Frequency datasets

#### 2. Time Difference datasets

#### 3. Contact Impedance Checks
To estimate the contact impedance at the electrode sites, a separate measurement protocol was used. This injected between all adjacent pairs of electrodes, in the same manner as the UCH Mk.2.5 system used in previous stroke studies [10.1088/0967-3334/27/5/S13](10.1088/0967-3334/27/5/S13).

Unlike the other data types, there is no accompanying log files, as every file uses the same protocol, injecting between consecutive neighbouring pairs `1-2,2-3,3-4...32-1` with a current of 1 kHz and 141 uA amplitude. The results of this are used as an indicator of the quality of the electrode contact. These were run repeatedly during electrode application until the contact was satisfactory. The final Z check (with the highest number) is run _after_ all other data collection, to give an estimate of the drift in contact impedance during the recording.

These can be processed using the following:

`ScouseTom_LoadZ('./Patients/Patient_09/P9_Z1.bdf')`
This shows an initial contact impedance check where electrodes 3,4,8,9,26,29 were too high. Prompting a reabrasion of the electrode site.

![Zcheck1](https://raw.githubusercontent.com/EIT-team/Stroke_EIT_Dataset/master/example_figures/Zchk_1.png)

`ScouseTom_LoadZ('./Patients/Patient_09/P9_Z6.bdf')`
Shows the impedance at the end of the experiment where some have drifted over time, but none above the max Z level.

![Zcheck2](https://raw.githubusercontent.com/EIT-team/Stroke_EIT_Dataset/master/example_figures/Zchk_2.png)


### Demodulation
The `.bdf` files contain

Individual files can be demodulated like this
```
ScouseTom_LoadBV('./Subjects/Subject_01a/S1a_TD1.bdf')
```

or by calling `ScouseTom_LoadBV` without any arguments and selecting a file.

-----
All files for a given patient/subject can be processed using `ScouseTom_ProcessBatch` or `ScouseTom_ProcessBatch('./Subjects/Subject_01a')`

#### Batch Processing


#### Contact Impedance
