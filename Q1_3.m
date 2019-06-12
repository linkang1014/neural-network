%%INPUT
clear all; close all;
i = 1; 
x(i) = rand(1)*2-1; 
y(i) = rand(1)*2-1; 
f(i) = (1-x(i))^2 + 100*(y(i)-x(i)^2)^2; 
learning_rate = 0.001; 

%%CACULATION
while f(i) > 1e-10
fx(i) = 2*x(i)-2+400*(x(i)^3-x(i)*y(i));
fy(i) = 200*(y(i)-x(i)^2);
H{i} = [1200*x(i)^2-400*y(i)+2 -400*x(i); -400*x(i) 200];
i = i + 1;
tmp = [x(i-1);y(i-1)] - inv(H{i-1})*[fx(i-1);fy(i-1)];
x(i) = tmp(1);
y(i) = tmp(2);
f(i) = (1-x(i))^2 + 100*(y(i)-x(i)^2)^2; 
end

%%PLOT
plot(x,y,'-');
grid on;
discription1 = sprintf('The number of iterations = %d   Trajectory of (x, y)',i);
title(discription1);
saveas(gcf,'Q1_3_1.jpg');

iteration=1:i;
figure;
plot (iteration,f(iteration),'-');
grid on;
discription2 = sprintf('The function value of f(x,y)');
title(discription2);
saveas(gcf,'Q1_3_2.jpg');
