% by ashish on may 29 2024
clear;clc
filePath = '/home/ashish/Desktop/thesis/expt/noncons_24.csv';
angles = readmatrix(filePath);

cr = zeros(336,1);
for j=24:288
    % disp('a')
    if mod(j,24) == 0
        % disp('b')
        
        for k= 1:length(angles)
            cr(j+k,1) = angles(k,1);
            


        end
    end
end

writematrix(cr, '/home/ashish/Desktop/thesis/expt/curs_rot.csv');
% writematrix(result, '/home/ashish/Desktop/thesis/expt/uniques24curs_rot.csv');






% % Define the values and their errors
% values = [97, 83, 101, 79];
% errors = [7, -7, 11, -11];
% 
% % Define the number of samples
% numSamples = 24;
% 
% % Initialize the result array
% result = zeros(1, numSamples);
% 
% % Define the counts for each value to ensure the error sum is zero
% % Example balanced solution:
% x = 6; % 6 values of 97
% y = 6; % 6 values of 83
% z = 6; % 3 values of 101
% w = 6; % 9 values of 79
% 
% % Check the constraints
% if (x + y + z + w ~= numSamples)
%     error('The counts do not sum to the total number of samples.');
% end
% 
% if (x*7 + y*(-7) + z*11 + w*(-11) ~= 0)
%     error('The error sum is not zero.');
% end
% 
% % Create the initial result array based on the counts
% initialResult = [repmat(97, 1, x), repmat(83, 1, y), repmat(101, 1, z), repmat(79, 1, w)];
% 
% % Function to shuffle array avoiding consecutive duplicates
% function shuffledArray = shuffleAvoidingConsecutives(array)
%     while true
%         shuffledArray = array(randperm(length(array)));
%         if all(diff(shuffledArray) ~= 0)
%             break;
%         end
%     end
% end
% 
% % Shuffle the result array avoiding consecutive duplicates
% result = shuffleAvoidingConsecutives(initialResult);
% 
% % Display the result
% disp('Sampled values:');
% disp(result);
% 
% % Calculate and display the sum of errors to verify
% error = result - 90;
% errorsum = sum(error);
% disp('Sum of errors:');
% disp(errorsum);