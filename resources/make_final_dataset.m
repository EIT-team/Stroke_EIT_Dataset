% Create the final Stroke EIT dataset
%
% This file creates the final dataset, assuming the following have already
% been run:
%   0 - extract_patientinfo - finds which patients belong to which group
%   1 - Demodulate_all - convert the raw eeg system data to EIT boundary voltages
%   2 - Average_healthy - find data rejection criteria
%   
%   The outputs of these functions are included in the repository already,
%   so are only necessary if changes have been made to the processing. 

% add directory where normalise_dataset and reject_channels are found
addpath('../src'); %

% load the data extracted from the patient summary
load('PatientSubjectInfo');
%% Process the Subject data
SubjectsNum=length(SubjectInfo.StudyID);
for iRec = 1:SubjectsNum
    % load the data for this subject - accounting for the fact the
    % filenames could be MF1 or MF2
    dirname=dir([ '..' filesep 'Subjects' filesep SubjectInfo.name{iRec} filesep '*MF*-BV.mat']);
    % load the data and extract real component
    [BV, BVstruct]=normalise_dataset([dirname.folder filesep dirname.name]); 
    % reject bad channels in this dataset
    [BV_cleaned, chn_removed] = reject_channels( BV(:,:,SubjectInfo.frame_chosen(iRec)));
    
    % Add the other data too
    EITDATA(iRec).NameTag=SubjectInfo.name{iRec};
    EITDATA(iRec).Classification=SubjectInfo.classification{iRec};
    EITDATA(iRec).SubClassification=SubjectInfo.classification{iRec};
    EITDATA(iRec).VoltagesCleaned=BV_cleaned;
    EITDATA(iRec).VoltagesFull=BV(:,:,SubjectInfo.frame_chosen(iRec));
    EITDATA(iRec).RemovedChannels=chn_removed;
    EITDATA(iRec).Diagnosis=SubjectInfo.classification{iRec};
    EITDATA(iRec).StudyID=SubjectInfo.StudyID(iRec);
    EITDATA(iRec).Comments=SubjectInfo.comments{iRec};
    
end

%% Process the patient data
PatientsNum=size(PatientInfo.StudyID,2);

for iRec = 1:PatientsNum
    % load the data for this subject - accounting for the fact the
    % filenames could be MF1 or MF2
    dirname=dir([ '..' filesep 'Patients' filesep PatientInfo.name{iRec} filesep '*MF*-BV.mat']);
    % load the data and extract real component
    [BV, BVstruct]=normalise_dataset([dirname.folder filesep dirname.name]); 
    % reject bad channels in this dataset
    [BV_cleaned, chn_removed] = reject_channels( BV(:,:,PatientInfo.frame_chosen(iRec)));
    
    % Add the other data too
    EITDATA(iRec+SubjectsNum).NameTag=PatientInfo.name{iRec};
    EITDATA(iRec+SubjectsNum).Classification=PatientInfo.classification{iRec};
    EITDATA(iRec+SubjectsNum).SubClassification=PatientInfo.subclassification{iRec};
    EITDATA(iRec+SubjectsNum).VoltagesCleaned=BV_cleaned;
    EITDATA(iRec+SubjectsNum).VoltagesFull=BV(:,:,PatientInfo.frame_chosen(iRec));
    EITDATA(iRec+SubjectsNum).RemovedChannels=chn_removed;
    EITDATA(iRec+SubjectsNum).Diagnosis=PatientInfo.diagnosis{iRec};
    EITDATA(iRec+SubjectsNum).StudyID=PatientInfo.StudyID(iRec);
    EITDATA(iRec+SubjectsNum).Comments=PatientInfo.comments{iRec};
    
end

%% save some relevant EIT settings

load('Mesh_example.mat');

EITSETTINGS.Freq = BVstruct.ExpSetup.Freq;
EITSETTINGS.Protocol= BVstruct.prt_full(BVstruct.keep_idx,:);
EITSETTINGS.ElectrodePosition=Mesh.elec_pos; 

save('../UCL_Stroke_EIT_Dataset','EITDATA','EITSETTINGS');

%% save as JSON file (MATLAB 2016b function)

json_data{1}.json = jsonencode(EITDATA);
json_data{1}.file = 'EITDATA.json';

json_data{2}.json = jsonencode(EITSETTINGS);
json_data{2}.file = 'EITSETTINGS.json';

for iFile = 1:2
    fid = fopen(json_data{iFile}.file, 'wt');
    fprintf(fid, json_data{iFile}.json);
    fclose(fid);
end
