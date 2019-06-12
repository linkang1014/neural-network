%%
%INPUT
clear all;
close all;
load('testing_0.mat');load('testing_1.mat');load('training_0.mat');load('training_1.mat');
i=50;

x1 = cat(1,training_0,training_1);
x2 = im2double(x1);

y1 = zeros(450,1);
y2 = ones(450,1);
Y = cat(1,y1,y2);%design output

x1_test = cat(1,testing_0,testing_1);
x2_test = im2double(x1_test);

y1_test = zeros(50,1);
y2_test = ones(50,1);
Y_test = cat(1,y1_test,y2_test);%design test output
%%
%CACULATION
net = patternnet(i);
net.layers{1}.transferFCn='tansig';% set hidden layer 'logsig'
net.layers{2}.transferFCn='logsig';% set output layer 'logsig'
% net.performParam.regularization = 0.5;
net.trainparam.lr=0.01;
net.trainparam.epochs=1000;
net.trainparam.goal=1e-8;
net.divideParam.trainRatio=0.01;
net.divideParam.valRatio=0.0;
net.divideParam.testRatio=0.0;
% [net,tr]=adapt(net,x2',Y');
for i = 1 : 1000
    index = randperm(size(x2, 1));
    net = adapt(net,x2(index,:)',Y(index,:)');
end

% [net,tr] = train(net,x2',Y');
% plotperform(tr);
net_output = sim(net,x2');
%%
%EVALUATE THE PERFORMANCE OF THE NETWORK
%TRAINING SET TEST
num_accuracy_train = 0;
for j = 1:900
    if net_output(j) >=0.8
        y(j) = 1.0;
    else
        y(j) = 0;
    end
    if (((Y(j)== 0) && (y(j)== 0))||((Y(j)== 1.0) && (y(j)==1.0)))
        num_accuracy_train = num_accuracy_train +1;
    end
end


%VALIDATION SET TEST
num_accuracy_test = 0;
x0_test = ones(100,1);
x1_test = cat(1,testing_0,testing_1);
x2_test = im2double(x1_test);
x_test = cat(2,x0_test,x2_test);%test input
y1_test = zeros(50,1);
y2_test = ones(50,1);
Y_test = cat(1,y1_test,y2_test);%design test output
net_output2 = sim(net,x2_test');

for j = 1:100
    if  net_output2(j)>=0.8
        y_test(j) = 1.0;
    else
        y_test(j) = 0;
    end
    if (((Y_test(j)== 0) && (y_test(j)== 0))||((Y_test(j)== 1.0) && (y_test(j)==1.0)))
        num_accuracy_test  = num_accuracy_test +1;
    end
end





