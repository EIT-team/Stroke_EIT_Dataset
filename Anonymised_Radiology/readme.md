# Radiology Data and Clinical Reports

## Usage

Extract all archives `Patient_Reports_01.zip,  Patient_Reports_02.zip ...Patient_Reports_26.zip` from [10.5281/zenodo.838705](10.5281/zenodo.838705) into this directory so the structure is:

```
|---P_01
|   |---20160504 192137 [ - CT Acute Stroke]
|   |   |---Series 001 [CT - 2 0]
|   |   |---Series 003 [CT - Thick Brain 5 0 Head Brain FC21]
|   |   |...
|   |---20160505 102132 [ - MR Head]
|   |   |---Series 201 [MR - DTI P6d noniso]
|   |   |---Series 202 [MR - isoDWI b1000 iso]
|   |   |...
|   |---Patient01.pdf
|---P_03
|   |---20160510 152102 [ - CT Acute Stroke]
|   |   |---Series 001 [CT - 2 0]
|   |   |---Series 003 [CT - Thick Brain 5 0 Head Brain FC21]
|   |   |...
|   |---20160511 090538 [ - MR Head]
|   |   |---Series 201 [MR - DTI P6d noniso]
|   |   |---Series 202 [MR - isoDWI b1000 iso]
|   |   |...
|   |---Patient03.pdf
...
```

Inside each folder is a `.pdf` containing the radiologists report. Along with the CT and MRI scans in DICOM format. 
