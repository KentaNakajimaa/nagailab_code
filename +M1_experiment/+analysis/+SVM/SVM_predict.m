function p = SVM_predict(data,reaction)
    iter_no = 10;
    
    % closs validation
    % 10-fold
    partition = cvpartition(length(data(:,1)),'KFold',iter_no);
    score = zeros(1,iter_no);
    for closs_val = 1:iter_no
        
        id_train = training(partition,closs_val);
        id_test = test(partition,closs_val);
        data_train = data(id_train,:);
        data_test = data(id_test,:);
        reaction_train = reaction(id_train,:);
        reaction_test = reaction(id_test,:);
        
        %pca
        warning('off');
        %[coeff,scoreTrain,~,~,explained] = pca(data_train); 
        %idx = find(cumsum(explained)>95,1);
        %scoreTrain95 = scoreTrain(:,1:idx);
        %scoreTest95 = data_test*coeff(:,1:idx);
        
        %scoreTrain95 = zscore(scoreTrain95);
        %scoreTest95 = zscore(scoreTest95);
        mean_temp = mean(data_train);
        std_temp = std(data_train);
        %scoreTrain95 = (data_train-mean_temp)./std_temp;
        %scoreTest95 = (data_train-mean_temp)./std_temp;
        data_train = (data_train-mean_temp)./std_temp;
        data_test = (data_test-mean_temp)./std_temp;
        
        data_train = data_train.';
        %scoreTrain95 = scoreTrain95.';
        reaction_train = reaction_train.';
        
        % svm
        %SVMmodel = fitcsvm(scoreTrain95,reaction_train);
        SVMmodel = fitclinear(data_train,reaction_train,'ObservationsIn','columns','Learner','svm','Solver','sparsa','Regularization','lasso');
        %fitclinear(data_window,reaction,'ObservationsIn','columns','KFold',10,'Learner','svm','Solver','sparsa','Regularization','lasso','GradientTolerance',1e-8);
            
        predict_label = predict(SVMmodel,data_test);
        performance = (predict_label == reaction_test);
        predict_iter = sum(performance)/length(performance);
        score(closs_val) = predict_iter;
    end 
    
    p = mean(score);

end