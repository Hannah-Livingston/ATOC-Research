%%NE ISO Grid Demand 
% Read in Yearly Demand Data and process it so it is just the hours MWh
load('NEISOYearDemand1.mat')

YearPlot=NEISOYearDemand1;

for i=1:height(NEISOYearDemand1)
    YearPlot{i,2}=i;
end


%% Plot moving average for whole year

clear poo;
cvec=YearPlot{:,3};
Demandonly=cvec./1000;
n=length(Demandonly);
movingAv=zeros(n,1);
Daysum=zeros(n, 1);
a=500
svec=zeros(a,1);
AvDev=zeros(n,1);

for j=1:n-a
        p=Demandonly(j);
        for k=1:a 
    p=p+Demandonly(j+k);
    svec(k)=Demandonly(j+k);
        end
        AvDev(j)=std(svec);
        movingAv(j)=p/a;
end
movingAv(7759:end)=[];
AvDev(7759:end)=[];
%plot(x,y)
startDate = datenum('10-07-2016');
endDate = datenum('10-06-2017');
xData = linspace(startDate,endDate,length(movingAv));
figure;
plot(xData,movingAv, 'Linewidth', 2.5)
xlim([7.366e5 7.3697e5]);
set(gca, 'XTick')
datetick('x','mmmm')%'keepticks')
ylim([9 19]);
hold on;
mp=(movingAv+AvDev./1.5);
mn=(movingAv-AvDev./1.5);
plot(xData, mp,'c')
plot(xData, mn, 'c')
xData=xData';
ylabel('GWh')
xlabel('Month')
title('Yearly Grid Demand 2016-2017')
%fill(movingAv- AvDev, movingAv+ AvDev, 'r','FaceAlpha',0.2, 'EdgeAlpha', 0.01);

% patch([xData fliplr(xData)], [mp fliplr(movingAv)], 'y','FaceAlpha',0.4, 'EdgeAlpha', 0.01)
% patch([xData fliplr(xData)], [movingAv fliplr(mn)], 'g','FaceAlpha',0.2, 'EdgeAlpha', 0.01)
% H2 = plot(xData, movingAv- AvDev, 'Color', 'r');
% H2 = plot(xData, movingAv+ AvDev, 'Color', 'r');

%  x2J = [xData, fliplr(xData)];
%  inBetween = [mp, fliplr(movingAv)];
%  fill(x2J, inBetween, 'r','FaceAlpha',0.35, 'EdgeAlpha', 0.01);
%  
%  x1J = [xData, fliplr(xData)];
%  inBetween = [mn, fliplr(movingAv)];
%  fill(x1J, inBetween, 'g','FaceAlpha',0.35, 'EdgeAlpha', 0.01);


% H3 = plot(xData, [mean_y - std_y; mean_y + std_y], 'Color', 'm');
% H4 = plot(xData, [mean_y - 0.5*std_y  ; mean_y +   0.5*std_y], 'Color', 'b');

% curve1J = movingAv(1:8158) + AvDev(1:8158);
% curve2J = movingAv(1:8158) - AvDev(1:8158);
% 
% x2J = [xData; fliplr(xData)];
% inBetween = [curve1J, fliplr(curve2J)];
% fill(x2J, inBetween', 'r','FaceAlpha',0.2, 'EdgeAlpha', 0.01);

%% Make a Plot for every day in the year
%3 panel plot
subplot(1,3,3)
x=YearPlot{:,2};
y=YearPlot{:,3}/1000;
%plot(x,y)
startDate = datenum('10-07-2016');
endDate = datenum('10-06-2017');
xData = linspace(startDate,endDate,height(YearPlot));
figure;
plot(xData,y)
set(gca, 'XTick')
datetick('x','mmmm')%'keepticks')

%ax.XRuler.Exponent = 0;
xtickangle(70)
xlabel('Month','FontSize',14)
ylabel('GWh','FontSize',14)
title('Yearly Grid Demand','FontSize',16)

%%
dayAverage=zeros(1,24);
for i=1:height(NEISOYearDemand1)
    for j=1:24
    if NEISOYearDemand1{i,2}==j
        dayAverage(1,j)=dayAverage(1,j)+NEISOYearDemand1{i,3};
    end
    end
end
  
% Average Day
%subplot(1,3,1)
dayAverage(1,:)=dayAverage(1,:)./365;
xData = linspace(startTime,endTime,24);
plot(xData, dayAverage)
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('GWh')
title('Average Demand Curve for all Year')

