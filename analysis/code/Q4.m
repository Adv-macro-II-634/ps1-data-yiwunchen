%% Question 4
%% Constructing the transition matrix for earning

clear ; close all; clc
X = csvread('data.csv');

x1=X(:,1); 
x2=X(:,2);
x3=X(:,3);
x4=X(:,4);

y2001=x1+x2; % define y2001 is household income for 2001
y2007=x3+x4; % define y2007 is household income for 2007
% for simplicity, I define household income="head and wife taxable income"+
% "taxable income of other family unit member"

z1=quantile(y2001,[0.2,0.4,0.6,0.8,1]); % calculate quantiles for 2001
z2=quantile(y2007,[0.2,0.4,0.6,0.8,1]); % calculate quantiles for 2007

% calculate the number of people whose income quantile b/w 2001 and 2007.
num11=sum(y2001<=z1(1,1) & y2007<=z2(1,1)); 
num12=sum(y2001<=z1(1,1) & y2007>z2(1,1) & y2007<=z2(1,2));
num13=sum(y2001<=z1(1,1) & y2007>z2(1,2)& y2007<=z2(1,3));
num14=sum(y2001<=z1(1,1) & y2007>z2(1,3) & y2007<=z2(1,4));
num15=sum(y2001<=z1(1,1) & y2007>z2(1,4) & y2007<=z2(1,5));

num21=sum(y2001>z1(1,1) & y2001<=z1(1,2) & y2007<=z2(1,1));
num22=sum(y2001>z1(1,1) & y2001<=z1(1,2) & y2007>z2(1,1) & y2007<=z2(1,2));
num23=sum(y2001>z1(1,1)& y2001<=z1(1,2) & y2007>z2(1,2)& y2007<=z2(1,3));
num24=sum(y2001>z1(1,1) & y2001<=z1(1,2)& y2007>z2(1,3) & y2007<=z2(1,4));
num25=sum(y2001>z1(1,1) & y2001<=z1(1,2)& y2007>z2(1,4) & y2007<=z2(1,5));

num31=sum(y2001>z1(1,2) & y2001<=z1(1,3) & y2007<=z2(1,1));
num32=sum(y2001>z1(1,2) & y2001<=z1(1,3) & y2007>z2(1,1) & y2007<=z2(1,2));
num33=sum(y2001>z1(1,2)& y2001<=z1(1,3) & y2007>z2(1,2)& y2007<=z2(1,3));
num34=sum(y2001>z1(1,2) & y2001<=z1(1,3)& y2007>z2(1,3) & y2007<=z2(1,4));
num35=sum(y2001>z1(1,2) & y2001<=z1(1,3)& y2007>z2(1,4) & y2007<=z2(1,5));

num41=sum(y2001>z1(1,3) & y2001<=z1(1,4) & y2007<=z2(1,1));
num42=sum(y2001>z1(1,3) & y2001<=z1(1,4) & y2007>z2(1,1) & y2007<=z2(1,2));
num43=sum(y2001>z1(1,3)& y2001<=z1(1,4) & y2007>z2(1,2)& y2007<=z2(1,3));
num44=sum(y2001>z1(1,3) & y2001<=z1(1,4)& y2007>z2(1,3) & y2007<=z2(1,4));
num45=sum(y2001>z1(1,3) & y2001<=z1(1,4)& y2007>z2(1,4) & y2007<=z2(1,5));

num51=sum(y2001>z1(1,4) & y2001<=z1(1,5) & y2007<=z2(1,1));
num52=sum(y2001>z1(1,4) & y2001<=z1(1,5) & y2007>z2(1,1) & y2007<=z2(1,2));
num53=sum(y2001>z1(1,4)& y2001<=z1(1,5) & y2007>z2(1,2)& y2007<=z2(1,3));
num54=sum(y2001>z1(1,4) & y2001<=z1(1,5)& y2007>z2(1,3) & y2007<=z2(1,4));
num55=sum(y2001>z1(1,4) & y2001<=z1(1,5)& y2007>z2(1,4) & y2007<=z2(1,5));

n1=num11+num12+num13+num14+num15;
n2=num21+num22+num23+num24+num25;
n3=num31+num32+num33+num34+num35;
n4=num41+num42+num43+num44+num45;
n5=num51+num52+num53+num54+num55;

% Calculate the conditional probability
a11=num11/n1;
a12=num12/n1;
a13=num13/n1;
a14=num14/n1;
a15=num15/n1;

a21=num21/n2;
a22=num22/n2;
a23=num23/n2;
a24=num24/n2;
a25=num25/n2;

a31=num31/n3;
a32=num32/n3;
a33=num33/n3;
a34=num34/n3;
a35=num35/n3;

a41=num41/n4;
a42=num42/n4;
a43=num43/n4;
a44=num44/n4;
a45=num45/n4;

a51=num51/n5;
a52=num52/n5;
a53=num53/n5;
a54=num54/n5;
a55=num55/n5;

transition_matrix=[a11,a12,a13,a14,a15;
a21,a22,a23,a24,a25;
a31,a32,a33,a34,a35;
a41,a42,a43,a44,a45;
a51,a52,a53,a54,a55]

%% Plot the Lorenz curve for 2001 and 2007 years

% for 2001 year:
% calculate the cumulative share of income earned
y2001New=sort(y2001);
y2001New1=y2001New(y2001New(:,1)>=0);
y2001New2=cumsum(y2001New1);
y2001New3=y2001New2/sum(y2001New1);

% calculate the cumulative share of people from lowest to highest incomes
y2001New4=[1:length(y2001New1)]';
y2001New5=y2001New4/length(y2001New4);


% for 2007 year:
% calculate the cumulative share of income earned
y2007New=sort(y2007);
y2007New1=y2007New(y2007New(:,1)>=0);
y2007New2=cumsum(y2007New1);
y2007New3=y2007New2/sum(y2007New1);

% calculate the cumulative share of people from lowest to highest incomes
y2007New4=[1:length(y2007New1)]';
y2007New5=y2007New4/length(y2007New4);


plot(y2001New5,y2001New3);
xlabel("Cumulative share of people from lowest to highest incomes");
ylabel("Cumulative share of income earned");
title("the Lorenz curve");
hold on;

plot(y2007New5,y2007New3);
hold on;

x=0:1;
y=0:1;
plot(x,y,"g");
grid;
hold on;

legend("2001","2007","equality line");

%% compute the Gini coefficient

gini_2001=1-2*(sum(y2001New3)/length(y2001New3)) %Gini coefficient for 2001

gini_2007=1-2*(sum(y2007New3)/length(y2007New3)) %Gini coefficient for 2007
