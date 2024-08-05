%brute force average of all participants
writematrix(all_stl, '/home/ashish/Desktop/thesis/expt/all_stl.csv');


NJ_pos = 0;
NJ_neg = 0;
JT_pos = 0;
JT_neg = 0;

num_NJ_pos = 0;
num_NJ_neg = 0;
num_JT_pos = 0;
num_JT_neg = 0;

for c = 1:length(all_stl(1,:))


    if mod(c,2) ~= 0 %if the column index is odd
        for r = 1: length(all_stl(:,c))
            if (all_stl(r,c) > -10) && (all_stl(r,c) < 10)
                if all_stl(r,c+1) == 83
                    num_NJ_pos = num_NJ_pos + 1;
                    NJ_pos = NJ_pos + all_stl(r,c);
                end
                if all_stl(r,c+1) == 97
                    num_NJ_neg = num_NJ_neg + 1;
                    NJ_neg = NJ_neg + all_stl(r,c);
                end
                if all_stl(r,c+1) == 79
                    num_JT_pos = num_JT_pos + 1;
                    JT_pos = JT_pos + all_stl(r,c);
                end
                if all_stl(r,c+1) == 101
                    num_JT_neg = num_JT_neg + 1;
                    JT_neg = JT_neg + all_stl(r,c);
                end

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
exportgraphics(f,'2_bruteforce.png','Resolution',300) %change plot name for participants
