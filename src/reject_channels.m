function [ BV_cleaned, idx_removed ] = reject_channels( BVin )
% [ BV_cleaned, Chn_removed  ] = reject_channels( BVin )
% REJECT_CHANNELS sets channels to nan based on chosen criteria. Currently
% a deviation more than 20mV from a notional good baseline is used.
% Input - voltages, the output from normalise_dataset
% Outputs: 
% BV_cleaned - The voltages with nans replacing rejected measurements
% idx_removed - cell array of measurements removed per frame

%%
% get the reference dataset used to reject bad channels
load([mfilename('fullpath') '\..\..\resources\Average_Healthy.mat']);

BV_cleaned= BVin;
idx_removed=cell(size(BVin,3),1);
numremoved=nan(size(BVin,3),1);

for iRep = 1:size(BVin,3)
    for iFreq= 1: size(BVin,2) % for each frequency (17)
        for comb= 1: size(BVin,1)
            if (abs(BVin(comb, iFreq,iRep)) > (abs(Chn_ave(comb, iFreq)) + 20)) % cleaning criteria
                BV_cleaned(comb, iFreq, iRep)= nan;
            end
        end
    end
    
    cur_idx_removed=(find(((any(isnan(BV_cleaned(:,:,iRep)),2)))));
    BV_cleaned(cur_idx_removed,:,iRep)=nan;
    idx_removed{iRep}=cur_idx_removed;
    
    numremoved(iRep)=size(cur_idx_removed,1);
end

% if any channels have nan at any frequency, then ignore this at all freqs

if size(BVin,3) > 1
    fprintf('%d to %d of %d measurements rejected\n',min(numremoved),max(numremoved),size(BVin,1))
else
    
fprintf('%d of %d measurements rejected\n',numremoved,size(BVin,1))
end

end

