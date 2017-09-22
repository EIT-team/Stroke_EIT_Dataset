




% load the data extracted from the patient summary
load('PatientSubjectInfo');
%% Process the Subject data
SubjectsNum=length(SubjectInfo.StudyID);
for iRec = 1:SubjectsNum
    % load the data for this subject - accounting for the fact the
    % filenames could be MF1 or MF2
    dirname=dir([ '..' filesep 'Subjects' filesep SubjectInfo.name{iRec} filesep '*MF*-BV.mat']);
    [BV, BVstruct]=normalise_dataset([dirname.folder filesep dirname.name]); 
    % reject bad channels in this dataset
    [BV_cleaned, chn_removed] = reject_channels( BV(:,:,SubjectInfo.frame_chosen(iRec)));
    
    % Add the other data too
    EITDATA(iRec).NameTag=SubjectInfo.name(iRec);
    EITDATA(iRec).Classification=SubjectInfo.classification(iRec);
    EITDATA(iRec).VoltagesCleaned=BV_cleaned;
    EITDATA(iRec).VoltagesFull=BV(:,:,SubjectInfo.frame_chosen(iRec));
    EITDATA(iRec).RemovedChannels=chn_removed;
    EITDATA(iRec).Diagnosis=SubjectInfo.classification(iRec);
    EITDATA(iRec).StudyID=SubjectInfo.StudyID(iRec);
    EITDATA(iRec).Comments=SubjectInfo.comments(iRec);
    
end

% Patients_chosen=[6;9;11;12;15;16;17;18;19;20;23;24;25;26];
%% Process the patient data
PatientsNum=size(PatientInfo.StudyID,2);


for iRec = 1:PatientsNum
    % load the data for this subject - accounting for the fact the
    % filenames could be MF1 or MF2
    dirname=dir([ '..' filesep 'Patients' filesep PatientInfo.name{iRec} filesep '*MF*-BV.mat']);
    [BV, BVstruct]=normalise_dataset([dirname.folder filesep dirname.name]); 
    % reject bad channels in this dataset
    [BV_cleaned, chn_removed] = reject_channels( BV(:,:,PatientInfo.frame_chosen(iRec)));
    
    
    % Add the other data too
    EITDATA(iRec+SubjectsNum).NameTag=PatientInfo.name(iRec);
    EITDATA(iRec+SubjectsNum).Classification=PatientInfo.classification(iRec);
    EITDATA(iRec+SubjectsNum).SubClassification=PatientInfo.subclassification(iRec);
    EITDATA(iRec+SubjectsNum).VoltagesCleaned=BV_cleaned;
    EITDATA(iRec+SubjectsNum).VoltagesFull=BV(:,:,PatientInfo.frame_chosen(iRec));
    EITDATA(iRec+SubjectsNum).RemovedChannels=chn_removed;
    EITDATA(iRec+SubjectsNum).Diagnosis=PatientInfo.diagnosis(iRec);
    EITDATA(iRec+SubjectsNum).StudyID=PatientInfo.StudyID(iRec);
    EITDATA(iRec+SubjectsNum).Comments=PatientInfo.comments(iRec);
    
end

%% save some relevant EIT settings

EITSETTINGS.Freq = BVstruct.ExpSetup.Freq;
EITSETTINGS.protocol= BVstruct.prt_full(BVstruct.keep_idx,:);

save('../Stroke_EIT_Data','EITDATA','EITSETTINGS');

