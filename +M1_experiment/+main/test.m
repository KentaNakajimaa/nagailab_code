%% 事前準備
clear;
ListenChar(2);
stimulisize = 40; 
%% input file open
%change type_num and name 
type = [("gloss"),("moist"),("beautiful"),("luxury")];
type_txt = [("光沢感"),("しっとり感"),("綺麗"),("高級感")];
% 1 = gloss, 2 = moist ,3 = beautiful, 4 = luxury

type_num =1;
name = ('test');
%ID = 1;
%while 1
%    filename = ['/home/nakajima/ドキュメント/研究室/研究データ/M1実験/' char(type(type_num)) '_' name '_result_' num2str(ID) '.txt'];
%    if isfile(filename) == 1
%        ID = ID + 1;
%        continue;
%    end
%    fileID = fopen(filename,'W');
%    resultID = ['/home/nakajima/ドキュメント/研究室/研究データ/M1実験/' char(type(type_num)) '_' name '_result_' num2str(ID) '.mat'];
%    result = zeros(stimulisize,2);
%end
%filename = ['/home/nagailab/ドキュメント/nakajima/ex_' char(type(type_num)) '/' char(type(type_num)) '_' name '_result.txt'];
%filename = ['/home/nakajima/ドキュメント/研究室/研究データ/M1実験/予備実験/ex_' char(type(type_num)) '/long/' char(type(type_num)) '_' name '_result.txt'];
filename = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/test.txt';
fileID = fopen(filename,'w');
%resultID = ['/home/nagailab/ドキュメント/nakajima/ex_' char(type(type_num)) '/' char(type(type_num)) '_' name '.mat'];
%resultID = ['/home/nakajima/ドキュメント/研究室/研究データ/M1実験/予備実験/ex_' char(type(type_num)) '/long/' char(type(type_num)) '_' name '.mat'];
resultID = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/test.mat';
result = zeros(stimulisize,2);
%result = (imageNo,answer);
%right = 1,left = 2
%high = 1 , low = 2
%r = readtable('/home/nagailab/ドキュメント/r.csv');
%g = readtable('/home/nagailab/ドキュメント/g.csv');
%b = readtable('/home/nagailab/ドキュメント/b.csv');

stimulisize = 40;    % 試行回数設定    :   600
stimuli_len = 20;
gray = [128 128 128];
black = [0 0 0];
% 反応用キー設定
KbName('UnifyKeyNames');
%rightKey = KbName('6');
%leftKey = KbName('4');
rightKey = KbName('s');
leftKey = KbName('a');
% parameter setting

rect_color = [255 255 255];
%refreshrate = 60;

%load('/home/nagailab/ドキュメント/nakajima/parameta.mat')



%gamma_converter = tnt.GammaConverter(r, g, b);
%close all

% time of image
%exp_time.before = 1/refreshrate *2;
exp_time.first = 1.2;
exp_time.present = [1.0,0.15,0.1];%0.5
exp_time.blank = [1.0,1.85,1.9];
img_no = 20;
%% PTBウインドウを開く
%Screen('Preference', 'SkipSyncTests', 1);
% open PTB3 
screenNumber = max(Screen('Screens'));
% for debugg
[mainWindow, wRect] = Screen('OpenWindow', 0, gray,[0 0 1300 1000]);
% full sceen (for experiment)
%[mainWindow, wRect] = Screen('OpenWindow', screenNumber, gray);
% sub monitor
%[mainWindow, wRect] = Screen('OpenWindow', 0, gray,[1920 0 5760 2160]);

[xcenter, ycenter] = RectCenter(wRect);
%fixposition = [xcenter-10 ycenter-10 xcenter+10 ycenter+10];
Screen('TextSize', mainWindow, 100);

% 待機画面提示
HideCursor; 
Screen('DrawText', mainWindow,'Start', xcenter-110, ycenter);
Screen('Flip', mainWindow);

% スペースを 1回押すと開始
space = KbName('space');
%space = KbName('2');
while 1
    [~ ,~ ,KeyCode] = KbCheck;
    if KeyCode(space)
        break
    end
end
while KbCheck; end

% 画像表示
    
order = randperm(stimulisize);
order1 = rem(order,stimuli_len) +1;
order2 = rem(order,3) + 1;
%image position
image_position = [xcenter-256 ycenter-192 xcenter+256 ycenter+192];
% triggur position
%rect_position_right = [xcenter+1400 ycenter+800 xcenter+1600 ycenter+1000];
%rect_position_left = [xcenter-200 ycenter+200 xcenter-250 ycenter+250];
% for test
rect_position_right = [xcenter+400 ycenter+400 xcenter+500 ycenter+500];


%try
Screen('TextFont',mainWindow,'-:lang=ja');
Screen('TextSize', mainWindow, 50);
%% 

for i = 1:stimulisize
   
    Screen('Close');
    %%rest
    if rem(i ,20) == 1
        exp_time.flip = M1_experiment.experiment.make_rest(mainWindow,black,rect_position_right,xcenter,ycenter,space);
        
    else
        %blank
        exp_time.flip = M1_experiment.experiment.make_blank(mainWindow,xcenter,ycenter,black,rect_position_right,0,0);    
    end
    
    %target image
    %if order(i) > 160
    %if round(rand()) == 0
    %    order(i) = order(i) -160;
        %ip = 1;%right
    %else
        %ip = 2;%left
    %end
    %imName1 = ['/home/nagailab/ドキュメント/nakajima/stimuli/' num2str(order(i)) '.jpeg'];
    imName1 = ['/home/nakajima/ドキュメント/研究室/研究データ/stimuli/' num2str(order1(i)) '.jpeg'];
    imdata1 = imread(imName1);    
    fprintf(fileID,'%d, ',order1(i));    
    
    exp_time.flip = M1_experiment.experiment.show_image(mainWindow,imdata1,image_position,xcenter,ycenter,rect_color,rect_position_right,exp_time.flip,exp_time.first);    
    
    %for blank
    exp_time.flip = M1_experiment.experiment.make_blank(mainWindow,xcenter,ycenter,black,rect_position_right,exp_time.flip,exp_time.present(order2(i)));
    
    % question
    Screen('close');
    %Screen('TextFont',mainWindow,'-:lang=ja');
    %Screen('TextSize', mainWindow, 50);
    exp_time.flip = M1_experiment.experiment.question(mainWindow,type_txt(type_num),black,rect_position_right,exp_time.flip,exp_time.blank(order2(i)));
    %answer
    result(i,2) = M1_experiment.experiment.wait_response(fileID,leftKey,rightKey);
    %%remain result 
    result(i,1) = order1(i);
    result(i,3) = order2(i);
    
end

save(resultID,'result');

% 終了:Doneと提示して 3 秒待機し閉じる。
Screen('TextSize', mainWindow, 100);
Screen('DrawText', mainWindow, 'Done', xcenter-110, ycenter);
Screen('Flip', mainWindow); 
WaitSecs(3);

ShowCursor;
Screen('CloseAll');
ListenChar(0);
fclose(fileID);