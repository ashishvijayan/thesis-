clear;clc
filePath = '/home/ashish/Desktop/thesis/expt/Training_ORG.xls';

training = readmatrix(filePath);

for row = 25:312 %column 9 has target jump location
    if training(row,13)  == 79 %column 13 has cursor rotation
        training(row,9) = 5;
    end
    if training(row,13)  == 101 
        training(row,9) = 3;
    end

    if training(row,13)  == 83 || training(row,13)  == 97
        training(row,9) = 1;
    end
   

end

writematrix(training, '/home/ashish/Desktop/thesis/expt/training_org.xls');
