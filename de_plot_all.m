filePath = 'C:\Users\IITGN\Desktop\ashish\expt\1revised_participants\all_master.csv'; 

all_master = readmatrix(filePath);


% figure('Position', [100, 100, 2000, 1000]);  % Set figure size to 20x10 inches
% for j = 1:length(all_master(1,:))
%     if mod(j,2) ~= 0 % odd column has de, even has CR
%         subplot(5, 10, j);
%         plot(all_master(:, j));
%     end
% end
% 
% % Display the figure
% set(gcf, 'Visible', 'on');


valueToReplace = 99999;


% Replace the specified value with NaN
all_master(all_master == valueToReplace) = NaN;


figure('Position', [100, 100, 3000, 2000]);  % Set figure size to 20x10 inches
for j = 1:length(all_master(1,:))
    if mod(j,2) ~= 0 % odd column has de, even has CR
        subplot(5, 10, j);
        plot(all_master(:, j));
        xlabel('trial order');
        ylabel('hand deviation');
 
    end
    
end

% Display the figure
set(gcf, 'Visible', 'on');
%title(' hand deviation for all 20 participants');
f = gcf;
exportgraphics(f,'de_all_participants.png','Resolution',300) %change plot name for participants
