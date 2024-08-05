% Step 1: Open folder selection dialog

NJ_pos = 0;
NJ_neg = 0;
JT_pos = 0;
JT_neg = 0;

num_NJ_pos = 0;
num_NJ_neg = 0;
num_JT_pos = 0;
num_JT_neg = 0;

folderPath = uigetdir;
% JTNeg_TTrial=0;
% Check if the user selected a folder
if folderPath == 0
    error('No folder selected');
else
    % Step 2: List all CSV files in the selected folder
    csvFiles = dir(fullfile(folderPath, '*.csv'));
    
    % Check if there are any CSV files in the folder
    if isempty(csvFiles)
        error('No CSV files found in the selected folder');
    else
        % Step 3: Process each CSV file
        for i = 1:length(csvFiles)
            if contains(csvFiles(i).name,'stl_JTNEG' )
                num_JT_neg = num_JT_neg + 1;

                % Get the full path of the CSV file
                csvFilePath = fullfile(folderPath, csvFiles(i).name);
                % disp(csvFiles(i).name)
                data = readmatrix(csvFilePath);
                
                JT_neg = JT_neg + mean(data(1,:));
                
 

             elseif contains(csvFiles(i).name,'stl_JTPOS' )
                 num_JT_pos = num_JT_pos + 1;
                % Get the full path of the CSV file
                 csvFilePath = fullfile(folderPath, csvFiles(i).name);
                % disp(csvFiles(i).name)
                data = readmatrix(csvFilePath);
                
                JT_pos = JT_pos + mean(data(1,:));


                 

             elseif contains(csvFiles(i).name,'stl_NJPOS' )
                 num_NJ_pos = num_NJ_pos + 1;
                % Get the full path of the CSV file
                csvFilePath = fullfile(folderPath, csvFiles(i).name);
                % disp(csvFiles(i).name)
                data = readmatrix(csvFilePath);
                
                NJ_pos = NJ_pos + mean(data(1,:));


                
            else %handles NJ_neg
                num_NJ_neg = num_NJ_neg + 1;
                csvFilePath = fullfile(folderPath, csvFiles(i).name);
                % disp(csvFiles(i).name)
                data = readmatrix(csvFilePath);
                
                NJ_neg = NJ_neg + mean(data(1,:));


                



             end
        end
    end
end


mean_NJ_pos = NJ_pos/num_NJ_pos;
fprintf('%s %d\n', 'mean of NJ positive: ', mean_NJ_pos);

mean_NJ_neg = NJ_neg/num_NJ_neg;
fprintf('%s %d\n', 'mean of NJ negative: ', mean_NJ_neg);

mean_JT_pos = JT_pos/num_JT_pos;
fprintf('%s %d\n', 'mean of JT positive: ', mean_JT_pos);

mean_JT_neg = JT_neg/num_JT_neg;
fprintf('%s %d\n', 'mean of JT negative: ', mean_JT_neg);


figure(1)

scatter(1,mean_JT_pos,"filled",'MarkerFaceColor', 'red' )
hold on
scatter(2,mean_NJ_pos,"filled",'MarkerFaceColor', 'blue')
scatter(3,mean_JT_neg,"filled", 'MarkerFaceColor', 'green')
scatter(4,mean_NJ_neg,"filled",'MarkerFaceColor', 'magenta')
% Display y-values near each scatter dot
text(1 + 0.1, mean_JT_pos, num2str(mean_JT_pos), 'FontSize', 8);
text(2 + 0.1, mean_NJ_pos, num2str(mean_NJ_pos), 'FontSize', 8);
text(3 + 0.1, mean_JT_neg, num2str(mean_JT_neg), 'FontSize', 8);
text(4 + 0.1, mean_NJ_neg, num2str(mean_NJ_neg), 'FontSize', 8);

xlim([0 5]);
ylim([-4 4]);
yline(0, '--');
legend('JTpos', 'NJpos', 'JTneg', 'NJneg');
xlabel('Categories');
ylabel('Mean Value');
title(' mean STL for all 4 condition of all  participants');
f = gcf;
exportgraphics(f,'grand_mean1wpar.png','Resolution',300) %change plot name for participants
