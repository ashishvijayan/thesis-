% by ashish
%this code outputs masterdata(de,cr) and stl of all the participants
clear;clc
% Specify the training file
filePath = 'C:\Users\IITGN\Desktop\ashish\expt\Training_ORG.xlsx';
%filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx'; linux
training = readmatrix(filePath);
all_master = [] ;
all_stl = [] ;



%iterating throught all the masterdata
P = 'C:\Users\IITGN\Desktop\ashish\expt\1revised_participants';
S = dir(fullfile(P,'*','org', 'processed','masterdata.csv'));
% look in P, at subfolder level and get masterdata
for k = 1 :numel(S)
    F = fullfile(S(k).folder,S(k).name);
    % masterdata = load(F);
    masterdata = readmatrix(F);
    
    columnToSortBy = 2;

    % Sort the entire matrix based on the specified column
    sortedMaster = sortrows(masterdata, columnToSortBy);

    de1 = [];
    disp(k)
    disp(S(k))
    
    de1(:,1) = sortedMaster(:,16);  % column 16 (P in xls) has the direction error
    de1(:,2) = training(1:end, 13); % putting cursor rotation alongside
    
    %all_master has de and cursor rotation of all trials for all
    %participants
    all_master = [all_master, de1 ]; %odd column has de, even has CR

    
end

%writematrix(all_stl, 'C:\Users\IITGN\Desktop\ashish\expt\1revised_participants\all_stl.csv')
% writematrix(all_master, 'C:\Users\IITGN\Desktop\ashish\expt\1revised_participants\all_master.csv')

    de1 = de1(25:312,:); 
    stl = diff(de1(:,1)); %stl calculation

    %adding cursor rotation of the previous trial to each stl 
    for j=1:length(stl)
        stl(j,2) = de1(j,2);
    end

    %all_stl has stl from trial 25 to 312 along w cr of prev trial
    all_stl = [all_stl,stl]; %odd column has stl, even has CR

