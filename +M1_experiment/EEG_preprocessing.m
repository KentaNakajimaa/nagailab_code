%% The time course of selective encoding and maintenance of task-relevant object features in working memory
% EEG preprocessing 
% @Andrea 2017

%% Load data and create an eeg file
% bpfilter
clear; 
close all

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/'; % path on server
subjects = {'hanada','takanashi'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path)

M1_experiment.analysis.preprocessing.EEG_preprocessing_bpfilter(home_path,subjects,type,ex_cnt);

%% edit events

clear; 
close all

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/';
subjects = {'hanada','takanashi'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path)

M1_experiment.analysis.preprocessing.EEG_preprocessing_edit_events(home_path,subjects,type,ex_cnt);
%% re-reference


%% Artifact detection

clear
close all

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/';
subjects = {'hanada','takanashi'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path);

M1_experiment.analysis.preprocessing.EEG_preprocessing_af_detect(home_path,subjects,type,ex_cnt);

%% Artifact rejection

clear
close all

home_path  = '/home/nakajima/ドキュメント/研究室/研究データ/M1実験/本実験/';
subjects = {'hanada','takanashi'};
type = {'gloss', 'beautiful'};
ex_cnt = 4;
cd(home_path)
M1_experiment.analysis.preprocessing.EEG_preprocessing_af_rejection(home_path,subjects,type,ex_cnt);
%% Make epochs

%% Downsample from 512 to 256Hz
