%%CACULATION
close all;
clear all;
k=100;
x = -1.6:0.05:1.6;
y = 1.2*sin(pi*x) - cos(2.4*pi*x);
net = feedforwardnet(k,'traingd');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net,x,y);
net.trainparam.lr=0.01;
net.trainparam.epochs=10000;
net.trainparam.goal=1e-8;
net.divideParam.trainRatio=1.0;
net.divideParam.valRatio=0.0;
net.divideParam.testRatio=0.0;
[net,tr]=adapt(net,x,y);
for i = 1 : 10000
    index = randperm(65);
    net = adapt(net,x(:,index),y(index));
end

xtest = -3:0.01:3;
ytest = 1.2*sin(pi*xtest) - cos(2.4*pi*xtest);
net_output = sim(net,xtest);

%%OUTPUT
x_design_output=-3:0.01:3;
y_design_output=1.2*sin(pi*x_design_output) - cos(2.4*pi*x_design_output);

plot(x,y,'b*');
hold on;
plot(xtest,net_output,'r--');
plot(x_design_output,y_design_output,'k-');
legend('Test set','MLP output','Origin function')
hold off
discription1 = sprintf('The number of hidden neurons = %d',k);
title(discription1,'FontSize',20);
set(gca,'FontSize',12);
discription2 = sprintf('Q2_1_%d.jpg',k);
saveas(gcf,discription2);
