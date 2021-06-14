close all; clear all; clc
for b=1:13
    subplot(3,5,b-3);
    A=xlsread('HLJ_record1984-2020_4_9.xlsx',b);
   
    X=c/1000;
    Y=d/1000;
    
    plot(X,Y,'bo','markersize',3);
    hold on
    
    
    p1=polyfit(X,Y,1);
    
    a=1:100:1600;
    y1=polyval(p1,a);
   
    plot(a,a,'k-','linewidth',0.5);
    plot(a,y1,'b-','linewidth',0.8);
    %plot(a,y2,'r-','linewidth',0.8);
    set(gca,'xlim',[0,1000])
    set(gca,'ylim',[0,1000])
    set(gca,'XTickLabel',[0:500:1000]);
    set(gca,'YTickLabel',[0:500:1000]);
    i=2022-b;
    title([num2str(i),'year']);
    pbaspect([1 1 1])
    hold off
end

