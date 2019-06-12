clear all; close all;
i = 1; 
x(i) = rand(1)*2-1; 
y(i) = rand(1)*2-1; 
f(i) = (1-x(i))^2 + 100*(y(i)-x(i)^2)^2; 
learning_rate = 1; 

while f(i) > 1e-10
fx(i) = 2*x(i)-2+400*(x(i)^3-x(i)*y(i));
fy(i) = 200*(y(i)-x(i)^2);
i = i + 1;
x(i) = x(i-1) - learning_rate*fx(i-1);
y(i) = y(i-1) - learning_rate*fy(i-1);
f(i) = (1-x(i))^2 + 100*(y(i)-x(i)^2)^2; 
end


plot(x,y,'-');
grid on;
discription1 = sprintf('The number of iterations = %d   Trajectory of (x, y) for learning rate = 1',i);
title(discription1);
saveas(gcf,'Q1_2_3.jpg');

iteration=1:i;
figure;
plot (iteration,f(iteration),'-');
grid on;
discription2 = sprintf('The function value of f(x,y)');
title(discription2);
saveas(gcf,'Q1_2_4.jpg');