%%

%Average Week
%subplot(1,3,2)
December1=NEISOYearDemand1([73:240],3) ;
%startDate = datenum('10-10-2016');
%endDate = datenum('10-16-2016');
xData = 0:1:167';
plot(xData,December1)
ylim([9000 22000]);
%datetick('x','ddd','keeplimits')
xlabel('Hour')
ylabel('MWh')
%title('December 1, 2016')

hold on



%% Make a Plot for the first day of every month
%December 1
subplot(4,3,12)
December1=NEISOYearDemand1([1322:1345],:) ;
D1=December1{:,2};
D2=December1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,D2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('December 1, 2016')

% January 1
subplot(4,3,1)
January1=NEISOYearDemand1(2066:2089,:) ;
J2=January1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,J2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('January 1, 2017')

%February 1
subplot(4,3,2)
February1=NEISOYearDemand1(2810:2833,:) ;
F1=February1{:,2};
F2=February1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,F2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('February 1, 2017')

%March 1, 2017
subplot(4,3,3)
March1=NEISOYearDemand1(3482:3505,:) ;
Mr1=March1{:,2};
Mr2=March1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,Mr2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('March 1, 2017')

%April 1, 2017
subplot(4,3,4)
April1=NEISOYearDemand1(4225:4248,:) ;
A1=April1{:,2};
A2=April1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,A2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('April 1, 2017')

%May 1
subplot(4,3,5)
May1=NEISOYearDemand1(4945:4968,:) ;
Ma1=May1{:,2};
Ma2=May1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,Ma2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('May 1, 2016')

%June 1
subplot(4,3,6)
June1=NEISOYearDemand1(5689:5712,:) ;
Jn2=June1{:,3};
%startTime = datenum('00:00');
%endTime = datenum('24:00');
%xData = linspace(startTime,endTime,24);
plot(xData,Jn2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('June 1, 2016')

%July 1
subplot(4,3,7)
July1=NEISOYearDemand1(6409:6432,:) ;
Jl1=July1{:,2};
Jl2=July1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,Jl2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('July 1, 2016')

% August 1
subplot(4,3,8)
Aug1=NEISOYearDemand1(7153:7176,:) ;
Au1=Aug1{:,2};
Au2=Aug1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,Au2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('August 1, 2017')

% september 1
subplot(4,3,9)
Sept1=NEISOYearDemand1(7897:7920,:) ;
S1=Sept1{:,2};
S2=Sept1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,S2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('September 1, 2017')

%October 1

subplot(4,3,10)
Oct1=NEISOYearDemand1(8615:8638,:) ;
O1=Oct1{:,2};
O2=Oct1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,O2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('October 1, 2017')

%November 1
subplot(4,3,11)
Nov1=NEISOYearDemand1(601:624,:) ;
N1=Nov1{:,2};
N2=Nov1{:,3};
startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData,N2)
ylim([9000 22000])
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('November 1, 2016')

%% Find Average demand curve for entire year by averaging each hour of the day

dayAverage=zeros(1,24);
for i=1:height(NEISOYearDemand1)
    for j=1:24
    if NEISOYearDemand1{i,2}==j
        dayAverage(1,j)=dayAverage(1,j)+NEISOYearDemand1{i,3};
    end
    end
end
  
dayAverage(1,:)=dayAverage(1,:)./365;
figure
plot(xData, dayAverage)
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('Average Demand Curve for all Year')

%% Make sublot of average generation for each month


load('Monthgraph.mat')
Monthgraph=Monthgraph./30;
startTime = datenum('00:00');
endTime = datenum('24:00');

xData = linspace(startTime,endTime,24)
month={'January','February','March','April', 'May', 'June','July','August','September','October','November','December'};
for i=1:12
    subplot(4,3,i)
    plot(xData, Monthgraph(i, :)/1000,'b','LineWidth',1.5)
    datetick('x','HH:MM','keeplimits')
xticks('mode');
    
if i==1 || i==2 || i==11 ||i== 12
    xlabel('Hour EDT (UTC-5)')
else
    xlabel('Hour EST (UTC-4)')
end

ylabel('GWh')
ylim([9 19])
title(month{i},'FontSize',14)
end
  sgtitle('Average Monthly Demand 2016-2017','FontSize',20,'fontweight','bold')

%

%% Plot 4 months on the same graph
close all;

