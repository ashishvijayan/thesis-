% NOW AUTOMATING MEAN STL FOR ALL PARTICIPANTS
clear;clc

% Specify the file path for training file
%filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xlsx'; 
filePath = 'C:\Users\IITGN\Desktop\ashish\expt\Training_ORG.xlsx';
training = readmatrix(filePath);
%%

P = 'C:\Users\IITGN\Desktop\ashish\expt\1revised_participants';
S = dir(fullfile(P,'*','org', 'processed','masterdata.csv'));
% look in P, at subfolder level and get masterdata
for k = 1: numel(S)
    
    F = fullfile(S(k).folder,S(k).name);
    disp(k);
    % masterdata = load(F);
    masterdata = readmatrix(F);
    
    columnToSortBy = 2;
    

    % Sort the entire matrix based on the specified column
    sortedMaster = sortrows(masterdata, columnToSortBy);
    de1 = [];
    de1(:,1) = sortedMaster(:,16); %16 th column of sortedMaster in first column of de1,
    % column 16 (P in xls) has the direction error
    
    de1(:,2) = training(1:end, 13); % puttting  CR in the adjacent column
     
    de1 = de1(25:312,:);  %now de1 has only rows from 25 to 312 of de1
     
    
    rows_to_del = de1(:,1) > 35 | de1(:,1) < -35 ;
    de1(rows_to_del, :) = [];
    stl =[];
    stl = diff(de1(:,1)); %stl calculation
    
    %adding cursor rotation of the previous trial to each stl 
    for j=1:length(stl)
        stl(j,2) = de1(j,2);
    end
%%
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
    
    %%
    
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
    title(sprintf('Mean STL of Participant %d', k));


    filename = sprintf('%d_mean_stl.png', k);
   

    exportgraphics(gca,filename,'Resolution',300) %change plot name for participants
    close;
     
end





























 



