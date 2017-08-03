fld = dir('Patients\Patient*');

% delete ones already done
% fld(1:11)=[];

fnum = size(fld,1);

for iFld = 1:fnum
    try
        ScouseTom_ProcessBatch(fld(iFld).name)
    catch err
        fprintf(2, '%s\n', getReport(err, 'extended'));
        fprintf(2, ' Error in processing folder %s\n',fld(iFld).name);
        
    end
    
end
