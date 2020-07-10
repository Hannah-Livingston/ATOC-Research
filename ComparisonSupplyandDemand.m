%% Find max demand for entire year

%%
%STD Column Directory
%Column 1 = Date
%Column 2 = Hour
%Column 3 = Demand (MWh)
%Column 4 = Date
%Column 5 = WindSpeed (m/s)
%Column 6 = Power Production form 1 turbine (MW)
%Column 7 = Number of actual turbines to meet 100% Demand
%Column 8 = Number of turbines operating at(10 MW)capacity to meet demand
%Column 9 = 15% of Demand
%Column 10= Number of actual turbines to meet 15% Demand
%Column 11= 80% Demand
%Column 12= Number of actual turbines to meet 80% Demand

load('NEISOYearDemandwithwindspeed1.mat')
WSD=NEISOYearDemandwithwindspeed1;
WSD(:,4)=[];
WSD(:,5)=[];
WSD(:,5)=[];
%WSD(:,6)=zeros(height(WSD),1);
WSD(8759,:)=[];
[maxDemand, I]=max([WSD{:,3}]);%max demand occured on June 13, 2017 at 16:00
MaxTimeWindSpeed=WSD{I,5};
for i=1:height(WSD)
    if WSD{i, 5} <= 11
% Power Curve Value for wind speeds from 0-11 (calculated using qadratic
% regression R^2=0.99879
WSD{i,6}=165.165*WSD{i,5}^2+-1153*WSD{i,5}+2492.08;
%Power Curve for wind speeds from 11-12.8
    elseif WSD{i,5}>11 && WSD{i,5}<12.8
        WSD{i,6}=551.8*WSD{i,5}+3769.86;
    else 
        %Power Curve Value for wind speeds greater than 12.8 m/s  (plateau)
        WSD{i,6}=10610;
    end
end
% Display the power generated in MWh       
WSD{:,6}=WSD{:,6}/1000;
WSD{:,7}=WSD{:,3}./WSD{:,6};
WSD{:, 8}=WSD{:,3}/10;
%%
[MaxTurbines, I]=max([WSD{:,7}]);
%In the worst case it would take 41050 wind turbines to meet NE energy
%demands
[MinTurbines, I]=min([WSD{:,7}]);
%In the best conditions it only required 883 wind turbines to meet energy
%demands
%%Median number of wind turbines required to meet energy demands: 2484

STD=WSD;
save('SDT');
%% Make some comparison graphs
load('SDT')

figure

startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
plot(xData, STD{1:24, 3},xData,STD{1:24, 6},'LineWidth',1.5)
datetick('x','HH:MM','keeplimits');
xlabel('hour')
ylabel('MWh')
set(gca,'yscale','log')
%semilogy(xData, STD{1:24, 6})
legend('Demand','Wind Power Produced by Single turbine')
title('Power Supply and Demand on Logarithmic Scale')

%% Plot Average Wind Power Production over entire year

dayWindAverage=zeros(1,24);
for i=1:height(STD)
    for j=1:24
    if STD{i,2}==j
        dayWindAverage(1,j)=dayWindAverage(1,j)+STD{i,6};
    end
    end
end
  
dayWindAverage(1,:)=dayWindAverage(1,:)./366;
figure
plot(xData, dayWindAverage,'LineWidth',1.5)
datetick('x','HH:MM','keeplimits')
xlabel('Hour')
ylabel('MWh')
title('Average Supply Curve for all Year')

%% Make a supply plot for everyday in the year

x=1:1:height(STD);
y=STD{:,6};
%plot(x,y)
startDate = datenum('10-07-2016');
endDate = datenum('10-06-2017');
xData = linspace(startDate,endDate,height(STD));
figure;
plot(xData,y);drawnow
datetick('x','dd-mmm-yyyy','keeplimits')
xlabel('day')
ylabel('MWh')
title('Supply by one DTU 10 MW turbine over the course of a year')
hold on

%% Matching Demand Histograms
%Rated and Actual for 100% Demand
figure;
h1=histogram(STD{:, 7}, 'BinWidth', 500)
hold on;
h2=histogram(STD{:,8}, 'BinWidth',500)
%h1.Normalization = 'probability';
h1.BinWidth = 1000;
%h2.Normalization = 'probability';
h2.BinWidth = 1000;
ax = gca;
ax.XRuler.Exponent = 0;
xticks([0:4000:40000])
%yticks([0:0.1:1])
xtickangle(45)
xlabel('Number of turbines needed to match demand','fontweight','bold','fontsize',14)
ylabel('Portion of the year','fontweight','bold','fontsize',14)
title('Turbine Capacity Required to Match  100% Demand','fontweight','bold','fontsize',20)
legend('Turbines operating at actual capacity', 'Turbines operating at 10 MW rated capacity')
hold off;
%%
close all;
figure;
%Just Actual at 100% Demand
h1=histogram(STD{:, 7},'BinWidth', 1000, 'FaceColor', '#0072BD')
ax = gca;
%h1.Normalization = 'probability';
ax.XRuler.Exponent = 0;
xticks([0:2000:40000]);
xlim([0 24000])
%yticks([0:0.1:1]);
ytix = get(gca, 'YTick')
%set(gca, 'YTick',ytix, 'YTickLabel',yticks*100)
xtickangle(90)
xlabel('Number of turbines needed to match demand','fontweight','bold','fontsize',10)
ylabel('Hours of the Year','fontweight','bold','fontsize',10)
title('Turbines Required to Match Hourly Demand','fontweight','bold','fontsize',12)
%legend('Turbines operating ') 
hold off;


%% to match 15% demand
STD{:,9}=STD{:,3}.*0.15; % Column 9 = 15% of Demand
STD{:,10}=STD{:,9}./STD{:,6}; % Column 10 = # of turbines to meet 15% Demand

h1=histogram(STD{:, 10},'BinWidth', 200,'FaceColor','#77AC30')
ax = gca;
h1.Normalization = 'probability';
ax.XRuler.Exponent = 0;
xticks([0:400:6000]);
yticks([0:0.1:1]);
ytix = get(gca, 'YTick')
set(gca, 'YTick',ytix, 'YTickLabel',yticks*100)
xtickangle(90)
xlabel('Number of turbines needed to match demand','fontweight','bold','fontsize',14)
ylabel('Percentage of the Year (%)','fontweight','bold','fontsize',14)
title('Turbine Capacity Required to Match  15% Demand','fontweight','bold','fontsize',20)
legend('Turbines operating at actual capacity') 

%% To match 80% Demand
STD{:,11}=STD{:,3}.*0.80; % Column 11 = 80% of Demand
STD{:,12}=STD{:,11}./STD{:,6}; % Column 10 = # of turbines to meet 15% Demand
%nbins=66
h1=histogram(STD{:, 12},'BinWidth',500,'FaceColor','#7E2F8E');
ax = gca;
h1.Normalization = 'probability';
ax.XRuler.Exponent = 0;
xticks(0:1000:32000);
yticks(0:0.1:1);
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',yticks*100)
xtickangle(90)
xlabel('Number of turbines needed to match demand','fontweight','bold','fontsize',14)
ylabel('Percentage of the Year (%)','fontweight','bold','fontsize',14)
title('Turbine Capacity Required to Match  80% Demand','fontweight','bold','fontsize',20)
legend('Turbines operating at actual capacity')

%% Make Cumulative Demand Generation Curve
figure;
boi=STD{:,7}./0.8;
for i=1:100
    cumulative{i,2}=(numel(boi(boi<=250*i)))/(365*24);
    cumulative{i,1}=250*i;
end


bo=cell2mat(cumulative);
plot(bo(:,1), bo(:,2)*100, 'Linewidth', 4)
title('Cumulative Demand Generation Assuming 20% wake loss', 'Fontsize', 12)
% added 20% extra turbines to account for assumed 20% wake loss
xlabel('Number of Turbines','Fontsize', 14)
ylabel('Percentage of the time','Fontsize', 14)
ax = gca;
ax.XRuler.Exponent = 0;
xlim ([0 25000]);
ylim([0 100]);
xticks([0:2000:25000]);
xtickangle(90);





%% New Storage Calulation
%Calculations account for 20% wake loss
RealStorage=zeros(4,7);
for k=1:4
numTurbines=2000*k;
diff=-STD{:, 3}+STD{:, 6}*numTurbines*0.8;

interval=4;


for j=1:6
    interval=4*j;
    
meanDemand=mean(STD{:,3});
plus=meanDemand*interval;
numunmethours=0;
surplushours=0;
plotboi=zeros(1, 8758);
for i=1:8758
    if plus <= meanDemand*interval && plus >=0
        plus=plus+diff(i);
    elseif plus > meanDemand*interval
        surplushours=surplushours+1;
        plus=meanDemand*interval;
    elseif plus <0 && diff(i)< 0
        numunmethours=numunmethours +1;
        plus=0;
       
    end
     plotboi(i)=plus/10e5;
end
        
        
    surplushours;
    numunmethours;
    RealStorage(k,j+1)=numunmethours;

end

noStorage=0;
for i=1:8758
    if diff(i)<=0
        noStorage=noStorage+1;
       
    end
end
RealStorage(k,1)=noStorage;
%x=0:4:24;

end
tR=RealStorage'
bar(x,tR)%,'FaceColor', [0,0.5,0.5])
title('Hours of Unmatched Demand for Hours of Storage Capacity', 'Fontsize', 20)
xlabel('Hours of Storage','Fontsize', 18)
ylabel('Hours of Unmatched Demand per year','Fontsize', 18)
legend('2000 turbines', '4000 turbines', '6000 turbines', '8000 turbines')


figure;
x=[1:1:8758];
plot(x, plotboi)

%%
nunmetPeriods=tR./8758;
opnunmetPeriods=(1-nunmetPeriods)*100;
x=0:4:24;
figure;
bar(x,opnunmetPeriods)%'FaceColor',[0.2 0.6 .8])

title(' Percentage of Yearly Demand Met by Hours of Storage','FontSize', 16)
xlabel('Hours of Storage Capacity', 'FontSize', 14)
ylabel('Percentage of Year','FontSize', 14)
ylim([20 100])
legend('2000 turbines', '4000 turbines', '6000 turbines', '8000 turbines')

%% Single Day p



