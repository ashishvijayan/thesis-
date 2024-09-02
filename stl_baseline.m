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
basecorr_de = zeros(1,length(de1));
for k=1:length(de_bl)
if de_bl(k)>20 || de_bl(k)<-20
    basecorr_de(k)=NaN;

else
    basecorr_de(k)=de_bl(k);
end
end

avg_bl = (sum(basecorr_de))/24;

% for z=1:length(de1)
%     if z<25
%     basecorr_de(z)= basecorr_de(z) - avg_bl;
%     else
%         basecorr_de(z) = de1(z,1) - avg_bl;
%     end
% end
for z = 1:


% de1 = de1(:,1) - avg_bl;
de2 = basecorr_de(25:312);

de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1


stl = diff(de2); %stl calculation

plot(stl)

%adding cursor rotation of the previous trial to each stl 

for j=1:length(stl)
    stl(j,2) = de1(j,2);
end

%baseline subtraction





%removing extreme stl due to '9999' or extreme DEs

% Threshold value kept to 10
upper_limit = 10;
lower_limit = -10 ;

% Create a logical array indicating rows to delete
rows_to_delete1 = stl(:,1) > upper_limit | stl(:,1) < lower_limit ;


stl(rows_to_delete1, :) = [];



figure(1)
plot(stl(:,1));

xlabel('trial order');
ylabel('STL');
title('STL over trial')





%g = gcf;
%exportgraphics(g,'stl_10001.png','Resolution',192)

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
% instantiate all these columns vectors with zero      
stl_JTPOS = zeros(1,num_JTPos); %cursor rotation = 79
stl_JTPOS1 = zeros(1,num_JTPos); %cursor rotation = 79 
%stl_JTPOS1 stores baseline subtracted stl
stl_JTNEG = zeros(1,num_JTNeg); %cursor rotation = 101
stl_JTNEG1 = zeros(1,num_JTNeg); %cursor rotation = 101

stl_NJPOS = zeros(1,num_NJPos); %cursor rotation = 83
stl_NJPOS1 = zeros(1,num_NJPos); %cursor rotation = 83

stl_NJNEG = zeros(1,num_NJNeg); %cursor rotation = 97 
stl_NJNEG1 = zeros(1,num_NJNeg); %cursor rotation = 97   

a = 0;
b = 0;
c = 0;
d= 0;
for j = 1: length(stl)
    if stl(j,2) == 79
        a = a +1;
        stl_JTPOS(a) = stl(j,1);
        stl_JTPOS1(a) = stl(j,3);
    end

    if stl(j,2) == 101
        b = b+1;
        stl_JTNEG(b) = stl(j,1);
        stl_JTNEG1(b) = stl(j,3);
    end

    if stl(j,2) == 83
        c = c +1 ;
        stl_NJPOS(c) = stl(j,1);
        stl_NJPOS1(c) = stl(j,3);
    end

    if stl(j,2) == 97
        d = d+1;
        stl_NJNEG(d) = stl(j,1);
        stl_NJNEG1(d) = stl(j,3);
    end
end


mean_stl_JTPOS = mean(stl_JTPOS);
mean_stl_JTNEG = mean(stl_JTNEG);
mean_stl_NJPOS = mean(stl_NJPOS);
mean_stl_NJNEG = mean(stl_NJNEG);

mean_stl_JTPOS1 = mean(stl_JTPOS1);
mean_stl_JTNEG1 = mean(stl_JTNEG1);
mean_stl_NJPOS1 = mean(stl_NJPOS1);
mean_stl_NJNEG1 = mean(stl_NJNEG1);


figure(2)
subplot(1, 2, 1);

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

xlim([0 5]);
ylim([-4 4]);
yline(0, '--');
legend('JTpos', 'NJpos', 'JTneg', 'NJneg');
xlabel('Categories');
ylabel('Mean STL');
title(' Mean STL');
%f = gcf;
%exportgraphics(f,'mean_stl_10011.png','Resolution',300) %change plot name for participants

subplot(1, 2, 2);
scatter(1,mean_stl_JTPOS1,"filled",'MarkerFaceColor', 'red' )
hold on
scatter(2,mean_stl_NJPOS1,"filled",'MarkerFaceColor', 'blue')
scatter(3,mean_stl_JTNEG1,"filled", 'MarkerFaceColor', 'green')
scatter(4,mean_stl_NJNEG1,"filled",'MarkerFaceColor', 'magenta')
% Display y-values near each scatter dot
text(1 + 0.1, mean_stl_JTPOS1, num2str(mean_stl_JTPOS1), 'FontSize', 8);
text(2 + 0.1, mean_stl_NJPOS1, num2str(mean_stl_NJPOS1), 'FontSize', 8);
text(3 + 0.1, mean_stl_JTNEG1, num2str(mean_stl_JTNEG1), 'FontSize', 8);
text(4 + 0.1, mean_stl_NJNEG1, num2str(mean_stl_NJNEG1), 'FontSize', 8);

xlim([0 5]);
ylim([-4 4]);
yline(0, '--');
legend('JTpos', 'NJpos', 'JTneg', 'NJneg');
xlabel('Categories');
ylabel('Mean STL');
title(' Mean STL after baseline subtraction');
%f = gcf;
%exportgraphics(f,'mean_stl_10011.png','Resolution',300) %change plot name for participants
