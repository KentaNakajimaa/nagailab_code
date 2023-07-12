function new_EEG = input_result(EEG,result)
    event_num = 1;
    for epoch_num = 1:length(EEG.event)
        event_bin = [];
        if EEG.event(epoch_num).code(1) == 'S'
            EEG.event(epoch_num).imID = result(event_num,1);
            EEG.event(epoch_num).ans = result(event_num,2);
            EEG.event(epoch_num).prestime = result(event_num,3);
            event_bin = [event_bin num2str(result(event_num,2))];
            EEG.event(epoch_num).type = ['S  ' event_bin];
            event_num = event_num + 1;
        end
    end
    new_EEG = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ); % GUI: 01-Nov-2022 18:07:22
    new_EEG = eeg_checkset( new_EEG );    

end