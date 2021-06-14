close all; clear all; clc
data=[];
data1=[];
result=[];
for a=2:1:36
    A=xlsread('all_soybean_statistic.xlsx',a);
    c=A(8,3);
    X=c/1000;
    data1(37-a)=X;
end
for b=38:-1:2
    A=xlsread('HLJ_record1984-2020_4_9.xlsx',b);
      if b==38||b==37||b==29||b==28||b==9||b==10||b==12||b==16||b==17||b==18||b==19||b==20||b==21||b==22||b==3||b==4||b==5||b==6
        c=A(2:14,3);
        d=A(2:14,4);
    else
        c=A(1:13,3);
        d=A(1:13,4);
    end
    
    X=c/1000;
    Y=d/1000;
    m=sum(X);
    n=sum(Y);
    data(39-b)=m;
    result(39-b)=n;
end
year=1984:1:2018;
year2=1984:1:2020;

record=xlsread('HLJ_record1984-2020_4_9.xlsx',1);
n1=record(:,5);
n2=record(:,6);
n3=record(:,7);
n4=record(:,8);
cropland=record(:,9)./1000;
for k=2020:-1:1984
    accMat_L1=[n1(2021-k),n2(2021-k);n3(2021-k),n4(2021-k)];
    SoybeanArea=result(k-1983);
    NonSoybeanArea=cropland(2021-k)-SoybeanArea;
    Matrix=Le_accMat2Matrix(accMat_L1,SoybeanArea,NonSoybeanArea);
    answer=Le_AccToolPontus_1(Matrix);
    result_0(k-1983)=answer(2,1);
    CI(k-1983)=answer(2,2);
    result_up(k-1983)= result_0(k-1983)+CI(k-1983);
    result_low(k-1983)= result_0(k-1983)-CI(k-1983);
end

%line chart with confidence interval

xconf = [year2 year2(end:-1:1)] ;
yconf = [result_up result_low(end:-1:1)];
figure
p = fill(xconf,yconf,'red');
p.FaceColor = [1 0.8 0.8];      
p.EdgeColor = 'none';
hold on
plot(year2,result_0,'ro')
hold on
plot(year,data1,'b','linewidth',1.2)

hold on
year3=2017:1:2019;
YNS=[5262 3546 4552];
plot(year3,YNS,'g','linewidth',1.2)
hold on
year4=2018:1:2020
News=[3567.7 4279.7 5133.8]
plot(year4,News,'b--','linewidth',1.2)

hold on
y1=1984:1:1986;
r1=result_0(1:3);
y2=1986:1:1987;
r2=result_0(3:4);
y3=1987:1:1990;
r3=result_0(4:7);
y4=1990:1:1992;
r4=result_0(7:9);
y5=1992:1:1996;
r5=result_0(9:13);
y6=1996:1:2007;
r6=result_0(13:24);
y7=2007:1:2009;
r7=result_0(24:26);
y8=2009:1:2010;
r8=result_0(26:27);
y9=2010:1:2011;
r9=result_0(27:28);
y10=2011:1:2012;
r10=result_0(28:29);
y11=2012:1:2013;
r11=result_0(29:30);
y12=2013:1:2020;
r12=result_0(30:37);

plot(y1,r1,'m','linewidth',1.2);
hold on

plot(y3,r3,'m','linewidth',1.2);
hold on
plot(y5,r5,'m','linewidth',1.2);
hold on
plot(y7,r7,'m','linewidth',1.2);
hold on
plot(y9,r9,'m','linewidth',1.2);
hold on
plot(y11,r11,'m','linewidth',1.2);
hold on
plot(y2,r2,'r','linewidth',1.2);
hold on
plot(y4,r4,'r','linewidth',1.2);
hold on
plot(y6,r6,'r','linewidth',1.2);
hold on
plot(y8,r8,'r','linewidth',1.2);
hold on
plot(y10,r10,'r','linewidth',1.2);
hold on
plot(y12,r12,'r','linewidth',1.2);
hold off

