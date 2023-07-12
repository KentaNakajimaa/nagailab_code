%check correct answer
clear
home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/B4実験/脳波データ/'; % path on server
subjects = {'nakajima','asou','takanashi','inoue','hanada','koizumi','nohira','horiuchi'};
%%high = 1 low = 2
res_gloss = zeros(160,length(subjects));
res_beautiful = zeros(160,length(subjects));
for subj = 1:length(subjects)
    
    filename = [home_path subjects{subj} '/gloss_' subjects{subj} '.mat'];
    load(filename);
    idx = result(:,1) ==0;
    result= result(~idx,:);
    for i =1:length(result)
        res_gloss(result(i,1),subj) = res_gloss(result(i,1),subj) + result(i,7);
    end
        
end
%%
for subj = 1:length(subjects)
    
    filename = [home_path subjects{subj} '/beautiful_' subjects{subj} '.mat'];
    load(filename);
    idx = result(:,1) ==0;
    result= result(~idx,:);
    for i =1:length(result)
        res_beautiful(result(i,1),subj) = res_beautiful(result(i,1),subj) + result(i,7);
    end
end
%res_gloss2 = mean(res_gloss,2);
%res_beautiful2 = mean(res_beautiful,2);
res = [res_gloss res_beautiful];
test_1 = [4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4];%low low
test_2 = [4,4,4,4,4,4,4,4,2,2,2,2,2,2,2,2];%low high
test_3 = [2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4];%high low
test_4 = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];%high high
res_temp = res==test_1;
res_1 = find(mean(res_temp,2)==1);
%res_temp = res==test_2;
%res_2 = find(mean(res_temp,2)>0.6);
res_2 = [6;55;113;118;159];
%157,158,139
%114
res_temp = res==test_3;
res_3 = find(mean(res_temp,2)>0.73);
res_temp = res==test_4;
res_4 = find(mean(res_temp,2)>0.8);
use_image_ID = [randsample(res_1,5);randsample(res_2,5);randsample(res_3,5);randsample(res_4,5)];
%save('/home/nakajima/ドキュメント/研究室/研究データ/M1実験/image_list.mat','use_image_ID');