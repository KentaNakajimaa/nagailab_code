% The time course of selective encoding and maintenance of task-relevant object features in working memory
% ERP analysis
% Andrea Aug/Sept 2018

clear; 
close all;

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/脳波データ/'; % path on server
subjects = {'nakajima','asou','nohira','koizumi','inoue','horiuchi','hanada','takanashi'};
type = {'gloss', 'moist' , 'beautiful','luxury'};

cd(home_path)
eeglab
%%compute all erp
for subj = 1%:length(subjects)
    
    % specify subject data path
    data_path  = [home_path subjects{subj} '/'];
    cd(data_path)
    for type_id = 1%:length(type)
        
        check_type = type_id;
        
        % creating a new directory 'ERP_data'
        if ~exist([data_path 'ERP_data'], 'dir')
            mkdir([data_path 'ERP_data']);
        end
        
        % creating a variable with this directory's name
        erpdir = [data_path 'ERP_data/'];
    
        EEG = pop_loadset('filename',[type{type_id} '_' subjects{subj} '_epoched_by_reaction_ar_rej.set' ],'filepath',data_path);
        EEG = eeg_checkset( EEG );
        % averaging bin-epoched EEG dataset
        ERP = pop_averager( EEG , 'Criterion',0, 'DSindex', 1, 'SEM', 'on' );
        % creating a name for the new data set
        ERP = pop_binoperator(ERP,{'bin9 = (b1+b3)/2 label ans high','bin10 = (b2+b4)/2 label ans low'});
        ERP.erpname=[type{type_id} '_' subjects{subj} '_' type{check_type} 'by_reaction_ERPs.erp'];
        % saving the ERP file
        pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', ERP.erpname, 'filepath', erpdir);
    
        % displaying message
            %fprintf(['\n\n****Finished Processing ' num2str(size(subjects,2)) ' Subjects****\n\n']);

            
        
    end
end

%% make each conditions erp

clear; 
close all;

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/脳波データ/'; % path on server
subjects = {'nakajima','asou','nohira','koizumi','inoue','horiuchi','hanada','takanashi'};
type = {'gloss', 'moist' , 'beautiful','luxury'};
conditions = {'high','low'};

for type_id = 1:length(type)
    ALLERP = buildERPstruct([]);
    CURRENTERP = 0; % counter

    
    check_type = type_id;
    
    
    ALLERP = buildERPstruct([]);
    CURRENTERP = 0; % counter
    for subj = 1:length(subjects)
        data_path  = [home_path subjects{subj} '/ERP_data/'];
        cd(data_path)
        ERP = pop_loaderp('filename',[type{type_id} '_' subjects{subj} '_' type{check_type} 'by_reaction_ERPs.erp'],'filepath',data_path);
        CURRENTERP = CURRENTERP + 1;
        ALLERP(CURRENTERP) = ERP;
    end
    clear ERP
        %pop_gaverager( '/home/nakajima/ドキュメント/研究室/研究データ/脳波データ/takanashi/ERP_data/a.txt' , 'DQ_flag', 0, 'DQ_spec', DQ_spec_structure );
    ERP = pop_gaverager( ALLERP , 'Erpsets', 1:length(subjects),'SEM' , 'on' ,'DQ_flag', 0);
    ERP.erpname = ['grand_avg_n' num2str(length(subjects)) type{type_id} '_by_reaction'];
    if ~exist([home_path 'ERP_data'], 'dir')
        mkdir([home_path 'ERP_data']);
    end
    erp_path = [home_path 'ERP_data'];
    cd(erp_path);
    pop_savemyerp(ERP, 'filename', [ERP.erpname '.erp'], 'filepath', erp_path, 'warning', 'off');
    
end