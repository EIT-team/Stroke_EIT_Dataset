load('PatientSubjectInfo');

SubjectsNum=length(SubjectInfo.StudyID);


for iRec = 1:SubjectsNum
    % load the data for this subject - accounting for the fact the
    % filenames could be MF1 or MF2
    dirname=dir([ '..' filesep 'Subjects' filesep SubjectInfo.name{iRec} filesep '*MF*-BV.mat']);
    [BV, BVstruct]=normalise_dataset([dirname.folder filesep dirname]); 
    % reject bad channels in this dataset
    [BV_cleaned, chn_removed] = reject_channels( BV(:,:,SubjectInfo.frame_chosen(iRec)));
    
    % Add the other data too
    EITDATA(iRec).NameTag=SubjectInfo.name(iRec);
    EITDATA(iRec).Classification=SubjectInfo.classification(iRec);
    EITDATA(iRec).VoltagesCleaned=BV;
    EITDATA(iRec).VoltagesFull=BV_cleaned;
    EITDATA(iRec).RemovedChannels=chn_removed;
    EITDATA(iRec).Diagnosis=SubjectInfo.classification(iRec);
    EITDATA(iRec).StudyID=SubjectInfo.StudyID(iRec);
    EITDATA(iRec).Comments=SubjectInfo.comments;
    
end

% Patients_chosen=[6;9;11;12;15;16;17;18;19;20;23;24;25;26];

PatientsNum=size(PatientInfo.StudyID,2);


for iRec = 1:PatientsNum
    EITDATA(iRec+SubjectsNum).NameTag=PatientInfo.name(iRec);
    EITDATA(iRec+SubjectsNum).Classification=PatientInfo.classification(iRec);
    EITDATA(iRec+SubjectsNum).VoltagesCleaned=BV;
    EITDATA(iRec+SubjectsNum).VoltagesFull=BV_cleaned;
    EITDATA(iRec+SubjectsNum).RemovedChannels=chn_removed;
    EITDATA(iRec+SubjectsNum).Diagnosis=PatientInfo.classification(iRec);
    EITDATA(iRec+SubjectsNum).StudyID=PatientInfo.StudyID(iRec);
    EITDATA(iRec+SubjectsNum).Comments=PatientInfo.comments;
    
end