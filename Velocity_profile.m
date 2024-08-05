close all
clear all

% hand_offset = 10*12.4635;
% 
% TargetX = (683)/12.4635;
% TargetY = (768-383)/13.788;
% 
% Start_R_X = ((683+hand_offset))/12.4635;
% Start_R_Y = (768-604)/13.788;
% 
% Start_L_X = ((683-hand_offset))/12.4635;
% Start_L_Y = (768-604)/13.788;
% 
% shared_Sx = (683)/12.4635;
% shared_Sy = (768-604)/13.788;


start_path = fullfile('D:\'); % Define a starting folder.
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

legends=[];

if numberOfTextFiles >= 1
    for f = 1:numberOfTextFiles
        csvFileName = baseFileNames(f).name;
        
        % Construct the full file path
        fullFilePath = fullfile(thisFolder, csvFileName);

        data = csvread(fullFilePath);

        % Define the regular expression pattern
        pattern = 'ts_(\d+)_(\d+)_withangles.csv';
        
        % Match the pattern in the file name
        tokens = regexp(csvFileName, pattern, 'tokens');
        
        % Extract trial number values
        trialNumber = str2double(tokens{1}{1});
%         plot(data(:, 58));
%         hold on
        if trialNumber>0 
            x=data(:, 58);
            y=find(x==(max(data(:, 58))));
            mv=max(data(:, 58));
            z=find(x==(min(data(y:end, 58))));
            if ((data(end, 58)))>0 %&& y(1)>240 %&& z>150 % %&& y(1)<250
                plot(data(:, 58));
                hold on
                TN= (trialNumber);
                
                if TN<100
                    TN=TN+900;
                end

                legends= [legends; mat2str(TN) ];
            end
        end
        
    end
    legend((legends))
end


% title("Participant 4, endpoint velocity threshold 5, no of points 33")

% Data_Store = [trial_no', pll_dev_R', pll_dev_L', perp_dev_R', perp_dev_L'];
% 
% 
% % plot(TargetX,TargetY,'.', 'MarkerSize', 30)
% % plot(shared_Sx, shared_Sy, '.', 'MarkerSize', 30)
% % 
% figure;
% plot(Data_Store(:,1), Data_Store(:,2))
% hold on
% plot(Data_Store(:,1), Data_Store(:,3))
% xline(50,'--');
% xline(100,'--');
% xline(150,'--');
% xline(200,'--');
% xline(250,'--');
% xline(300,'--');
% yline(0,'--')
% hold off
% 
% axis([0 inf -15 15])
% legend("Right Hand", "Left Hand")
% xlabel("Trial Number")
% ylabel("Parallel Deviation")
% 
% 
% 
% % Data_Store(:,4) = Data_Store(:,4);
% % Data_Store(:,5) = Data_Store(:,5);
% 
% 
% figure;
% plot(Data_Store(:,1), Data_Store(:,4))
% hold on
% plot(Data_Store(:,1), Data_Store(:,5)) 
% xline(50,'--');
% xline(100,'--');
% xline(150,'--');
% xline(200,'--');
% xline(250,'--');
% xline(300,'--');
% yline(0,'--')
% hold off
% 
% axis([0 inf -15 15])
% legend("Right Hand", "Left Hand")
% xlabel("Trial Number")
% ylabel("Perpendicular Deviation")
% 
% 
% 
% % [targetnfiletoreadt, pathname] = uigetfile('','select training file');
% % %[filename, pathname] = uigetfile('*.m', 'Select a MATLAB code file');
% % if isequal(targetnfiletoreadt,0)
% %    disp('User selected Cancel')
% % 
% % end
% % targetnfiletoread = fullfile(pathname,targetnfiletoreadt);
% % %targetnfile = xlsread('C:\Users\adarsh\Desktop\thesis1targetleft.xlsx')
% % 
% % targetnfile = xlsread(targetnfiletoread);
% % 
% % gain_lx = targetnfile(:,21);
% % gain_ly = targetnfile(:,22);
% % gain_rx = targetnfile(:,23);
% % gain_ry = targetnfile(:,24);
% % 
% % 
% % for i = 1:length(trial_no)
% %     shared_cx(i) = ((l_end_x(i)*gain_lx(trial_no(i))) + (r_end_X(i)*gain_rx(trial_no(i))))/2;
% %     shared_cy(i) = ((l_end_y(i)*gain_ly(trial_no(i))) + (r_end_y(i)*gain_ry(trial_no(i))))/2;
% % end
% % 
% % 
% % 
% % plot(l_end_y)
% % hold on
% % plot(r_end_y)
% % legend("Left","right")
% % hold on
% % plot(shared_cy)
% % hold on
% % yline(16)
% % hold on
% % yline(15,'--')
% % yline(17,'--')