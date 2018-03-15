# UCLH EIT Dataset - Patients

Extract all archives `Patient_01.zip,  Patient_02.zip ...Patient_26.zip` from [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1199529.svg)](https://doi.org/10.5281/zenodo.1199529)
 and [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1199630.svg)](https://doi.org/10.5281/zenodo.1199630) into this directory so the structure is:
```
|---Patient_01
|   |---P1_MF1.bdf
|   |---P1_TD1.bdf
|   |---P1_Z1.bdf
|   |---P1_Z2.bdf
|   |---P1_Z3.bdf
|---Patient_02
|   |---P2_MF1.bdf
|   |---P2_TD1.bdf
|   |---P2_Z1.bdf
|   |---P2_Z2.bdf
|   |---P2_Z3.bdf
|   |---P2_Z4.bdf
|---Patient_03
|   |---P3_MF1.bdf
|   |...
...
```

## Patient Categories


|    Data Tag     |    Stroke - EIT interval  |    Scans available (Time from stroke)                 |   Category and Main radiological findings  |
|-----------------|-------------------|----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    P1           |    24 hours       |    CT (12> hours)   MRI (24 hours)                 |    SMALL IS - Subacute infarct in left precentral gyrus and superior frontal gyrus (left MCA territory). Suspected   infarct in left insula. Two mature small infarcts in left cerebellum.    |
|    P2           |    17 days        |    -                                               |    *Other* – turned out to be not a new acute stroke but a previous infarct. Data quality was too poor to use                                                                               |
|    P3           |    27 hours       |    CT (12> hours)   MRI (24 hours)                 |    BIG ICH - Acute ICH centered onto left paracentral lobule, with surrounding oedema. Imaging suggests presence of an underlying lesion containing older blood product.                    |
|    P4A          |    18 hours       |    CT (2 hours)   CT (26 hours)                    |    BIG IS - Acute right MCA large territory infarct involving basal ganglia, insula, areas in temporal and frontal lobes.                                                                   |
|    P4B          |    42 hours       |                                                    |                                                                                                                                                                                                 |
|    P5           |    32 hours       |    CT (2 hours)   MRI (24> hours)                  |    SMALL ICH - Small acute ICH on lateral side of the left Thalamus. Mild surrounding oedema, no midline shift.                                                                            |
|    P6A          |    36-48 hours    |    CT (24 hours)   MRI (24 hours)   CT (8 days)    |    BIG ICH - ICH in right occipital lobe measuring approximately 2.3cm x 1.5 cm, with vasogenic oedema.                                                                                    |
|    P6B          |    25 days        |                                                    |                                                                                                                                                                                                 |
|    P7A          |    12 hours       |    -                                               |    *Other* – Patient with probably TIA and no stroke. Wrong electrode positioning, data was excluded.                                                                                        |
|    P7B          |    36 hours       |                                                    |                                                                                                                                                                                                 |
|    P8           |    -              |    -                                               |    *Other* – was not recorded as patient withdrawn due to epilepsy                                                                                                                              |
|    P9           |    2-3 days       |    CT (2> days)   MRI (3> days)                    |    BIG IS - Acute right MCA infarct involving anterior temporal lobe and insular cortex.                                                                                                      |
|    P10          |    3d             |    -                                               |    *Other* - Data quality was too poor to use                                                                                                                                                     |
|    P11          |    15 hours       |    CT (12> hours)                                  |    BIG ICH - Massive acute ICH involving most of the right frontal lobe, operculum, and postcentral gyrus. Significant midline shift. Previous multiple ICHs.                               |
|    P12A         |    8 hours        |    CT (3> hours)   CT (24 hours)                   |    SMALL IS - Small acute infarct in the left medial occipital lobe/                                                                                                                          |
|    P12B         |    24 hours       |                                                    |                                                                                                                                                                                                 |
|    P13          |    -              |    -                                               |    *Other* – Patient signed the consent form but was discharged before we could record                                                                                                          |
|    P14          |    6h             |    -                                               |    *Other* - Data quality was too poor to use                                                                                                                                                  |
|    P15          |    3 days         |    CT (12> hours)   MRI (2 days)                   |    BIG IS - Left parieto-occipital lobe acute/ subacute infarct. Multiple deep white matter lacunes. Microhaemorrhages scattered throughout the cerebrum and cerebellum                     |
|    P16          |    48 hours       |    CT (5 hours)   MRI (24 hours)                   |    SMALL IS - Right central gyrus and left posterior frontal lobe acute/ subacute infarct.                                                                                                    |
|    P17          |    21 hours       |    CT (2> hours)   MRI (4 days)                    |    SMALL ICH - Acute ICH in right thalamus and striato-capsular area approximately 2.5 X 1.9 in size. Scattered microhaemorrhages in midbrain and cerebellum.                               |
|    P18          |    3 days         |    CT (5 hours)   MRI (48 hours)                   |    SMALL IS - Acute infarct in left premotor cortex.                                                                                                                                          |
|    P19A         |    15 hours       |    CT (3> hours)   CT (20 hours)                   |    BIG IS - Acute large territory right MCA infarct, involving frontal, temporal, and parietal lobes, insula and basal ganglia.                                                             |
|    P19B         |    41 hours       |                                                    |                                                                                                                                                                                                 |
|    P20          |    3 days         |    MRI (2> days)   CT (8 months before stroke)     |    SMALL ICH - Acute left occipital ICH, and a few peripheral microhaemorrhages.                                                                                                              |
|    P21          |    3 days         |    -                                               |    *Other* – Right parieto-occipital infarct, data was excluded as patient had a right VP shunt.                                                                                                |
|    P22          |    -              |    -                                               |    *Other* – Patient changed his mind and withdrew after signing the consent form                                                                                                               |
|    P23A         |    > 2 days       |    CT (2> days)   MRI (3> days)                    |    BIG ICH - Large acute/ subacute right frontal ICH, with multiple microhaemorrhages scattered in both hemispheres.                                                                        |
|    P23B         |    > 6 days       |                                                    |                                                                                                                                                                                                 |
|    P24          |    27 hours       |    CT (2 hours)   MRI (24 hours)                   |    BIG ICH - Right acute lenticulostriate ICH, 3cm in AP diameter.                                                                                                                            |
|    P25A         |    12hours        |    CT (1 hour)   CT (25 hours)                     |    BIG IS - Large acute left MCA infarct involving parietal and frontal lobe. Small parietal haemorrhagic transformation is visible in second CT.                                           |
|    P25B         |    36 hours       |                                                    |                                                                                                                                                                                                 |
|    P26          |    3-5 days       |    CT (1-3 days)                                   |    BIG IS - Large acute/ subacute right MCA infarct. 3mm midline shift.                                                                                                                       |
