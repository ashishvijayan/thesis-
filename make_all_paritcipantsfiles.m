% by ashish
%this code outputs masterdata(de,cr) and stl of all the participants
clear;clc
% Specify the training file
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx';
training = readmatrix(filePath);
all_master = [] ;
all_stl = [] ;



%iterating throught all the masterdata
P = '/home/ashish/Desktop/thesis/expt/1revised_participants';
S = dir(fullfile(P,'*','org', 'processed','masterdata.csv'));
for k = 1 :numel(S)
    F = fullfile(S(k).folder,S(k).name);
    % masterdata = load(F);
    masterdata = readmatrix(F);

    

    columnToSortBy = 2;

    % Sort the entire matrix based on the specified column
    sortedMaster = sortrows(masterdata, columnToSortBy);

    de1 = [];
    %disp(S(k).folder)

    
    de1(:,1) = sortedMaster(:,16);  % column 16 (P in xls) has the direction error
    de1(:,2) = training(1:end, 13); % cursor rotation
    
    %all_master has de and cursor rotation of all trials for all
    %participants
    %each iteration will add new participant's de and cr
    
    all_master = [all_master, de1 ];
    % all_masters have all trials from 1-336


    de1 = de1(25:312,:); 
    %stl =[];
    stl = diff(de1(:,1)); %stl calculation 
    % this has stl value on 26 th trial due to 25 th trial
    %on 27th trial due 26th trial and so on..until
    % stl on 312th trial due to 311th trial

    %adding cursor rotation of the previous trial to each stl 
    for j=1:length(stl)
        stl(j,2) = de1(j,2);
    end

    %all_stl has stl of all participants
    all_stl = [all_stl,stl];

    
end


%writematrix(all_stl, '/home/ashish/Desktop/thesis/expt/all_stl.csv');
