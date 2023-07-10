function t = make_rest(mainWindow,black,rect_position,xcenter,ycenter,key_start)
    myText = double('2を押して開始');
    DrawFormattedText(mainWindow, myText, 'center', 'center', [200 200 200]);
    M1_experiment.experiment.make_triggur(mainWindow,black,rect_position);
    Screen('Flip', mainWindow);
    while 1
        [~ ,~ ,KeyCode] = KbCheck;
        if KeyCode(key_start)
            break
        end
    end
    while KbCheck; end
 
    Screen('DrawText', mainWindow,'+',xcenter-30, ycenter-30);
    M1_experiment.experiment.make_triggur(mainWindow,black,rect_position);
    t = Screen('Flip', mainWindow);
end