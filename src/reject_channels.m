function [ BV_cleaned  ] = reject_channels( BVin )
% [ BV_cleaned, Chn_removed  ] = reject_channels( BVin )
% REJECT_CHANNELS sets channels to nan based on chosen criteria. Currently
% a deviation more than 20mV from a notional good baseline is used. 

% get the reference dataset used to reject bad channels
load([mfilename('fullpath') '\..\..\resources\Average_Healthy.mat']);

BV_cleaned= BVin;

for iFreq= 1: size(BVin,2) % for each frequency (17)
    for comb= 1: size(BVin)
        if (abs(BVin(comb, iFreq)) > (abs(Chn_ave(comb, iFreq)) + 20)) % cleaning criteria 
            BV_cleaned(comb, iFreq)= nan;
            data_counter= data_counter+1; 
        end
    end
end

% if any channels have nan at any frequency, then ignore this at all freqs
BV_cleaned(any(isnan(BV_cleaned),2),:)=nan;

end

