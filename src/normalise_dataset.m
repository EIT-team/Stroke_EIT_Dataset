function [ BV_corrected ] = normalise_dataset( IN )
%NORMALISE_DATASET Summary of this function goes here
%   Detailed explanation goes here


%% check input is path or structure

if ischar(IN)
    BVStruc =load(IN);
elseif isstruct(IN)
    BVStruc=IN;
end


%% Load important variables
Amplitudes = BVStruc.ExpSetup.Amp; % amplitude in uA
Freqs=BVStruc.ExpSetup.Freq; % freq in Hz
BV= BVStruc.BV; % boundary voltage magnitude
PhaseAngle=BVStruc.PhaseAngle; % phase angle in rad
keep_idx=BVStruc.keep_idx; % indicies of non injecting channels
repeats=BVStruc.ExpSetup.Repeats; % number of times protocol repeated

% looad biosemi gain
load([mfilename('fullpath') '\..\..\resources\BioSemi_correction.mat']);
%% Correct for

BV_corrected= NaN(size(keep_idx,2),size(BV,2),size(BV{1},2));

% selecting non-injecting channels, converting to mV, computing Real compnent,normalizing for I, correcting for biosemi gain
for iFrame= 1:repeats % for each frame (2-3)
    BV_frame= nan(size(keep_idx,2),size(BV,2));
    for iFreq= 1:size(BV,2) % for each frequency (17)
        
        if (size(BV{iFreq},2) >= iFrame) % only do this if there is data for this frame

            curFreq=Freqs(iFreq);
            curGain=BioSemi_correction_gain(BioSemi_correction_freq == curFreq);
            
            BV_frame(:,iFreq)= (BV{iFreq}(keep_idx,iFrame)./1000).*cos(PhaseAngle{iFreq}(keep_idx,iFrame)); %convert to real mV
            BV_frame(:,iFreq)= BV_frame(:,iFreq)/Amplitudes(iFreq)*max(Amplitudes); % adjust for different current amplitudes
            BV_frame(:,iFreq)= BV_frame(:,iFreq)*curGain; % adjust for biosemi gain
        end
    end
    
    BV_corrected(:,:,iFrame)= BV_frame;
end



end

