function EEG_preprocessing_bpfilter(home_path,subjects,ex_type,ex_num)
    eeglab;
    for subj = 1:length(subjects)
        for type_id = 1:length(ex_type)
            for iter = 1:ex_num
                data_path = [home_path 'subjects/' subjects{subj} '/'];
                output_path  = [home_path 'ex_' ex_type{type_id} '/']; % path where data is saved
                cd(data_path)
            
                % Step 1: Import file, downsample(or not), bandpass filter(or not), and save as EEG set file
                Filename = [ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '.vhdr'];
            
                if exist([data_path ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '.vhdr'],'file')
                    %EEG = pop_biosig([data_path Filename],'ref',71); % Code used by EEGLab to import BioSemi files % referenced to elec 71
                    EEG = pop_loadbv(data_path, Filename);
                    %EEG = pop_loadset('filename',Filename,'filepath',date_path);
                    EEG.setname = [ex_type{type_id} '_' num2str(iter)];
                    EEG = eeg_checkset( EEG );
                    EEG = pop_basicfilter( EEG,  1:32 , 'Cutoff', [ 0.1 80], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2); % this is an erplab function for bandpass filtering 
                    EEG = eeg_checkset( EEG );
                    %EEG = pop_basicfilter( EEG,  1:32 , 'Cutoff',  50, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180 ); % GUI: 08-Nov-2022 09:22:55
                    %EEG = eeg_checkset( EEG );
                    %EEG = pop_reref( EEG, []);%rereference
                    %EEG = eeg_checkset( EEG );
                    EEG.setname = [ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '_bpfilt'];
                    EEG = pop_saveset( EEG, 'filename',EEG.setname,'filepath',output_path);
                else
                
                    fprintf('\n\n\n**** %s: Does Not Exist ****\n\n', Filename);
                    fprintf('**** Continuing with Next Subject ****\n\n\n');
                end
            end
        end
    end
end