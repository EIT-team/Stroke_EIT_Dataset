load('PatientSubjectInfo');

SubjectsNum=length(SubjectInfo.StudyID);


for iRec = 1:SubjectsNum
    EITDATA(iRec).NameTag
    EITDATA(iRec).Classification
    EITDATA(iRec).VoltagesCleaned
    EITDATA(iRec).VoltagesFull
    EITDATA(iRec).RemovedChannels
    EITDATA(iRec).Diagnosis
    EITDATA(iRec).StudyID
    EITDATA(iRec).Comments

end

Patients_chosen=[6;9;11;12;15;16;17;18;19;20;23;24;25;26];

PatientsNum=length(Patients_chosen);


for iRec = 1:PatientsNum
    EITDATA(iRec).NameTag
    EITDATA(iRec).Classification
    EITDATA(iRec).VoltagesCleaned
    EITDATA(iRec).VoltagesFull
    EITDATA(iRec).RemovedChannels
    EITDATA(iRec).Diagnosis
    EITDATA(iRec).StudyID
    EITDATA(iRec).Comments

end