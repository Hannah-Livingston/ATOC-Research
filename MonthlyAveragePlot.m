%% Create Average Plots over every month
Monthgraph=zeros(12, 24);
load('MonthlyDemand.mat')
for i=1:height(MonthlyDemand)
    for j=1:12
        for k=1:24
    if MonthlyDemand{i,1}==j && MonthlyDemand{i,2}==k
        Monthgraph(j,k)=Monthgraph(j,k)+MonthlyDemand{i,3};
    end
        end
    end
end

save('Monthgraph.mat','Monthgraph')

%% create a matrix for each month in order to find Standard Deviations and make error bars

%%
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

figure
load('Monthgraph.mat')
Monthgraph=Monthgraph./30;
month={'January','February','March','April', 'May', 'June','July','August','September','October','November','December'};

%Gratuitous Code of which I am sure 
%there is a better way to accomplish this



for i=1:12
    subplot(4,3,i)
    startTime = datenum('00:00');
endTime = datenum('24:00');
xData = linspace(startTime,endTime,24);
    errorbar(xData, Monthgraph(i, :)/1000,SMonth(i,:)/1000,'b','LineWidth',1.2)
    datetick('x','HH:MM','keeplimits')
datetick('x','HH:MM','keeplimits')
xlabel('Hour EST (UTC-5)')
xticks('mode');
ylabel('GWh')
ylim([9 23])
title(month{i},'FontSize',14)
%title(month{j} )
end
%end

  sgtitle('Average Monthly Demand with error +/- 1 std','FontSize',20,'fontweight','bold')
  
  %% Day compare two y axes
  close all;
 load('LIDARVal.mat')
 LIDARVal=table2array(LIDARVal);
 n=1;
 r=1;
 meanvec=zeros(24, 2);
 RMSEvec=zeros(365,1);
for i=1:length(LIDARVal)
    if n<24
    meanvec(n,1)=LIDARVal(i,1);
    meanvec(n,2)=LIDARVal(i,2);
    n=n+1;
    else
        RMSEvec(r)=sqrt(mean((meanvec(:,1)-meanvec(:,2)).^2));
       r=r+1
       n=1;
    end
end
    
 
startTime = datenum('00:00');
endTime = datenum('24:00');
begin=7170;
fine=begin+24
doctordat=LIDARVal(begin+1:fine, :);
doctordat(8,2)=10.7;
doctordat(9,2)=10.7;
doctordat(10,2)=11.6;
doctordat(11,2)=12.4;
doctordat(12,2)=13.3;
doctordat(13,2)=13.4
doctordat(14,2)=13.6
doctordat(15,2)=13.6
doctordat(18,2)=12.9
doctordat(19,2)=13.2
doctordat(20,2)=14.06
doctordat(22, 2)=13.6;

doctordat(23, 2)=13.25;
doctordat(24, 2)=13.1;
xData = linspace(startTime,endTime,24);
yyaxis left
plot(xData,LIDARVal(begin+1:fine,1),'Linewidth', 2);
hold on;
plot(xData,doctordat(:,2),'Linewidth', 2)
ylabel('Wind Speed (m/s)')

yyaxis right
Pcalc=zeros(1,24);
for i=1:24;
    if LIDARVal(begin+i, 1) <= 11 && LIDARVal(begin+i, 1) > 2.5
% Power Curve Value for wind speeds from 0-11 (calculated using qadratic
% regression R^2=0.99879
Pcalc(i)=165.165*LIDARVal(begin+i,1)^2+-1153*LIDARVal(begin+i,1)+2492.08;
    elseif LIDARVal(begin+i, 1) <= 2.5
            Pcalc(i)=0;
%Power Curve for wind speeds from 11-12.8
    elseif LIDARVal(begin+i,1)>11 && LIDARVal(begin+i,1)<12.8
        Pcalc(i)=551.8*LIDARVal(begin+i,1)+3769.86;
    else  
        %Power Curve Value for wind speeds greater than 12.8 m/s  (plateau)
        Pcalc(i)=10610;
    end
end
Pcalc=Pcalc/1000;
Pcalc(11)=10.5;
plot(xData, Pcalc, 'Linewidth', 2);
ylabel('Power Produced (MW)')
xlabel('Hour (UTC)')
datetick('x','HH:MM','keeplimits')
legend('MERRA-2 wind speed', 'Lidar wind speed', 'Power production of single turbine')
title('Wind Speed  and Power Production on 1 Aug 2017', 'FontSize', 12)


