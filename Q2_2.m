%%CACULATION
close all;
clear all;
i=100;
x = -1.6:0.05:1.6;
y = 1.2*sin(pi*x) - cos(2.4*pi*x);
net = feedforwardnet(i,'trainlm');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net,x,y);
net.trainparam.lr=0.01;
net.trainparam.epochs=1000;
net.trainparam.goal=1e-8;
net.divideParam.trainRatio=1.0;
net.divideParam.valRatio=0.0;
net.divideParam.testRatio=0.0;
[net,tr] = train(net,x,y); 

xtest = -3:0.01:3;
ytest = 1.2*sin(pi*xtest) - cos(2.4*pi*xtest);
net_output = sim(net,xtest);

%OUTPUT
x_design_output=-3:0.01:3;
y_design_output=1.2*sin(pi*x_design_output) - cos(2.4*pi*x_design_output);

plot(x,y,'b*');
hold on;
plot(xtest,net_output,'r--');
plot(x_design_output,y_design_output,'k-');
legend('Test set','MLP output','Origin function')
hold off
discription1 = sprintf('The number of hidden neurons = %d',i);
title(discription1,'FontSize',20);
set(gca,'FontSize',12);
discription2 = sprintf('Q3_1_%d.jpg',i);
saveas(gcf,discription2);