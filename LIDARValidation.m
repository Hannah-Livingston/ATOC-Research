%% Validate LIDAR with MERRA 2 Data Set
load('LIDARVal.mat')
RMSE = sqrt(mean(((LIDARVal{:,1}-LIDARVal{:,2}).^2)))
sz=10;
RGB = [0.6 0.6 0.6];
scatter(LIDARVal{:,2},LIDARVal{:,1},sz, RGB);
ylabel('MERRA 2 wind speed (m/s)')
xlabel('LIDAR wind speed (m/s)')
title(' Hourly Wind Resource Data Correlation')
%txt='RMSE=2.33 R-squared=0.782';
X=LIDARVal{:,1};
y=LIDARVal{:,2};
h=lsline;
xvec=0:1:24;
yvec=xvec;

set(h(1),'color','k','LineStyle','-','LineWidth',3)
mdl = fitlm(X,y)
hold on;
plot(xvec, yvec, '--k', 'Linewidth',2)
legend('Data', 'Line of Best Fit', '1:1 Line')

LIDARVal(7225:7233,:)=[];
%% 
%take the daily averages

%dailyAverage=LIDARVal{6657,:}=[];
LIDdata=LIDARVal{:, 1};
MERRdata=LIDARVal{:, 2};
dailyAVLID=mean(reshape(LIDdata, 24,301 ))';
dailyAVMERR=mean(reshape(MERRdata, 24,301))';

%% Plot Daily Average Correlation
RMSE = sqrt(mean((abs((dailyAVLID-dailyAVMERR)).^2)))
sz=10;
RGB = [0.5 0.5 0.5];
scatter(dailyAVLID,dailyAVMERR,sz,RGB);
ylabel('MERRA-2 wind speed (m/s)')
xlabel('Lidar wind speed (m/s)')
title(' Daily Average Wind Resource Data Correlation')
%txt='RMSE=2.33 R-squared=0.782';
X=dailyAVLID;
y=dailyAVMERR;
h=lsline;

set(h(1),'color','k','LineStyle','-','LineWidth',3)
mdl = fitlm(X,y)
hold on;
xvec=2:1:22;
yvec=xvec;
plot(xvec, yvec, '--k', 'Linewidth',2)
legend('Data', 'Line of Best Fit', '1:1 Line')

%% Power Curve
load Powercurve.mat
Powercurve=table2array(Powercurve)
Powercurve
figure;
plot(Powercurve(:,1), Powercurve(:,2)./100, 'Linewidth', 3)
xlabel('Wind Speed (m/s)');
ylabel('Power (MW)')
title('DTU 10MW Turbine Power Curve')