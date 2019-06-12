%%
%INPUT
clear all;
close all;
load('testing_0.mat');load('testing_1.mat');load('training_0.mat');load('training_1.mat');

x0 = ones(900,1);
x1 = cat(1,training_0,training_1);
x2 = im2double(x1);
x = cat(2,x0,x2);%input

rowrank = randperm(size(x, 1));
x = x(rowrank,:);

y1 = zeros(450,1);
y2 = ones(450,1);
Y = cat(1,y1,y2);%design output
Y = Y(rowrank,:);
 
g = 1;
eta = 0.01;%learning speed
w(:,g)=rand(1025,1); %weight
epoch = 100;
%%
%CACULATION
for n = 0:epoch
   for i = 1:900
       v(i) = x(i,:)*w(:,g);
       if (v(i)>=1)
           h(i)=1;
       else
           h(i)=0;
       end
       e(i) = Y(i)-h(i);
       w(:,g+1) = w(:,g)+(eta*e(i)*x(i,:))';
       g=g+1;
   end
end
%%
%EVALUATE THE PERFORMANCE OF THE NETWORK
%TRAINING SET TEST
num_accuracy_train = 0;
for j = 1:900
    test1(j)=x(j,:)*w(:,g);
    if  test1(j)>=0.8
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
for j = 1:100
    test2(j)=x_test(j,:)*w(:,g);
    if  test2(j)>=0.8
        y_test(j) = 1.0;
    else
        y_test(j) = 0;
    end
    if (((Y_test(j)== 0) && (y_test(j)== 0))||((Y_test(j)== 1.0) && (y_test(j)==1.0)))
        num_accuracy_test  = num_accuracy_test +1;
    end
end








