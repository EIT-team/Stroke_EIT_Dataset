function [EEG] = Extract_EEG(IN)
% Extract EEG signals from start and end of EIT datasets which are
% uncontaminated with EIT injections. 
%
% Data on all channels are loaded and subequently bandpass filtered with a
% cut off 2 - 200, and a 50 Hz notch
%
% Inputs:
% IN - either a filename of a .bdf file, or a HDR structure
%
% Outputs:
% EEG - structure with the following fields:
% EEG.data_start - data at the beginning of file
% EEG.data_end - data at end of file
% EEG.t_start - time vector for start data
% EEG.t_end - time vector for end data
% EEG.fs - sampling rate


%% check input
if exist('IN','var') == 0 || isempty(IN)
    HDR=ScouseTom_getHDR();
else
    % load the HDR for the filename given
    if ischar(IN)
        HDR =ScouseTom_getHDR(IN);
    elseif isstruct(IN) %if structure then the HDR has been given
        HDR=IN;
    end
end

%% find the locations of the trigger pulses
Trigger= ScouseTom_TrigReadChn(HDR);
TT= ScouseTom_TrigProcess(Trigger, HDR);
Fs= HDR.SampleRate;

%% read the data at the start and finish of the file
% Needs to be integer value, so round up
EIT_Start = ceil( TT.InjectionStarts/Fs);
EIT_End = floor( TT.InjectionStops/Fs);

EEG_start = sread(HDR,EIT_Start,0);
EEG_end  = sread(HDR,HDR.NRec-EIT_End,EIT_End);
%% take only the chunks we want
EEG_start = EEG_start(1:(TT.InjectionStarts-10),:);
EEG_end = EEG_end((TT.InjectionStops+100)-EIT_End*Fs:end,:);

%% filter and plot

% band pass filter
[b,a] = butter(2, [2 200]./(Fs/2));

%notch filter
d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',49,'HalfPowerFrequency2',51, ...
               'DesignMethod','butter','SampleRate',Fs);

EEG_start = filtfilt(b,a, EEG_start);
EEG_end = filtfilt(b,a, EEG_end);

EEG_start = filtfilt(d, EEG_start);
EEG_end = filtfilt(d, EEG_end);

%% Store in Struct at end
EEG.data_start = EEG_start;
EEG.data_end = EEG_end;
EEG.fs = Fs;
EEG.t_start=(0:length(EEG.data_start)-1)./Fs;
EEG.t_end=(0:length(EEG.data_end)-1)./Fs;

end
