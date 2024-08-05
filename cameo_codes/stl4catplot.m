clear;clc
% plots stl for all 4 categories
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
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx';

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


% rows_to_nan = de1(:,1) > 11 | stl(:,1) < -11 ;
% de1(rows_to_nan, :) = NaN;



stl = diff(de1(:,1)); %stl calculation

%adding cursor rotation of the previous trial to each stl 
for j=1:length(stl)
    stl(j,2) = de1(j,2);
end



rows_to_nan = stl(:,1) > 10 | stl(:,1) < -10 ;

stl(rows_to_nan, :) = nan;

% plot(stl(:,1))
% g = gcf;
% exportgraphics(g,'stl2.png','Resolution',192)


% figure(1)
% plot(stl(:,1));
% xlabel('trial order');
% ylabel('STL');
% title('STL over trial')
% g = gcf;
% exportgraphics(g,'stl_10028.png','Resolution',192)
% 
% %JT tied to 11 deg, NJ tied to 7 deg
% %counts of trials in each condition
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
% 
% %classifiying stl based on cursor rotation in the previous trial
% 
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

tiledlayout(2,2);
nexttile

plot(stl_JTPOS,'Color', 'red');
yline(0, '--');
title('JT POS')

nexttile

plot(stl_NJPOS,'Color', 'blue');
yline(0, '--');
title('NJ POS');

nexttile

plot(stl_JTNEG,'Color', 'green');
yline(0, '--');
title('JT NEG');


nexttile

plot(stl_NJNEG,'Color', 'magenta');
yline(0, '--');
title('NJ NEG');


% f = gcf;
% exportgraphics(f,'10028_stl4cat.png','Resolution',300) %change plot name for participants























% figure(1)
% plot(stl_JTPOS,'-x','Color', 'red');
% hold on
% plot(stl_NJPOS,'-o', 'Color', 'blue');
% hold on
% plot(stl_JTNEG,'-o', 'Color', 'green');
% hold on
% plot(stl_NJNEG,'-o', 'Color', 'magenta');
% % legend('baseline', 'washout');
% % legend('show', 'Position', [0.15, 0.7, 0.1, 0.1]);
% % legend('show', 'Location', 'best');
% xlabel('trial order');
% ylabel('stl');
% title('stl of 4 categories')
% hold off
% legend({'JTPOS','NJPOS', 'JTNEG', 'NJNEG'},'Location','northwest','Orientation','vertical')
% g = gcf;
% exportgraphics(g,'stl_category.png','Resolution',192)
