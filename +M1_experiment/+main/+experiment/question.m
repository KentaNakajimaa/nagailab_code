function t = question(mainWindow,type,rect_color,rect_position,time_p,time_n)
    myText = [double(char(type)) double('の強さを答えてください　[4]弱い　[6]強い')];
    DrawFormattedText(mainWindow, myText, 'center', 'center', [200 200 200]);
    make_triggur(mainWindow,rect_color,rect_position);
    t = Screen('Flip', mainWindow,time_p + time_n);
end