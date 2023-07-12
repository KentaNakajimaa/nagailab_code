function EEG_preprocessing_af_detect(home_path,subjects,ex_type,ex_num)
    eeglab;
    for subj = 1:length(subjects)
        for type_id = 1:length(ex_type)
            for iter = 1:ex_num
                % specify subject data path
                data_path  = [home_path 'ex_' ex_type{type_id} '/'];
                % Load EEGlab dataset
                EEG = pop_loadset('filename',{[ex_type{type_id} '_' subjects{subj} '_' num2str(iter) '_epoched.set']},'filepath',data_path); 
                fprintf('\n\n\n**** %s: Artifact detection (moving window peak-to-peak and step function) ****\n\n\n', ex_type{type_id});
        
                % Artifact detection. Moving window.
                % Window width = 200 ms;
                % Window step = 50 ms; Channels = 1 to 32;
                % Identifies blinks (flag 1 3) and noisy channels (flag 1 4)
        
                % 1 biVEOG Identifies blinks (flag 1 3)
                threshold = 120;
                EEG = pop_artmwppth( EEG , 'Channel',  1, 'Flag', [1 3], 'Review', 'off', 'Threshold',  threshold, 'Twindow', [0 1000.0], 'Windowsize',  200, 'Windowstep',  50 ); %Only go up the test display onset
                %EEG = pop_select( EEG, 'nochannel',{'FP1','FP2','P3'});
                EEG = pop_select( EEG, 'nochannel',{'FP1','FP2'});%,'F4','T8','T7'});
                EEG = eeg_checkset( EEG );
                % Identifies noisy channels (flag 1 4)
                threshold = 120;
                EEG = pop_artmwppth( EEG , 'Channel',  1:30, 'Flag', [1 4], 'Review', 'off', 'Threshold',  threshold, 'Twindow', [0  1500.0], 'Windowsize',  200, 'Windowstep',  50 );
        
                % Artifact detection. Step-like artifacts in the bipolar
                % HEOG channel (channel 73, created earlier with Channel Operations)
                % Threshold = 25 uV; Window width = 400 ms;eeglaa
                % Window step = 10 ms; Flags to be activated = 1 & 3
        
                % 66 biHEOG
                %threshold = 25;
                %EEG = pop_artstep( EEG , 'Channel',  32, 'Flag', [1 5], 'Review', 'off', 'Threshold',  threshold, 'Twindow', [0  1000.0], 'Windowsize',  400, 'Windowstep',  10 ); %Only go up the test display onset
        
                EEG.setname = [EEG.setname '_ar'];
                EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', data_path);
        
                % Report percentage of rejected trials (collapsed across all bins)
                artifact_proportion = getardetection(EEG);
                fprintf('%s: Percentage of rejected trials was %1.2f\n', ex_type{type_id}, artifact_proportion);
            end
        end
    end
end