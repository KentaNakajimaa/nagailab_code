function t = make_blank(mainWindow,xcenter,ycenter,black,rect_position,time_p,time_n)
    Screen('DrawText', mainWindow,'+',xcenter-30, ycenter-30);
    make_triggur(mainWindow,black,rect_position);
    t = Screen('Flip', mainWindow,time_p + time_n);
end