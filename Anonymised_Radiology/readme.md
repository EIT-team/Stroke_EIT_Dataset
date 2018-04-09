# Radiology Data and Clinical Reports

## Usage

Extract all archives `Patient_Reports_01.zip,  Patient_Reports_02.zip ...Patient_Reports_26.zip` from [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1215676.svg)](https://doi.org/10.5281/zenodo.1215676) into this directory so the structure is:

```
|---pat-01
|   |---func
|   |   |---pat-01_CT_Plain_Brain_Stroke.json
|   |   |---pat-01_CT_Plain_Brain_Stroke.nii.gz
|   |   |...
|   |---Patient01.pdf
|---pat-03
|   |---func
|   |   |---pat-03_CT_Plain_Brain_(Stroke).json
|   |   |---pat-03_CT_Plain_Brain_(Stroke).nii.gz
|   |   |...
|   |---Patient03.pdf
...
```

Inside each folder is a `.pdf` containing the radiologists report. Along with the CT and MRI scans in DICOM format.
