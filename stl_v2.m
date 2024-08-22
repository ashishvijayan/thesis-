% outputs stl over trial, category wise stl, mean stl comparison
clear;clc
% Prompt the user to choose a file
[file, path] = uigetfile('*.*', 'Choose MASTERDATA file');

alldata_dir = dir();

% Check if the user selected a file
if isequal(file,0) || isequal(path,0)
    disp('User canceled the operation');
else
    disp(['User selected file: ', fullfile(path, file)]);
    % Read the contents of the file into a matrix
    try
        masterdata = readmatrix(fullfile(path, file));
        disp('File successfully read into a matrix');
        % Now you can work with the data
        %disp(data);
    catch
        disp('Error reading the file');
    end
end
%%
% opens training file
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx';
% Read the training file
training = readmatrix(filePath);
%%
%sort masterdata based on trial number in column 2

columnToSortBy = 2;

% Sort the entire matrix based on the specified column
sortedMaster = sortrows(masterdata, columnToSortBy);
de1(:,1) = sortedMaster(:,16); %16 th column of masterdata in first column of de1,
% column 16 (P) has the direction error

de1(:,2) = training(1:end, 13);
%de1(:,2) is being populted with cursor rotation from training file

de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1
%since first and last 24 trials are baseline and washout respectively

rows_to_NaN = de1(:,1) > 25 | de1(:,1) < -25 ;
de1(rows_to_NaN, 1) = NaN;

%find the indices of NaN rows
[nan_indices] = find(isnan(de1(:,1)));
A = de1(:,1);
%segments = [0; nan_indices; length(A) + 1];
segments = [1,10];

% Loop through each segment and compute differences
for i = 1:length(segments) - 1
    start_idx = segments(i) + 1;
    end_idx = segments(i+1) - 1;
    
    if start_idx <= end_idx
        % Compute the difference for this segment
        result(start_idx+1:end_idx) = diff(A(start_idx:end_idx));
    end
end


