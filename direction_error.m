% plot direction error
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
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx';

% Read the data from the CSV file
% data = readtable(filePath);
training = readmatrix(filePath);
%%

de1(:,1) = masterdata(:,16); %16 th column of data in first column of de1,
% column 16 (P in xls) has the direction error

de1(:,2) = training(1:end, 13);
%de1(:,2) = data(:,26); %26th column of data in second column of de1., 
% column 26 (Z) has cursor rotation (CR).  

% de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1


rows_to_nan = de1(:,1) > 100 | de1(:,1) < -100 ;

de1(rows_to_nan, :) = nan;

plot(de1(:,1))

% figure(1)
% plot(de1(1:24,1),'-x','Color', 'b');
% hold on
% plot(de1(312:336,1),'-o', 'Color', 'r');
% % legend('baseline', 'washout');
% % legend('show', 'Position', [0.15, 0.7, 0.1, 0.1]);
% % legend('show', 'Location', 'best');
% xlabel('trial order');
% ylabel('hand deviation');
% title('baseline & washout hand deviation')
% hold off
% legend({'baseline','washout'},'Location','northwest','Orientation','vertical')
% g = gcf;
% exportgraphics(g,'10020_BL_WO_hand_deviation.png','Resolution',192)
% 




% figure(2)
% plot(de1(312:336,1));
% xlabel('trial order');
% ylabel('hand deviation');
% title('washout hand deviation ')
% f = gcf;
% exportgraphics(f,'10017_washout_hand_deviation.png','Resolution',192)

% f = gcf;
% exportgraphics(f,'de_nikhita.png','Resolution',300) %change plot name for participants


% y = de1(:,1);
% % Define the number of trials per group
% trialsPerGroup = 24;
% 
% % Calculate the number of groups
% numGroups = length(y) / trialsPerGroup;
% 
% 
% 
% % Generate x values for plotting (assuming x is just the trial numbers)
% x = 1:length(y);
% 
% % Preallocate arrays to store mean values and corresponding x values
% meanY = zeros(1, numGroups);
% xValues = zeros(1, numGroups);
% 
% for p = 1 : numGroups
%     strt = (p-1)*trialsPerGroup + 1;
%     stp = p*trialsPerGroup;
%     mean_grp = mean(y(strt:stp,1));
%     meanY(1,p) = mean_grp;
% 
% end
% plot(meanY)
% yline(0, '--');
% xlim([1 12]);
% xlabel('Trail bins');
% ylabel('Mean direction error');
% title(' mean direction error for each bin');
% % 
% % f = gcf;
% % exportgraphics(f,'avg_bin_de_11.png','Resolution',300) %change plot name for participants
