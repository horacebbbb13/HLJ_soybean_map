close all; clear all; clc
AO=[];
AU=[];
AP=[];
AO_p=[];
AU_p=[];

data=[];
data1=[];
result=[];

for b=38:-1:2
    A=xlsread('HLJ_record1984-2020_4_9.xlsx',b);%HLJ_record2000-2019
    if b==38||b==37||b==9||b==10||b==12||b==16||b==17||b==18||b==19||b==20||b==21||b==22||b==3||b==4||b==5||b==6
        c=A(2:14,3);%Correct:c=A(2:14,3);
        d=A(2:14,4);
    else
        c=A(1:13,3);%Correct:c=A(2:14,3);
        d=A(1:13,4);
    end
    X=c/1000;
    Y=d/1000;
    m=sum(X);
    n=sum(Y);
    data(39-b)=m;
    result(39-b)=n;
end
record=xlsread('HLJ_record1984-2020_4_8.xlsx',1);
n1=record(:,5);
n2=record(:,6);
n3=record(:,7);
n4=record(:,8);
cropland=record(:,9)./1000;
for k=2020:-1:2003
    accMat_L1=[n1(2021-k),n2(2021-k);n3(2021-k),n4(2021-k)];
    SoybeanArea=result(k-1983);
    NonSoybeanArea=cropland(2021-k)-SoybeanArea;
    Matrix=Le_accMat2Matrix(accMat_L1,SoybeanArea,NonSoybeanArea);
    answer=Le_AccToolPontus(Matrix);
    AO(k-2002)=answer(1,1);
    AU(k-2002)=answer(2,2);
    AP(k-2002)=answer(2,3);
    AO_p(k-2002)=answer(1,4);
    AU_p(k-2002)=answer(2,5);
end
year=2003:1:2020;
AO=AO';
AU=AU';
AP=AP';
z=[AO AU AP ];

%set(gca,'xtick',year,'ytick',0:0.2:1.2);
b=bar(year,z,'group','FaceColor','flat');
b(1).CData=[1 1 0.78];
b(2).CData=[0.33 0.525 0.529];
b(3).CData=[0.278 0.2 0.2078];
% b.CData(1,:) = [1 1 0.78];
% b.CData(2,:) = [0.33 0.525 0.529];
% b.CData(3,:) = [0.278 0.2 0.2078];

hold on
errorbar(year-0.23,AO,AO_p,'k', 'linestyle', 'none', 'lineWidth', 0.4)
hold on
errorbar(year,AU,AU_p,'k', 'linestyle', 'none', 'lineWidth', 0.4)
xlim([2002.5,2020.5]);
xticks(2003:1:2020)
ylim([0,1.2]);
yticks(0:0.2:1.2);
legend([b(1),b(2),b(3)],{'Overall accuracy', 'User''s accuracy','Producer''s accuracy'},'location','northeast','NumColumns',3);


