
BV=normalise_dataset('./Patients/Patient_11/P11_MF1-BV.mat');


%%
% After choosing preferred frame by eye 
Chosen_frame= 2;
[ BV_cleaned, Chn_removed  ] = reject_channels( BV(:,:,Chosen_frame));

