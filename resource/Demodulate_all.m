%% DEMODULATE ALL DATA
% This script demodulates all datasets from raw BDF files into demodulated
% voltage magnitudes and phase. Requires the Load_data library
%
% THIS TAKES A LONG TIME ~ 10 hours (?)
%
% After this is performed, the next stage is to correct for the injected
% current amplitude, BioSemi gain and to extract the real component. Shown
% in Process_single_dataset.m


%% Process Patients
% find files in the Patient directory
fld_patient = dir('Patients\Patient*');

%take only the directories
fld_patient=fld_patient([fld_patient.isdir]);

% number of folders to process
fnum_patient = size(fld_patient,1);

%process all data in each folder, catching errors as we go
for iFld = 1:fnum_patient
    try
        ScouseTom_ProcessBatch([fld_patient(iFld).folder filesep fld_patient(iFld).name])
    catch err
        fprintf(2, '%s\n', getReport(err, 'extended'));
        fprintf(2, ' Error in processing folder %s\n',fld_patient(iFld).name);
    end
    
end

%% Process Subjects

% find files in the Patient directory
fld_subject = dir('Subjects\Subject*');

%take only the directories
fld_subject=fld_subject([fld_subject.isdir]);

% number of folders to process
fnum_subject = size(fld_subject,1);

%process all data in each folder, catching errors as we go
for iFld = 1:fnum_subject
    try
        ScouseTom_ProcessBatch([fld_subject(iFld).folder filesep fld_subject(iFld).name])
    catch err
        fprintf(2, '%s\n', getReport(err, 'extended'));
        fprintf(2, ' Error in processing folder %s\n',fld_subject(iFld).name);
    end
    
end
