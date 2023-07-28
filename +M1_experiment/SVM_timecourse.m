%% SVM and bootstrap
%function predict = SVM_predict(data_train,data_test,reaction_train,reaction_test)
%    SVMmodel = fitcsvm(data_train,reaction_train);
%    predict = svmpredict(reaction_test,data_test,SVMmodel);
%end
clear
close all;
warning('off');

tstart = tic;
home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
subjects = {'aso'};%,'miyoshi','hanada','horiuchi','dogu','takanashi'};
type = {'gloss', 'beautiful'};
time_type = {'1000ms','150ms','66ms'};%, 'short_1', 'short_2'};
%program_path =  '/home/nakajima/ドキュメント/研究室/プログラム/M1実験/予備実験用/解析用/SVM/';
conditions = {'high','low'};

ex_cnt = 4;
time_step = 10;
window_size = 50;
time_start = 500;
time_end = 2500;
%nboot = 100;
iter_no = 1;
iter_no_closs = 10;
image_no = 20;

%%elec_pos = [12 ,13 ,14 ,15 ,16 ,17 ,18 ,19];
eeglab;

%nboot = 100;
for subj = 1:length(subjects)
    for type_id = 1:length(type)
        data = [];
        label = [];
        reaction = [];
        pres_time = [];
        for iter =1:ex_cnt
            %if type_id == 1 && check_type == 1
            %    continue
            %end
            data_path  = [home_path 'ex_' type{type_id} '/']; % path where data is saved
            EEG = pop_loadset('filename',{[type{type_id} '_' subjects{subj} '_' num2str(iter) '_epoched_ar_rej.set']},'filepath',data_path); 
            EEG = eeg_checkset( EEG );
            %data = EEG.data;
            data_temp = EEG.data;
            data = cat(3,data,data_temp);
            reaction_temp = struct2table(EEG.event).ans;
            %reaction = struct2table(EEG.event).ans;
            %label = struct2table(EEG.event).result;
            reaction = cat(1,reaction,reaction_temp);
            %label_temp = struct2table(EEG.event).imID;
            %label = cat(1,label,label_temp);
            pres_time_temp = struct2table(EEG.event).prestime;
            pres_time = cat(1,pres_time,pres_time_temp);
        end
        
        %% model SVM
        enodes = length(data(:,1,1));
        times = -1000 + time_start + window_size/2:time_step:time_end-1000 -window_size/2;
        score=zeros(1,length(times));
        %score_all = zeros(length(times),iter_no);
        score_all = zeros(length(times),iter_no);
        % sliding window
        for time_no = 1:length(time_type)
            id_time = find(pres_time == time_no);
            reaction_time = reaction(id_time);
            data_time = data(:,:,id_time);
            trials = length(data_time(1,1,:));
            for t = 1:(time_end-window_size)/time_step - (time_start/time_step) + 1
                time_window = time_start + (t-1)*time_step + 1: time_start + (t-1)*time_step + window_size;
                data_window = data_time(:,time_window,:);
        
                data_window = reshape(data_window,[enodes*length(time_window),trials]);
                data_window = data_window.';
            
                %bootstrap
                %pre = SVM_predict(data_window,reaction);
                %pre = SVM_predict_kernel_pca(data_window,reaction);
                %pre = SVM_predict_pca_zscore(data_window,reaction);
                [score(t),score_all(t,:)] = M1_experiment.analysis.SVM.under_baging(data_window,reaction_time,iter_no);
        
            end
            resultID = [home_path 'SVM_result/' subjects{subj} '_' type{type_id} '_' time_type{time_no} '_accuracy_lasso'];
            %resultID = [type{type_id} '_' type2{check_type} '_test'];
            %save(resultID,'score','times');
            save(resultID,'score','times','score_all');
        end
    end
end

tend = toc(tstart)