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
% Specify the file path
%filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx'; 
filePath = 'C:\Users\IITGN\Desktop\ashish\expt\Training_ORG.xlsx';

% Read the data from the CSV file
% data = readtable(filePath);
training = readmatrix(filePath);
%%

%%sort masterdata based on trial number in column 2

columnToSortBy = 2;

% Sort the entire matrix based on the specified column
sortedMaster = sortrows(masterdata, columnToSortBy);



de1(:,1) = sortedMaster(:,16); %16 th column of data in first column of de1,
% column 16 (P in xls) has the direction error
de1(:,2) = training(1:end, 13);
%de1(:,2) = data(:,26); %26th column of data in second column of de1., 
% column 26 (Z) has cursor rotation (CR).  

rows_to_NaN = de1(:,1) > 35 | de1(:,1) < -35 ;
de1(rows_to_NaN, :) = nan;

plot(de1(:,1))