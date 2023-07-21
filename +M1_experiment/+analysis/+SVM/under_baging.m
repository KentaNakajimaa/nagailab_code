function [pre, score_baging] = under_baging(data,reaction,iter_no)

    score_baging = zeros(1,iter_no);
    
    for iter = 1:iter_no
        [data_temp,reaction_temp] = M1_experiment.analysis.SVM.under_sampling(data,reaction);
        %[data_temp,reaction_temp] = under_sampling_pairwise(data,reaction);
        %score_baging(iter) = SVM_predict_pca_zscore(data_temp,reaction_temp);
        score_baging(iter) = M1_experiment.analysis.SVM.SVM_predict(data_temp,reaction_temp);
        %score_baging(iter) = SVM_predict_kernel_pca(data_temp,reaction_temp);
        
    end
    pre = mean(score_baging);
end