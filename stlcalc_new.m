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
de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1

rows_to_del = de1(:,1) > 35 | de1(:,1) < -35 ;
de1(rows_to_del, :) = [];

stl = diff(de1(:,1)); %stl calculation

%adding cursor rotation of the previous trial to each stl 
for j=1:length(stl)
    stl(j,2) = de1(j,2);
end




% figure(1)
% plot(stl(:,1));
% xlabel('trial order');
% ylabel('STL');
% title('STL over trial')
% g = gcf;
% exportgraphics(g,'stl_10002.png','Resolution',192)

%JT tied to 11 deg, NJ tied to 7 deg
%counts of trials in each condition
curs_rot = unique(stl(:, 2));
num_NJPos = 0;
num_NJNeg = 0;
num_JTNeg = 0;
num_JTPos = 0;

for j = 1: length(stl)
    if stl(j,2) == 79
        num_JTPos = num_JTPos + 1;

    elseif stl(j,2) == 101
        num_JTNeg = num_JTNeg + 1;

    elseif stl(j,2) == 83
        num_NJPos = num_NJPos + 1;

    elseif stl(j,2) == 97
        num_NJNeg = num_NJNeg + 1;
      
    end
end

num_NJPos ;
num_NJNeg ;
num_JTNeg ;
num_JTPos ;

%classifiying stl based on cursor rotation in the previous trial
      
stl_JTPOS = zeros(1,num_JTPos); %cursor rotation = 79
stl_JTNEG = zeros(1,num_JTNeg); %cursor rotation = 101
stl_NJPOS = zeros(1,num_NJPos); %cursor rotation = 83
stl_NJNEG = zeros(1,num_NJNeg); %cursor rotation = 97   
a = 0;
b = 0;
c = 0;
d= 0;
for j = 1: length(stl)
    if stl(j,2) == 79
        a = a +1;
        stl_JTPOS(a) = stl(j,1);
    end

    if stl(j,2) == 101
        b = b+1;
        stl_JTNEG(b) = stl(j,1);
    end

    if stl(j,2) == 83
        c = c +1 ;
        stl_NJPOS(c) = stl(j,1);
    end

    if stl(j,2) == 97
        d = d+1;
        stl_NJNEG(d) = stl(j,1);
    end
end
%saving files locally
% writematrix(stl_JTPOS, '/home/ashish/Desktop/thesis/expt/stl_csv/10002_stl_JTPOS.csv');
% writematrix(stl_JTNEG, '/home/ashish/Desktop/thesis/expt/stl_csv/10002_stl_JTNEG.csv');
% writematrix(stl_NJPOS, '/home/ashish/Desktop/thesis/expt/stl_csv/10002_stl_NJPOS.csv');
% writematrix(stl_NJNEG, '/home/ashish/Desktop/thesis/expt/stl_csv/10002_stl_NJNEG.csv');


mean_stl_JTPOS = mean(stl_JTPOS);
mean_stl_JTNEG = mean(stl_JTNEG);
mean_stl_NJPOS = mean(stl_NJPOS);
mean_stl_NJNEG = mean(stl_NJNEG);


figure(2)

scatter(1,mean_stl_JTPOS,"filled",'MarkerFaceColor', 'red' )
hold on
scatter(2,mean_stl_NJPOS,"filled",'MarkerFaceColor', 'blue')
scatter(3,mean_stl_JTNEG,"filled", 'MarkerFaceColor', 'green')
scatter(4,mean_stl_NJNEG,"filled",'MarkerFaceColor', 'magenta')
% Display y-values near each scatter dot
text(1 + 0.1, mean_stl_JTPOS, num2str(mean_stl_JTPOS), 'FontSize', 8);
text(2 + 0.1, mean_stl_NJPOS, num2str(mean_stl_NJPOS), 'FontSize', 8);
text(3 + 0.1, mean_stl_JTNEG, num2str(mean_stl_JTNEG), 'FontSize', 8);
text(4 + 0.1, mean_stl_NJNEG, num2str(mean_stl_NJNEG), 'FontSize', 8);

xlim([0 6]);
ylim([-4 4]);
yline(0, '--');
legend('JTpos', 'NJpos', 'JTneg', 'NJneg');
xlabel('Categories');
ylabel('Mean Value');
title(' mean STL for all 4 condition');
% f = gcf;
% exportgraphics(f,'mean_stl_10002.png','Resolution',300) %change plot name for participants
