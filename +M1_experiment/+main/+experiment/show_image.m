function t = show_image(mainWindow,data1,image_position,xcenter,ycenter,rect_color,rect_position,time_p,time_n)
    tex1 = Screen('MakeTexture',mainWindow,data1);
    Screen('DrawTexture',mainWindow,tex1,[] ,image_position);
    Screen('DrawText', mainWindow,'+',xcenter-30, ycenter-30);
    %make triggur
    M1_experiment.experiment.make_triggur(mainWindow,rect_color,rect_position);
    t = Screen('Flip',mainWindow,time_p + time_n);
    
end