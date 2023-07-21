% The time course of selective encoding and maintenance of task-relevant object features in working memory
% ERP analysis
% Andrea Aug/Sept 2018

clear; 
close all;

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
subjects = {'miyoshi','dogu'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path);

eeglab;
%%compute all erp
for subj = 1:length(subjects)
    % specify subject data path
    for type_id = 1:length(type)
        data_path = [home_path '/ex_' type{type_id} '/']; % path where data is saved
        cd(data_path);
        % creating a new directory 'ERP_data'
        if ~exist([data_path 'ERP_data'], 'dir')
            mkdir([data_path 'ERP_data']);
        end 
        % creating a variable with this directory's name
        erpdir = [data_path 'ERP_data/'];
        for iter = 1:ex_cnt
            EEG = pop_loadset('filename',[type{type_id} '_' subjects{subj} '_' num2str(iter) '_epoched_ar_rej.set' ],'filepath',data_path);
            EEG = eeg_checkset( EEG );
            % averaging bin-epoched EEG dataset
            ERP = pop_averager( EEG , 'Criterion',0, 'DSindex', 1, 'SEM', 'on' );
            % creating a name for the new data set
            ERP = pop_binoperator(ERP,{'bin7 = (b1+b2)/2 label 1000ms','bin8 = (b3+b4)/2 label 150ms','bin9 = (b5+b6)/2 label 66ms'});
            ERP.erpname=[type{type_id} '_' subjects{subj} '_' num2str(iter) '_ERPs.erp'];
            % saving the ERP file
            pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', ERP.erpname, 'filepath', erpdir);
        end
        % displaying message
            %fprintf(['\n\n****Finished Processing ' num2str(size(subjects,2)) ' Subjects****\n\n']);

    end
end

%% make each conditions erp

clear; 
close all;

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
subjects = {'miyoshi','dogu'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path);

for type_id = 1:length(type)
    for subj = 1:length(subjects)
        ALLERP = buildERPstruct([]);
        CURRENTERP = 0; % counter

    
        check_type = type_id;
    
    
        ALLERP = buildERPstruct([]);

        data_path  = [home_path '/ex_' type{type_id} '/ERP_data/'];
        cd(data_path);
        for iter = 1:ex_cnt
            ERP = pop_loaderp('filename',[type{type_id} '_' subjects{subj} '_' num2str(iter) '_ERPs.erp'],'filepath',data_path);
            CURRENTERP = CURRENTERP + 1;
            ALLERP(CURRENTERP) = ERP;
        end
    
        clear ERP
        %pop_gaverager( '/home/nakajima/ドキュメント/研究室/研究データ/脳波データ/takanashi/ERP_data/a.txt' , 'DQ_flag', 0, 'DQ_spec', DQ_spec_structure );
        ERP = pop_gaverager( ALLERP , 'Erpsets', 1:length(subjects),'SEM' , 'on' ,'DQ_flag', 0);
        ERP.erpname = ['grand_avg_' subjects{subj} '_' type{type_id}];
        if ~exist([home_path 'ERP_data'], 'dir')
            mkdir([home_path 'ERP_data']);
        end
        erp_path = [home_path 'ERP_data'];
        cd(erp_path);
        pop_savemyerp(ERP, 'filename', [ERP.erpname '.erp'], 'filepath', erp_path, 'warning', 'off');
    end
end
