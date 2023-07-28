%check correct answer
clear

tstart = tic;
home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
subjects = {'aso','miyoshi','hanada','horiuchi','dogu','takanashi'};
type = {'gloss', 'beautiful'};
time_type = {'1000ms','150ms','66ms'};%, 'short_1', 'short_2'};
%type = {'short_3'}
cd(home_path);
ex_cnt = 4;
use_img_no = 20;
%load('/home/nakajima/ドキュメント/研究室/研究データ/M1実験/予備実験/0614/test_0613.mat');
for type_id = 1:length(type)
    for time_no = 1:length(time_type)
        mean_RDM = zeros(length(subjects),196);
        mean_accuracy = zeros(length(subjects),196);
        for subj = 1:length(subjects)
            for iter = 1:ex_cnt
                res = zeros(use_img_no,3);
                filename = [home_path 'subjects/' subjects{subj} '/' type{type_id} '_' subjects{subj} '_' num2str(iter) '.mat'];
                load(filename);
                for i =1:length(result)
                    %res(find(use_image_ID==result(i,1)),type_id) = res(find(use_image_ID==result(i,1)),type_id) + result(i,2)-1;
                    res(result(i,1),result(i,3)) = res(result(i,1),result(i,3)) + result(i,2)-1;
                end
            end
    
            filename = [home_path 'RDM/' subjects{subj} '_pairwize_' type{type_id} '_' time_type{time_no} '.mat'];
            load(filename);
            RDM2 = pdist2(res(:,time_no)/10,res(:,time_no)/10);
            time_course = zeros(1,196);
            RDM2 = reshape(RDM2,1,400);
            score_mean = zeros(1,196);
            for t = 1:196
                RDM = score(:,:,t);
                RDM = reshape(RDM,1,400);
                idx = RDM ==0;
                RDM = RDM(1,~idx);
                RDM3 = RDM2(1,~idx);

                time_course(1,t) = corr2(RDM3,RDM);
                score_mean(1,t) = mean(RDM);


            end
            plot(times,time_course);
            title([type{type_id} '-' time_type{time_no} '-' num2str(subj) ]);
            %saveas(gcf,['/home/nakajima/ドキュメント/研究室/移行用/20230622/' cate '_' cate2 '_rdm_timecorse_spearman.png']);
            saveas(gcf,[home_path 'imgae/RDM_img/' subjects{subj} '_' type{type_id} '_' time_type{time_no} '.png']);
            
            plot(times,score_mean);
            title([type{type_id} '-' time_type{time_no} '-' num2str(subj) '-mean accuracy']);
            %saveas(gcf,['/home/nakajima/ドキュメント/研究室/移行用/20230622/' cate '_' cate2 '_rdm_timecorse_spearman.png']);
            saveas(gcf,[home_path 'image/RDM_img/' subjects{subj} '_' type{type_id} '_' time_type{time_no} '_mean_accuracy_timecorse.png']);
            
            mean_RDM(subj,:) = time_course;
            mean_accuracy(subj,:) = score_mean;

        end
        plot(times,mean(mean_RDM,1));
        title([type{type_id} '-' time_type{time_no} '-mean' ]);
        %saveas(gcf,['/home/nakajima/ドキュメント/研究室/移行用/20230622/' cate '_' cate2 '_rdm_timecorse_spearman.png']);
        saveas(gcf,[home_path 'image/RDM_img/' type{type_id} '_' time_type{time_no} '_mean_' num2str(length(subjects)) '.png']);
            
        plot(times,mean(mean(mean_accuracy),1));
        title([type{type_id} '-' time_type{time_no} '-mean accuracy']);
        %saveas(gcf,['/home/nakajima/ドキュメント/研究室/移行用/20230622/' cate '_' cate2 '_rdm_timecorse_spearman.png']);
        saveas(gcf,[home_path 'image/RDM_img/' type{type_id} '_' time_type{time_no} '_mean' num2str(length(subjects)) '_accuracy_timecorse.png']);
            
    end
end


%image(RDM_gloss,'CDataMapping','scaled')
%colorbar

%RDM = pdist2(rate(71,:).',rate(71,:).');
%image(RDM,'CDataMapping','scaled')
%colorbar