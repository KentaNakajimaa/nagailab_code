function EEG_preprocessing_edit_events(home_path,subjects,ex_type,ex_num)
    eeglab;
    for subj = 1:length(subjects)
        for type_id = 1:length(ex_type)
            for iter = 1:ex_num
                data_path  = [home_path 'ex_' ex_type{type_id} '/']; % path where data is saved
                EEG = pop_loadset('filename',{[ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '_bpfilt.set']},'filepath',data_path); 
                EEG=pop_chanedit(EEG, 'lookup','/home/nakajima/tools/eeglab/eeglab2022.0/plugins/dipfit/standard_BEM/elec/standard_1005.elc');
                %[ALLEEG ,EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
                %EEG = eeg_checkset( EEG );
        
                %EEG = pop_epoch( EEG, {  'S  1'  }, [-0.5           1], 'newname', [char(type(type_id)) '_' char(subjects{subj}) '_bpfilt epochs'], 'epochinfo', 'yes');
                EEG = M1_experiment.analysis.preprocessing.reject_event(EEG);
                % load result
                filename = [home_path subjects{subj} '/' ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '.mat'];
                load(filename,'result');
                %input result
                EEG = M1_experiment.analysis.preprocessing.input_result(EEG,result);
        
                %%
                EEG = pop_binlister( EEG , 'BDF', [home_path 'binlist/binlist_test.txt'], 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' ); % GUI: 01-Nov-2022 18:22:40
                EEG = pop_epochbin( EEG , [-1000.0  2000.0],  'none');
        
                EEG = eeg_checkset( EEG );
        
                EEG.setname = [ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '_epoched'];
                EEG = pop_saveset( EEG, 'filename',EEG.setname,'filepath',data_path);
            end
        end
    end
end
