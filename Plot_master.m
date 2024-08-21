clc;
close all;
clear all;

TargetX = (683)/12.4635;
TargetY = (768-465)/13.788;

Start_R_X = ((683))/12.4635;
Start_R_Y = (768-686)/13.788;

start_path = fullfile('D:\CoLA Lab\IN_mismatch\Experiment data\RapidD\'); % Define a starting folder.
topLevelFolder = uigetdir(start_path);
cd(topLevelFolder);
if topLevelFolder == 0
    return;
end

id= input("ID=","s");

id= str2num(id);
if id>30000 && id<30099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Slow_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Slow_training.xls';
elseif id>20000 && id<20099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Med_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Med_training.xls';
elseif id>10000 && id<10099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Fast_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Fast_training.xls';
elseif id>40000 && id<40099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Rapid_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Rapid_training.xls';
elseif id>50000 && id<50099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Fast+-_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Fast+-_training.xls';
elseif id>60000 && id<60099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Med+-_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Med+-_training.xls';
elseif id>70000 && id<70099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Slow+-_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Slow+-_training.xls';
elseif id>80000 && id<80099
    pathname1= 'D:\CoLA Lab\IN_mismatch\Sheets\Rapid+-_targets.xls';  
    pathname2= 'D:\CoLA Lab\IN_mismatch\Sheets\Rapid+-_training.xls';
end

targetnfile = xlsread(pathname1);
trainingnfile = xlsread(pathname2);

% [targetnfiletoreadt, pathname] = uigetfile('*.*','select the targetfile','D:\CoLA Lab\IN_mismatch\Sheets');
% if isequal(targetnfiletoreadt,0)
%    disp('User selected Cancel')
% end
% targetnfiletoread = fullfile(pathname,targetnfiletoreadt);
%  
% targetnfile = xlsread(targetnfiletoread);
% 
% [trainingnfiletoreadt, pathname] = uigetfile('*.*','select the trainingfile','D:\CoLA Lab\IN_mismatch\Sheets');
% if isequal(trainingnfiletoreadt,0)
%    disp('User selected Cancel')
% end
% trainingnfiletoread = fullfile(pathname,trainingnfiletoreadt);
%  
% trainingnfile = xlsread(trainingnfiletoread);


id=num2str(id);

slashlocations = find(topLevelFolder == '\');
[r, c] = size(slashlocations);
foldertest = topLevelFolder(slashlocations(end)+1:end);
  

% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);

for k = 1 : numberOfFolders
    % Get this folder and print it out.
    thisFolder = listOfFolderNames{k};
   
    % Get text files.
    filePattern = sprintf('%s/*_withangles.csv', thisFolder);

    %global baseFileNames
    baseFileNames = dir(filePattern);

    % global numberOfTextFiles
    numberOfTextFiles = length(baseFileNames);

    % Sort the files based on their names.
    [~, order] = sort({baseFileNames.name});
    baseFileNames = baseFileNames(order);
end
legends= [];
if numberOfTextFiles >= 1
    for f = 1:numberOfTextFiles
        csvFileName = baseFileNames(f).name;
        
        % Construct the full file path
        fullFilePath = fullfile(thisFolder, csvFileName);

        data = csvread(fullFilePath);

        if data(12,60)<9999
            end_rhx = data(12,60); 
            end_rhy = data(13,60);
            srt_rhx = data(10,60); 
            str_rhy = data(11,60);
            
            peakvelocity_r = data(1,60);
            startmovement_r = data(9,60);
            endmovement_r = data(15,60);
    
            % Define the regular expression pattern
            pattern = 'ts_0(\d+)_0(\d+)_withangles.csv';
            
            % Match the pattern in the file name
            tokens = regexp(csvFileName, pattern, 'tokens');
            
            % Extract trial number values
            trialNumber = str2double(tokens{1}{1});
  
            r_end_X(trialNumber) =end_rhx;
            r_end_y(trialNumber) =end_rhy;
    
            r_str_X(trialNumber) =srt_rhx;
            r_str_y(trialNumber) =str_rhy;
         
            trial_no(trialNumber) = trialNumber;

            if end_rhy<14
                figure;
                plot(data(:,58));
                TN= trialNumber;
                title( ['TrialNo:', mat2str(TN),'    EndpointY:',  mat2str(end_rhy), '   PeakVelocity:', mat2str(peakvelocity_r)])
                hold on
                plot(data(:,2))
            end
        end
    end   
end

dataout= [trial_no; r_str_X; r_str_y; r_end_X; r_end_y]';

figure;
plot(1:2:length(r_end_y),(r_end_y(1:2:end)),'LineWidth',1.5)
hold on
plot(2:4:length(r_end_y),(r_end_y(2:4:end)),'LineWidth',1.5)
plot(4:4:length(r_end_y),(r_end_y(4:4:end)),'LineWidth',1.5)
plot(1:2:240,((768-targetnfile(trainingnfile(1:2:240,5),7))/13.788),'LineWidth',1.5)
yline(TargetY,'--',"Base")
yline(TargetY+5,'--',"Base+5")
yline(TargetY+10,'--',"Base+10")
xline(121,'--',"2nd Shift")
title(id)
legend("VP","P","V","Vtarget")
xlim([0 270])
hold off

writeD= input("Want to write file:");

if writeD==1

    % % Specify the Excel file name
    FileName = strcat(id,'_master_output_data.xlsx');
    
    % Write the numerical array to the Excel file
    writematrix(dataout, FileName);
    
    id= str2num(id);
    if id>30000 && id<30099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\Slow\')
    elseif id>20000 && id<20099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\Med\')
    elseif id>10000 && id<10099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\Fast\')
    elseif id>40000 && id<40099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\Rapid\')
    elseif id>50000 && id<50099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\FastD\')
    elseif id>60000 && id<60099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\MedD\')
    elseif id>70000 && id<70099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\SlowD\')
    elseif id>80000 && id<80099
        cd('D:\CoLA Lab\IN_mismatch\Group_data\RapidD\')
    end
    writematrix(dataout, FileName);
    
    cd('D:\CoLA Lab\IN_mismatch');
end