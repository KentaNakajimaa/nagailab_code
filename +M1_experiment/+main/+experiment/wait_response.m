function res = wait_response(fileID,leftKey,rightKey)
    %answer
    keyOn = 0;
    while keyOn == 0
        [~, ~,keyCode] = KbCheck;
        if keyCode(leftKey)
           keyOn = 1;
           fprintf(fileID,'%s\n','low');
           res = 2;
        elseif keyCode(rightKey)
           keyOn = 1;
           fprintf(fileID,'%s\n','high');
           res = 1;
        end
    end
end