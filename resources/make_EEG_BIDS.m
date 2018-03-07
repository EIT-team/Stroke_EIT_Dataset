% Make BIDS electrodes file

load('Mesh_example.mat');
%%
% fid=fopen('Electrode_Positions.txt');

A=readtable('Electrode_Positions.txt');

Elec_name = A.EEG10_10Equivalent;

X=Mesh.elec_pos(:,1);
Y=Mesh.elec_pos(:,2);
Z=Mesh.elec_pos(:,3);
Elecnum=length(X);

%% write electrodes file
%write each file with its EEG 10-10 equivalent and the coordinates, all
%the electrodes were the same easycap ones.
fid=fopen('_electrodes.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n','name','x','y','z','type','material');
for iElec = 1:Elecnum
    fprintf(fid,'%s\t%f\t%f\t%f\t%s\t%s\n',Elec_name{iElec},X(iElec),Y(iElec),Z(iElec),'EasyCap','Ag/AgCl');
end
fclose(fid);
%% write channels file
%write the channels file. All channels were sampled at the maximum sample
%rate of the BioSemi Active Two. All with respect to the CMS common
%electrode

fid=fopen('_channels.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n','particap','type','description','sampling_rate','low_cutoff','high_cutoff');
for iElec = 1:Elecnum-1
    fprintf(fid,'%s\t%s\t%s\t%d\t%d\t%d\n',Elec_name{iElec},'EEG/EIT','electrode',16384,0,0);
end
fprintf(fid,'%s\t%s\t%s\t%d\t%d\t%d\n','STATUS','TRIG','Digital Triggers See ScouseTom EIT system desc.',16384,0,0);
fclose(fid);

%% write participants file
load('PatientSubjectInfo');

fid=fopen('..\Patients\participants.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\n','participant id','age','sex','group');
for iPatient = 1:length(PatientInfo.name)
    fprintf(fid,'%s\t%s\t%s\t%s\n',PatientInfo.name{iPatient},'-','-',PatientInfo.classification{iPatient});
end
fclose(fid);

fid=fopen('..\Subjects\participants.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\n','participant id','age','sex','group');
for iSubject = 1:length(SubjectInfo.name)
    fprintf(fid,'%s\t%s\t%s\t%s\n',SubjectInfo.name{iSubject},'-','-',SubjectInfo.classification{iSubject});
end
fclose(fid);

%% write data description files


data_description.BIDSVersion = '1.0.2';
data_description.License = 'CC BY 4.0';
data_description.Authors = 'James Avery, Nir Goren, Thomas Dowrick, Eleanor Mackle, Anna Witkowska-Wrobel, David Werring, David Holder';
data_description.Acknowledgements = 'The authors are grateful to Renuka Erande and the whole UCLH stroke research team for their help collecting the data and their guidance and support throughout this project';
data_description.HowToAcknowledge = 'Please cite doi.org\\10.5281\\zenodo.1035910 or the accompanying Sci Data paper';
data_description.Funding = 'EPSRC grant EP\M506448\1 , MRC grant MR\K00767X\1';
data_description.ReferencesAndLinks = 'See github.com\EIT-team\Stroke_EIT_Dataset or doi.org\10.5281\zenodo.1035910 for more description, code and useage notes for this dataset';


% subjects
data_description.Name = 'The UCLH Stroke EIT Dataset - Subjects';
data_description.DatasetDOI = '10.5281\zenodo.836842';

json_data_description.json = jsonencode(data_description);
json_data_description.file = '..\Subjects\data_description.json';

fid = fopen(json_data_description.file, 'wt');
fprintf(fid, json_data_description.json);
fclose(fid);

% Patients
data_description.Name = 'The UCLH Stroke EIT Dataset - Patients';
data_description.DatasetDOI = '10.5281\zenodo.838176 and 10.5281\zenodo.838184';

json_data_description.json = jsonencode(data_description);
json_data_description.file = '..\Patients\data_description.json';

fid = fopen(json_data_description.file, 'wt');
fprintf(fid, json_data_description.json);
fclose(fid);

% Radiology data
data_description.Name = 'The UCLH Stroke EIT Dataset - Radiology Data';
data_description.DatasetDOI = '10.5281\zenodo.838705';

json_data_description.json = jsonencode(data_description);
json_data_description.file = '..\Anonymised_Radiology\data_description.json';

fid = fopen(json_data_description.file, 'wt');
fprintf(fid, json_data_description.json);
fclose(fid);
%% make eeg description files

eeg_sidecar.TaskName = 'rest';
eeg_sidecar.EEGSamplingFrequency=16384;
eeg_sidecar.ManufacturersAmplifierModelName='BioSemi ActiveTwo';
eeg_sidecar.ManufacturersCapModelName='EasyCap';
eeg_sidecar.EEGChannelCount=32;
eeg_sidecar.EOGChannelCount=0;
eeg_sidecar.ECGChannelCount=0;
eeg_sidecar.EMGChannelCount=0;
eeg_sidecar.TriggerChannelCount=8;
eeg_sidecar.PowerLineFrequency=50;
eeg_sidecar.EEGReference='common';

json_eeg_sidecar = jsonencode(eeg_sidecar);
%% copy to folders
% put this metadata in each folder

fld_subject = dir('..\Subjects\Subject*');

%take only the directories
fld_subject=fld_subject([fld_subject.isdir]);
fnum_subject = size(fld_subject,1);

for iSubject = 1:fnum_subject
    
    cur_dir=[fld_subject(iSubject).folder filesep fld_subject(iSubject).name];
    %copy and rename channels.tsv
    copyfile('_channels.tsv',cur_dir);
    movefile([cur_dir filesep '_channels.tsv'],[cur_dir filesep fld_subject(iSubject).name '_channels.tsv']);
    %copy and rename electrodes
    copyfile('_electrodes.tsv',cur_dir);
    movefile([cur_dir filesep '_electrodes.tsv'],[cur_dir filesep fld_subject(iSubject).name '_electrodes.tsv']);
    %write eeg file
    fid = fopen([cur_dir filesep fld_subject(iSubject).name '_eeg.json'], 'wt');
    fprintf(fid, json_eeg_sidecar);
    fclose(fid);
    
end

fld_patient = dir('..\Patients\Patient*');

%take only the directories
fld_patient=fld_patient([fld_patient.isdir]);
fnum_patient = size(fld_patient,1);

for iPatient = 1:fnum_patient
    
    cur_dir=[fld_patient(iPatient).folder filesep fld_patient(iPatient).name];
    %copy and rename channels.tsv
    copyfile('_channels.tsv',cur_dir);
    movefile([cur_dir filesep '_channels.tsv'],[cur_dir filesep fld_patient(iPatient).name '_channels.tsv']);
    %copy and rename electrodes
    copyfile('_electrodes.tsv',cur_dir);
    movefile([cur_dir filesep '_electrodes.tsv'],[cur_dir filesep fld_patient(iPatient).name '_electrodes.tsv']);
    %write eeg file
    fid = fopen([cur_dir filesep fld_patient(iPatient).name '_eeg.json'], 'wt');
    fprintf(fid, json_eeg_sidecar);
    fclose(fid);
    
end









