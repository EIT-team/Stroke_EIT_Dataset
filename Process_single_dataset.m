%% example processing of a single dataset

% the files have already been demodulated - using either ScouseTom_Load or
% by using Demodulate_all

% correct for different gain across voltage
[BV, BVstruct]=normalise_dataset('./Patients/Patient_11/P11_MF1-BV.mat');

%pick a single frame - normally the 2nd is preferred for the full spectrum
%MF datasets.
Chosen_frame= 2;
[ BV_cleaned, chn_removed] = reject_channels( BV(:,:,Chosen_frame));


%% plot comparison dataset

figure
plot(BVstruct.ExpSetup.Freq,BV_cleaned')
xlabel('Frequency (Hz)');
ylabel('Voltage mV');
title(['Cleaned voltages in file ' BVstruct.info.eegfname],'interpreter','none')

newylim=axis;
newylim=newylim(3:4); % make y axis the same

export_fig('./example_figures/MF_BV_cleaned.png','-r100');


figure
plot(BVstruct.ExpSetup.Freq,squeeze(BV(:,:,Chosen_frame))')
xlabel('Frequency (Hz)');
ylabel('Voltage mV');
title(['Raw voltages in file ' BVstruct.info.eegfname],'interpreter','none')

ylim([newylim(1) newylim(2)])

export_fig('./example_figures/MF_BV_raw.png','-r100');