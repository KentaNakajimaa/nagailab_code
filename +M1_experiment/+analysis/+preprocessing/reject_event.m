function new_EEG = reject_event(EEG)
    reject_event = [];
    past_latency = 0;
        
    for event_num = 1:length(EEG.event)
         if EEG.event(event_num).latency < (past_latency + 1500)
               reject_event = [reject_event EEG.event(event_num).bvmknum];
         end
         past_latency = EEG.event(event_num).latency;
    end
    EEG = pop_selectevent( EEG, 'type',{'S  1'},'deleteevents','on');
    new_EEG = pop_selectevent( EEG, 'type',{'S  1'},'bvmknum',reject_event,'select', 'inverse','deleteevents','on');
            
end