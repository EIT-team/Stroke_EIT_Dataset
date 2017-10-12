%% Create the Patient Summary info
% this takes the info saved in the .csv and puts it together in the form
% used in the .mat and .json files. This doesnt need to be repeatedly run
% unless the text file is altered

%% Load the data in the textfile
fileID = fopen('EIT_Patient_Summary.csv','r');
dataArray = textscan(fileID, '%s%s%s%s%s%s%[^\n\r]', 'Delimiter', ',', 'HeaderLines' ,1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
EITPatientSummary = [dataArray{1:end-1}];

%take the specific columns
NameTag=EITPatientSummary(:,1);
Classification=lower(EITPatientSummary(:,4));
Diagnosis=(EITPatientSummary(:,5));
Comments=(EITPatientSummary(:,6));

%% Extract the codes from the NameTag

% P6Br2 - Patient 6, recording B, frame 2

for iRec = 1:length(NameTag)
    curstr=char(NameTag{iRec});
    % first char is either P or S
    Rectype{iRec}=curstr(1);
    
    %find if there is a A or B, corresponding to repeated datasets in
    %subject/patient
    b=curstr(regexp(curstr,'[AB]'));
    
    if isempty(b)
        Rectype_sub{iRec}='';
    else
        Rectype_sub{iRec}=b;
    end
    
    %find the numbers in the string
    a=regexp(curstr,'\d');
    Recnum(iRec)=str2double(curstr(a(end))); % first is the ID
    StudyNum(iRec)=str2double(curstr(a(1:end-1))); % second is the frame/recording deemed the best through inspection 
end

%% Subjects
% take just the data for subjects
Subject_num=StudyNum(char(Rectype) == 'S');
Subject_rec_sub=Rectype_sub(char(Rectype) == 'S');
Subject_recnum=Recnum(char(Rectype) == 'S');
Subject_classification=Classification(char(Rectype) == 'S');
Subject_diagnosis=Diagnosis(char(Rectype) == 'S');
Subject_comments=Comments(char(Rectype) == 'S');

% make sure its in correct order
[Subject_num,idx]=sort(Subject_num);
Subject_rec_sub=Subject_rec_sub(idx);
Subject_recnum=Subject_recnum(idx);
Subject_classification=Subject_classification(idx);
Subject_diagnosis=Subject_diagnosis(idx);
Subject_comments=Subject_comments(idx);

% create the string to point to the correct folder for each dataset
for iSub=1:length(Subject_num)
    Subject_fname{iSub}=sprintf('Subject_%02d%s',Subject_num(iSub),lower(Subject_rec_sub{iSub}));
end
% save into the structure for later
SubjectInfo.name=Subject_fname;
SubjectInfo.frame_chosen=Subject_recnum;
SubjectInfo.StudyID=Subject_num;
SubjectInfo.classification=Subject_classification;
SubjectInfo.subclassification=Subject_classification;
SubjectInfo.diagnosis=Subject_diagnosis;
SubjectInfo.comments=Subject_comments;


%% Patients
% take just the data for patients
Patient_num=StudyNum(char(Rectype) == 'P');
Patient_rec_sub=Rectype_sub(char(Rectype) == 'P');
Patient_recnum=Recnum(char(Rectype) == 'P');
Patient_classification=Classification(char(Rectype) == 'P');
Patient_diagnosis=Diagnosis(char(Rectype) == 'P');
Patient_comments=Comments(char(Rectype) == 'P');

% make sure its in correct order
[Patient_num,idx]=sort(Patient_num);
Patient_rec_sub=Patient_rec_sub(idx);
Patient_recnum=Patient_recnum(idx);
Patient_classification=Patient_classification(idx);
Patient_diagnosis=Patient_diagnosis(idx);
Patient_comments=Patient_comments(idx);

% read from the previous shorthand classification - big is/ small ich etc.
Patient_Ischeamia=cellfun(@(x) ~isempty(x),strfind(Patient_classification,'is'));
Patient_Heamo=cellfun(@(x) ~isempty(x),strfind(Patient_classification,'ich'));
Patient_Big=cellfun(@(x) ~isempty(x),strfind(Patient_classification,'big'));
Patient_small=cellfun(@(x) ~isempty(x),strfind(Patient_classification,'small'));

% create the new larger heamo/isch classification
Patient_classification_full=Patient_classification;
Patient_classification_full(Patient_Heamo)={'haemorrhage'};
Patient_classification_full(Patient_Ischeamia)={'ischaemia'};

% create the sub classification, same as previous but written nicer
Patient_subclassification=Patient_classification;
Patient_subclassification(Patient_Heamo & Patient_Big)={'big haemorrhage'};
Patient_subclassification(Patient_Heamo & Patient_small)={'small haemorrhage'};
Patient_subclassification(Patient_Ischeamia & Patient_Big)={'big ischaemia'};
Patient_subclassification(Patient_Ischeamia & Patient_small)={'small ischaemia'};

% create the string to point to the correct folder for each dataset
for iPatient=1:length(Patient_num)
    Patient_fname{iPatient}=sprintf('Patient_%02d%s',Patient_num(iPatient),lower(Patient_rec_sub{iPatient}));
end
% save into the structure for later
PatientInfo.name=Patient_fname;
PatientInfo.frame_chosen=Patient_recnum;
PatientInfo.StudyID=Patient_num;
PatientInfo.classification=Patient_classification_full;
PatientInfo.subclassification=Patient_subclassification;
PatientInfo.diagnosis=Patient_diagnosis;
PatientInfo.comments=Patient_comments;

%%
save('PatientSubjectInfo','SubjectInfo','PatientInfo');





