close all
clear all

start_path = fullfile(matlabroot, '\toolbox'); % Define a starting folder.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
    return;
end

slashlocations = find(topLevelFolder == '\');
[r, c] = size(slashlocations);
foldertest = topLevelFolder(slashlocations(end)+1:end);
%if strcmp(foldertest,'results')
  

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
    % [~, order] = sort({baseFileNames.name});
    % baseFileNames = baseFileNames(order);
end


if numberOfTextFiles >= 1
    for f = 1:numberOfTextFiles
        csvFileName = baseFileNames(f).name;
        
        % Construct the full file path
        fullFilePath = fullfile(thisFolder, csvFileName);

        data = csvread(fullFilePath);
        
        
        % Define the regular expression pattern
        pattern = 'ts_0(\d+)_0(\d+)_withangles.csv';
        
        % Match the pattern in the file name
        tokens = regexp(csvFileName, pattern, 'tokens');
        
        % Extract trial number values
        trialNumber = str2double(tokens{1}{1});
        
        if trialNumber>30 && trialNumber<60
            plot((1:length(data(:,58)))/120,data(:,58))
            hold on
        end
        
    end
end
