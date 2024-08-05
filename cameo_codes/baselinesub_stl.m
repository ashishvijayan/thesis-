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

[file, path] = uigetfile('*.*', 'Choose training_org file');

% Check if the user selected a file
if isequal(file,0) || isequal(path,0)
    disp('User canceled the operation');
else
    disp(['User selected file: ', fullfile(path, file)]);
    % Read the contents of the file into a matrix
    try
        training = readmatrix(fullfile(path, file));
        disp('File successfully read into a matrix');
        % Now you can work with the data
        %disp(data);
    catch
        disp('Error reading the file');
    end
end
%%

de1(:,1) = masterdata(:,16); %16 th column of data in first column of de1,
% column 16 (P in xls) has the direction error

de1(:,2) = training(1:end, 13);
%de1(:,2) = data(:,26); %26th column of data in second column of de1., 
% column 26 (Z) has cursor rotation (CR).  


%calculating mean de of baseline trials 1-24
de_bl = de1(1:24,1);
% pre = mean(de_bl) ;

for k = 1:length(de_bl)
    if de_bl(k)>20 || de_bl(k)<-20
    de_bl(k)=NaN;
    end
end

avg_bl = mean(de_bl) ; %avg baseline de

de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1


de_bsub = de1(:,1) - avg_bl; %de after baseline subtraction

stl1 = diff(de1(:,1)); %stl calculation
stl2 = diff(de_bsub(:)) ;


%adding cursor rotation of the previous trial to each stl 

for j=1:length(stl1)
    stl1(j,2) = de1(j,2);
end
stl = [stl1,stl2] ;







