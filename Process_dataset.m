
BV=normalise_dataset('./Patients/Patient_01/P1_MF1-BV.mat');


%%
% After choosing preferred frame by eye 
Chosen_frame= 2;
BV_real= BV(:,:,Chosen_frame);

% cleaning
load('../resources/Average_Healthy.mat', 'Ave') % loading a reference signal, an averaged data frame of 10 healthy subjects
Cleaned_real= BV_real;
prt= prt_full(keep_idx, :);
data_counter= 0; % removed data points counter
DP_removed= []; % removed data

for iFreq= 1: size(BV_real,2) % for each frequency (17)
    for comb= 1: size(BV_real)
        if (abs(BV_real(comb, iFreq)) > (abs(Ave(comb, iFreq)) + 20)) % cleaning criteria 
            Cleaned_real(comb, iFreq)= NaN;
            data_counter= data_counter+1; 
            DP_removed(data_counter, 1:3)= prt(comb,1:3);
            DP_removed(data_counter, 4)= iFreq;
        end
    end
end

% save('P8Ar1.mat', 'Real', 'Cleaned_real', 'DP_removed');