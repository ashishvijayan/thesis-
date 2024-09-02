clear;clc
% Prompt the user to choose a file
[file, path] = uigetfile('*.*', 'Choose MASTERDATA file');

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

% Specify the file path
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xls';

% Read the data from the CSV file
% data = readtable(filePath);
training = readmatrix(filePath);
%%

de1(:,1) = masterdata(:,16); %16 th column of data in first column of de1,
% column 16 (P in xls) has the direction error

de1(:,2) = training(1:end, 13);
%de1(:,2) = data(:,26); %26th column of data in second column of de1., 
% column 26 (Z) has cursor rotation (CR).  

de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1


rows_to_nan = de1(:,1) > 11 | de1(:,1) < -11 ;

de1(rows_to_nan, :) = 0;
% plot(de1(:,1))



y = de1(:,1);
% Define the number of trials per group
trialsPerGroup = 24;

% Calculate the number of groups
numGroups = length(y) / trialsPerGroup;



% Generate x values for plotting (assuming x is just the trial numbers)
x = 1:length(y);

% Preallocate arrays to store mean values and corresponding x values
meanY = zeros(1, numGroups);
xValues = zeros(1, numGroups);

for p = 1 : numGroups
    strt = (p-1)*trialsPerGroup + 1;
    stp = p*trialsPerGroup;
    mean_grp = mean(y(strt:stp,1));
    meanY(1,p) = mean_grp;
    
end
plot(meanY)
yline(0, '--');
xlim([1 12]);
xlabel('Trail bins');
ylabel('Mean direction error');
title(' mean direction error for each bin');
% 
% f = gcf;
% exportgraphics(f,'avg_bin_de_11.png','Resolution',300) %change plot name for participants
