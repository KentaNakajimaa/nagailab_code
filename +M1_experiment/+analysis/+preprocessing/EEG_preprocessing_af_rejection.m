function EEG_preprocessing_af_rejection(home_path,subjects,ex_type,ex_num)
    eeglab
    for subj = 1:length(subjects)
        for type_id = 1 :length(ex_type)
            for iter = 1:ex_num
                % specify subject data path
                data_path  = [home_path 'ex_' ex_type{type_id} '/'];
                cd(data_path)
        
                EEG = pop_loadset('filename',{[ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '_epoched_ar.set']},'filepath',data_path); 
        
                %[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
                eeg.arf.artIndCleaned = EEG.reject.rejmanual;
        
                % remove trials marked for rejection
                EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
                trial_rej=find(EEG.reject.rejmanual);
                EEG = pop_rejepoch( EEG,trial_rej,0);
                EEG = eeg_checkset( EEG );
                EEG = pop_rmbase( EEG, [-1000 0] ,[]);
                %EEG = pop_reref( EEG, []);
                EEG = eeg_checkset( EEG );
                EEG.setname = [EEG.setname '_rej'];
                EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);
            end
        end
    end
end
