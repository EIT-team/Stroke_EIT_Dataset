%% Create the representative dataset used in data rejection

% find files in the Patient directory
fld_subject = dir('..\Subjects\Subject*');

%take only the directories
fld_subject=fld_subject([fld_subject.isdir]);

%best 10 recordings - through observation of the SNR within recordings 
good_recs = {'01b','02a','03b','04a','05a','06a','07a','08a','09a','10a'};
good_frame=[3,2,2,2,2,2,2,2,1,1];

fld_subject=fld_subject(ismember({fld_subject.name}.',strcat('Subject_',good_recs)));

% number of folders to process
fnum_subject = size(fld_subject,1);

%process all data in each folder, catching errors as we go
for iSubject = 1:fnum_subject
    try
        dirname=dir([fld_subject(iSubject).folder filesep fld_subject(iSubject).name filesep '*MF*-BV.mat']);
        BVcur=normalise_dataset([dirname.folder filesep dirname.name]);
        
        if iSubject ==1
            BVtotal=nan(size(BVcur,1),size(BVcur,2),fnum_subject);
        end
        
        BVtotal(:,:,iSubject)=squeeze(BVcur(:,:,good_frame(iSubject)));
    catch err
        fprintf(2, '%s\n', getReport(err, 'extended'));
        fprintf(2, ' Error in processing file %s\n',fld_subject(iSubject).name);
    end
    
end

Chn_ave=mean(BVtotal,3);

save('Average_Healthy.mat','Chn_ave');
