clear
close all;
warning('off');

tstart = tic;
home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
data_path = [home_path 'SVM_result/'];
output_path = [home_path 'image/SVM_img/'];
subjects = {'aso','miyoshi','hanada','horiuchi','dogu','takanashi'};
type = {'gloss', 'beautiful'};
time_type = {'1000ms','150ms','66ms'};%, 'short_1', 'short_2'};
%program_path =  '/home/nakajima/ドキュメント/研究室/プログラム/M1実験/予備実験用/解析用/SVM/';
conditions = {'high','low'};
svm_type = 'lasso';
for time_no = 1:length(time_type)
    type_score = [];
    for type_id = 1:length(type)
        all_subjects_score = [];
        all_score = [];
        for subj = 1:length(subjects)
            load([data_path subjects{subj} '_' type{type_id} '_' time_type{time_no} '_accuracy_' svm_type '.mat']);
            all_subjects_score = [all_subjects_score;score];
            %all_score = [all_score;score_all.'];
        end
        type_score = [type_score; mean(all_subjects_score,1)];
    end
    M1_experiment.visualise.plot.timecourse_per_condition(times,type_score,type,time_type{time_no},output_path);         
end

    
for type_id = 1:length(type)
    type_score = [];
    for time_no = 1:length(time_type)
        all_subjects_score = [];
        all_score = [];
        for subj = 1:length(subjects)
            load([data_path subjects{subj} '_' type{type_id} '_' time_type{time_no} '_accuracy_' svm_type '.mat']);
            all_subjects_score = [all_subjects_score;score];
            %all_score = [all_score;score_all.'];
        end
        type_score = [type_score; mean(all_subjects_score,1)];
    end
    M1_experiment.visualise.plot.timecourse_per_condition(times,type_score,time_type,type{type_id},output_path); 
        
end