SMonth=zeros(12,24);
January=MonthlyDemand{1:744,3}';
JanA=reshape(January, 24,[])';
SMonth(1,:)=std(JanA);
February=MonthlyDemand{745:1416, 3};
FebA=reshape(February, 24,[])';
SMonth(2,:)=std(FebA);
March=MonthlyDemand{1417:2160,3}';
MarchA=reshape(March, 24, [])';
SMonth(3,:)=std(MarchA);
April=MonthlyDemand{2161:2880,3}';
ApA=reshape(April, 24,[])';
SMonth(4,:)=std(ApA);
May=MonthlyDemand{2881:3624, 3}';
MaA=reshape(May, 24, [])';
SMonth(5,:)=std(MaA);
June=MonthlyDemand{3624:4343,3}';
JunA=reshape(June, 24,[])';
SMonth(6,:)=std(JunA);
July=MonthlyDemand{4344:5087,3}';
JulA=reshape(July, 24, [])';
SMonth(7,:)=std(JulA);
August=MonthlyDemand{5088:5831, 3}';
AugA=reshape(August, 24, [])';
SMonth(8,:)=std(AugA);
September=MonthlyDemand{5832: 6551,3};
SeptA=reshape(September, 24, [])';
SMonth(9,:)=std(SeptA);
October=MonthlyDemand{6550:7293,3}';
OctA=reshape(October,24, [])';
SMonth(10,:)=std(OctA);
November=MonthlyDemand{7294:8013, 3}';
NovA=reshape(November, 24, [])';
SMonth(11,:)=std(NovA);
December=MonthlyDemand{8015:8758, 3}';
DecA=reshape(December, 24, [])';
SMonth(12,:)=std(DecA);


load('Monthgraph.mat')
Monthgraph=Monthgraph./30;
month={'January','February','March','April', 'May', 'June','July','August','September','October','November','December'};

%Gratuitous Code of which I am sure 
%there is a better way to accomplish this




figure
hold on
startTime = datenum('00:00');
endTime = datenum('24:00');

%errorbar(xData, Monthgraph(1,:)/1000,SMonth(1,:)/1000,'LineWidth',1.5)
plot(xData, Monthgraph(1,:)/1000,'r','LineWidth',1.5)
hold on;
curve1J = Monthgraph(1,:)/1000 + SMonth(1,:)/1000;
curve2J = Monthgraph(1,:)/1000 - SMonth(1,:)/1000;
x2J = [xData, fliplr(xData)];
inBetween = [curve1J, fliplr(curve2J)];
fill(x2J, inBetween, 'r','FaceAlpha',0.2, 'EdgeAlpha', 0.01);


plot(xData, Monthgraph(4,:)/1000,'b','LineWidth',1.5)
curve1A = Monthgraph(4,:)/1000 + SMonth(4,:)/1000;
curve2A = Monthgraph(4,:)/1000 - SMonth(4,:)/1000;
x2A = [xData, fliplr(xData)];
inBetween = [curve1A, fliplr(curve2A)];
fill(x2A, inBetween, 'b','FaceAlpha',0.2, 'EdgeAlpha', 0.01);

plot(xData, Monthgraph(7,:)/1000,'Color', [1, 0.50, 0.080],'LineWidth',1.5)
curve1J = Monthgraph(7,:)/1000 + SMonth(7,:)/1000;
curve2J = Monthgraph(7,:)/1000 - SMonth(7,:)/1000;
x2J = [xData, fliplr(xData)];
inBetween = [curve1J, fliplr(curve2J)];
fill(x2J, inBetween, 'y','FaceAlpha',0.35, 'EdgeAlpha', 0.01);

plot(xData, Monthgraph(10,:)/1000,'Color', [0.09500, 0.550, 0.080],'LineWidth',1.5)
curve1O = Monthgraph(10,:)/1000 + SMonth(10,:)/1000;
curve2O = Monthgraph(10,:)/1000 - SMonth(10,:)/1000;
x2O = [xData, fliplr(xData)];
inBetween = [curve1O, fliplr(curve2O)];
fill(x2O, inBetween, 'g','FaceAlpha',0.35,'EdgeAlpha', 0.01);

legend('January','', 'April','' ,'July','', 'October', '')
title('Average Daily Demand Per Month 2016-2017','FontSize',12)
ax = gca;
ax.XTick = xData;
xData = linspace(startTime,endTime,24);
datetick('x','HH:MM')
xlabel('Time (ET)')
ylabel('Demand (GWh)')
hold off


