

%% MEGA DATA files for each Sonic Anemometer
% 1.) juliantime30min
% 2.) L
% 3.) TI
% 4.) TKE
% 5.) WS
load('P03megadata')
load('P04megaData')
load('P05megaData')
load('P09megaData')
load('P10megaData')
load('P12megaData')

z=10;

%% P03 tower
close all;
zL3= z./P03megaDat(196:13567,2); 
meanzL3=nanmean(zL3);

plot(P03megaDat(196:13567,1), zL3)

% P04 tower
figure;
zL4= z./P04megaDat(110:13624,2); 
meanzL4=nanmean(zL4);
plot(P04megaDat(110:13624,1), zL4);
% P05 tower
figure;
zL5=z./P05megaDat(92:11717,2);
meanzL5=nanmean(zL5);
plot(P05megaDat(92:11717,1), zL5);

%P09 tower
figure;
zL9=z./P09megaDat(259:14156,2);
meanzL9=nanmean(zL9);
plot(P09megaDat(259:14156,1), zL9);

%P10 tower
figure;
zL10=z./P10megaDat(108:13666,2);
meanzL10=nanmean(zL10);
plot(P10megaDat(108:13666,1), zL10)


%% meanZL
figure;
bar([meanzL3, meanzL4, meanzL5, meanzL9, meanzL10])


Anames={'P03'; 'P04'; 'P05'; 'P09'; 'P10' };
set(gca,'xticklabel',Anames)
xlabel('10m Anemometer Towers')
ylabel(' mean z/L')
title('Mean z/L for 5 Sonic Anemomter Towers')

% figure;
% scatter([1:5], [meanzL3, meanzL4, meanzL5, meanzL9, meanzL10])

%% Bigmat creation and plot
close all;
jdaybegin=2457388.50000; %% January 1 2016 UTC 0:00
jday2017=2457754.50000; % January 1 2017
jdayend=2457793.5; %% day 40 UTC:00
bigmat3=zeros(14150,5); % create matrices that span the same time period
bigmat4=zeros(14150,5);
bigmat5=zeros(14150,5);
bigmat9=zeros(14150,5);
bigmat10=zeros(14150,5);
bigmat12=zeros(14150, 5);
n=1;
for i=1:length(P03megaDat(:,1))
    if P03megaDat(i,1)> 120
        bigmat3(n,:)=P03megaDat(i,:);
        bigmat3(n,1)=(P03megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P03megaDat(i,1)<40
        bigmat3(n,:)=P03megaDat(i,:);
        bigmat3(n,1)=(P03megaDat(i,1)+jday2017);
        n=n+1;
    end
    
end
        
n=1;
for i=1:length(P04megaDat(:,1))
    if P04megaDat(i,1)> 120
        bigmat4(n,:)=P04megaDat(i,:);
        bigmat4(n,1)=(P04megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P04megaDat(i,1)<40
        bigmat4(n,:)=P04megaDat(i,:);
        bigmat4(n,1)=(P04megaDat(i,1)+jday2017);
        n=n+1;
    end
    
end

n=1;
for i=1:length(P05megaDat(:,1))
    if P05megaDat(i,1)> 120
        bigmat5(n,:)=P05megaDat(i,:);
        bigmat5(n,1)=(P05megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P05megaDat(i,1)<40
        bigmat5(n,:)=P05megaDat(i,:);
        bigmat5(n,1)=(P05megaDat(i,1)+jday2017);
        n=n+1;
    end
    
end


n=1;
for i=1:length(P09megaDat(:,1))
    if P09megaDat(i,1)> 120
        bigmat9(n,:)=P09megaDat(i,:);
        bigmat9(n,1)=(P09megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P09megaDat(i,1)<40
        bigmat9(n,:)=P09megaDat(i,:);
        bigmat9(n,1)=(P09megaDat(i,1)+jday2017);
        n=n+1;
    end
    
end

n=1;
for i=1:length(P10megaDat(:,1))
    if P10megaDat(i,1)> 120
        bigmat10(n,:)=P10megaDat(i,:);
        bigmat10(n,1)=(P10megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P10megaDat(i,1)<40
        bigmat10(n,:)=P10megaDat(i,:);
        bigmat10(n,1)=(P10megaDat(i,1)+jday2017);
        n=n+1;
  
        
    end
    
end

n=1;
for i=1:length(P12megaDat(:,1))
    if P12megaDat(i,1)> 200
        bigmat12(n,:)=P12megaDat(i,:);
        bigmat12(n,1)=(P12megaDat(i,1)+jdaybegin);
        n=n+1;
    elseif P12megaDat(i,1)<40
        bigmat12(n,:)=P12megaDat(i,:);
        bigmat12(n,1)=(P12megaDat(i,1)+jday2017);
        n=n+1;
  
        
    end
    
end


bigmat3(bigmat3(:,:)==0)=NaN;
bigmat3(:,1)=bigmat3(:,1)-jdaybegin;
bigmat4(bigmat4(:,:)==0)=NaN;
bigmat4(:,1)=bigmat4(:,1)-jdaybegin;
bigmat5(bigmat5(:,:)==0)=NaN;
bigmat5(:,1)=bigmat5(:,1)-jdaybegin;
bigmat9(bigmat9(:,:)==0)=NaN;
bigmat9(:,1)=bigmat9(:,1)-jdaybegin;
bigmat10(bigmat10(:,:)==0)=NaN;
bigmat10(:,1)=bigmat10(:,1)-jdaybegin;
bigmat12(bigmat12(:,:)==0)=NaN;
bigmat12(:,1)=bigmat12(:,1)-jdaybegin;

plot(bigmat3(:,1),10./ bigmat3(:,2))
hold on;
plot(bigmat4(:,1), 10./bigmat4(:,2))
plot(bigmat5(:,1), 10./bigmat5(:,2))
plot(bigmat9(:,1), 10./bigmat9(:,2))
plot(bigmat10(:,1), 10./bigmat10(:,2))

legend('P03', 'P04', 'P05', 'P09', 'P10')
xlabel('Days since 1 Jan 2016')
ylabel('z/L')
title('z/L for 5 sonic anemometers')
%xlim([235 240])

%% Test to see why it;s not working
% xvec=1:1:length(bigmat3);
% plot(xvec,bigmat3(:,1))
% hold on;
% xvec=1:1:length(bigmat4);
% plot(xvec,bigmat4(:,1))
% xvec=1:1:length(bigmat5);
% plot(xvec,bigmat5(:,1))
% xvec=1:1:length(bigmat9);
% plot(xvec,bigmat9(:,1))
% xvec=1:1:length(bigmat10);
% plot(xvec,bigmat10(:,1))
% 
% legend('P03', 'P04', 'P05', 'P09', 'P10')

%% Mean for same time series
% figure;
% mzL3=10/nanmean(bigmat3(:,2));
% mzL4=10/nanmean(bigmat4(:,2));
% mzL5=10/nanmean(bigmat5(:,2));
% mzL9=10/nanmean(bigmat9(:,2));
% mzL10=10/nanmean(bigmat10(:,2));
% mzL12=10/nanmedian(bigmat12(:,2));
% p2=bar([mzL3, mzL4, mzL5, mzL9, mzL10, mzL12])
% set(p2,'FaceColor',[0.5 1 0.4])
% 
% 
% Anames={'P03'; 'P04'; 'P05'; 'P09'; 'P10' , 'P12'};
% set(gca,'xticklabel',Anames)
% xlabel('10m Anemometer Towers')
% ylabel(' mean z/L')
% title('Mean z/L for 5 Sonic Anemomter Towers')

%% Interpolate to average values across towers
%close all;

bigmat3=[ bigmat3 round(bigmat3(:,1),3)];
bigmat3=[ bigmat3 round(bigmat3(:,2),3)];
bigmat3(12177:end,:)=[];
bigmat4=[ bigmat4 round(bigmat4(:,1),2)];
bigmat4=[ bigmat4 round(bigmat4(:,2),2)];
bigmat4(12318:end,:)=[];
bigmat5=[ bigmat5 round(bigmat5(:,1),2)];
bigmat5(10618:end,:)=[];
bigmat9=[ bigmat9 round(bigmat9(:,1),2)];
bigmat9(12729:end,:)=[];
bigmat10=[ bigmat10 round(bigmat10(:,1),2)];
bigmat10(12370:end,:)=[];
bigmat12=[bigmat12 round(bigmat12(:,1), 2)];
bigmat12(8847:end, :)=[];

bigmat3(isnan(bigmat3)) = 0;
bigmat4(isnan(bigmat4)) = 0;
bigmat5(isnan(bigmat5)) = 0;
bigmat9(isnan(bigmat9)) = 0;
bigmat10(isnan(bigmat10)) = 0;

% calculate vq which is L on a standard interval time scale
xq=120:0.01:406; %standard time interval 
tq=200:0.01:406;
vq3 = interp1(bigmat3(:,6),bigmat3(:,2),xq,'nearest');
vq4=interp1(bigmat4(:,6),bigmat4(:,2),xq, 'nearest');
vq5=interp1(bigmat5(:,6),bigmat5(:,2),xq, 'nearest');
vq9=interp1(bigmat9(:,6),bigmat9(:,2),xq, 'nearest');
vq10=interp1(bigmat10(:,6),bigmat10(:,2),xq, 'nearest');
vq12=interp1(bigmat12(:,6), bigmat12(:,2), tq, 'nearest');

plot(xq,10./vq3)
hold on;
plot(xq,10./vq4)
plot(xq,10./vq5)
plot(xq,10./vq9)
plot(xq,10./vq10)
%plot(bigmat3(:,1),10./ bigmat3(:,2))
%plot(xq, 10./vq4)
ylim([-500 500])



%Iterpolate for TI

vqTI3=interp1(bigmat3(:,6),bigmat3(:,3),xq,'nearest');
vqTI4=interp1(bigmat4(:,6),bigmat4(:,3),xq,'nearest');
vqTI5=interp1(bigmat5(:,6),bigmat5(:,3),xq,'nearest');
vqTI9=interp1(bigmat9(:,6),bigmat9(:,3),xq,'nearest');
vqTI10=interp1(bigmat10(:,6),bigmat10(:,3),xq,'nearest');
vqTI12=interp1(bigmat12(:,6), bigmat12(:,3), tq, 'nearest');


figure
plot(xq,vqTI3)
hold on;
plot(xq,vqTI4)
plot(xq,vqTI5)
plot(xq,vqTI9)
plot(xq,vqTI10)

% Interpolate for TKE
vqTKE3=interp1(bigmat3(:,6),bigmat3(:,4),xq,'nearest');
vqTKE4=interp1(bigmat4(:,6),bigmat4(:,4),xq,'nearest');
vqTKE5=interp1(bigmat5(:,6),bigmat5(:,4),xq,'nearest');
vqTKE9=interp1(bigmat9(:,6),bigmat9(:,4),xq,'nearest');
vqTKE10=interp1(bigmat10(:,6),bigmat10(:,4),xq,'nearest');
vqTKE12=interp1(bigmat12(:,6), bigmat12(:,4), tq, 'nearest');
vqWS12=interp1(bigmat12(:,6), bigmat12(:,5), tq, 'nearest');

%% %% Median for same time series
figure;
mzL3=10/nanmedian(bigmat3(:,2));
mzL4=10/nanmedian(bigmat4(:,2));
mzL5=10/nanmedian(bigmat5(:,2));
mzL9=10/nanmedian(bigmat9(:,2));
mzL10=10/nanmedian(bigmat10(:,2));
p2=bar([mzL3, mzL4, mzL5, mzL9, mzL10]);
set(p2,'FaceColor',[0.5 1 0.4])


Anames={'P03'; 'P04'; 'P05'; 'P09'; 'P10' };
set(gca,'xticklabel',Anames)
xlabel('10m Anemometer Towers')
ylabel(' median z/L')
title('Median z/L for 5 Sonic Anemomter Towers')

%% Bias check
% create a matrix containing z/L values on the xq time scle
zLvec=zeros(length(vq3), 5);
zLvec(:,1)=10./vq3;
zLvec(:,2)=10./vq4;
zLvec(:,3)=10./vq5;
zLvec(:,4)=10./vq9;
zLvec(:,5)=10./vq10;

%calculate mean of towers 4-10
for i=1:length(zLvec)
    medvec3(i)=median(zLvec(i,2:5));
end
figure;
subplot(3,2,1)
scatter(medvec3(1:10000), zLvec(1:10000,1), '.','MarkerEdgeColor',[0 .5 .5])
hold on;
xlim([ -2 2])
ylim([ -2 2])
ylabel('z/L P03')
% xlim([ -5 5])
% ylim([ -5 5])
xlabel('median z/L from P04, P05, P09, P10 towers')
ylabel('z/L from P03 tower')
lvec=[-100:1:100];
plot(lvec, lvec,'--k','Linewidth', 1.5)
title('P03 Systematic Bias')


for i=1:length(zLvec)
    medvec4(i)=median([zLvec(i,1) zLvec(i,3:5)]);
end
subplot(3,2,2)
scatter(medvec4(1:10000), zLvec(1:10000,2),'.','MarkerEdgeColor',[0 0.4470 0.7410])
hold on;
plot(lvec, lvec,'--k', 'Linewidth', 1.5)
xlim([ -2 2])
ylim([ -2 2])
xlabel('median z/L from P03, P05, P09, P10 towers')
ylabel('z/L from P04 tower')
title('P04 Systematic Bias')


for i=1:length(zLvec)
    medvec5(i)=median([zLvec(i,1:2) zLvec(i,4:5)]);
end
subplot(3,2,3)
scatter(medvec5(1:10000), zLvec(1:10000,3),'.','MarkerEdgeColor',[0.8500 0.3250 0.0980])
hold on;
plot(lvec, lvec,'--k', 'Linewidth', 1.5)
xlim([ -2 2])
ylim([ -2 2])
xlabel('median z/L from P03, P04, P09, P10 towers')
ylabel('z/L from P05 tower')
title('P05 Systematic Bias')


for i=1:length(zLvec)
    medvec9(i)=median([zLvec(i,1:3) zLvec(i,5)]);
end
subplot(3,2,4)
scatter(medvec9(1:10000), zLvec(1:10000,4),'.','MarkerEdgeColor',[0.4940 0.1840 0.5560])
hold on;
plot(lvec, lvec,'--k', 'Linewidth', 1.5)
xlim([ -2 2])
ylim([ -2 2])
xlabel('median z/L from P03, P04, P05, P10 towers')
ylabel('z/L from P09 tower')
title('P09 Systematic Bias')

for i=1:length(zLvec)
    medvec10(i)=median([zLvec(i,1:4)]);
end
subplot(3,2,5)
scatter(medvec10(1:10000), zLvec(1:10000,5),'.','MarkerEdgeColor',[0.4660 0.6740 0.1880])
hold on;
plot(lvec, lvec,'--k', 'Linewidth', 1.5)
xlim([ -2 2])
ylim([ -2 2])
xlabel('median z/L from P03, P04, P05, P09 towers')
ylabel('z/L from P10 tower')
title('P10 Systematic Bias')

%% P03 systematic bias heat map
%close all;
figure
medvec3(find(medvec3 > 1))=NaN;
zLvec(find(zLvec >1))=NaN;
medvec3(find(medvec3 < -1))=NaN;
zLvec(find(zLvec <-1))=NaN;
X = [medvec3', zLvec(:,1)];
% xlim([ 2])
% ylim([-2 2])
hist3(X,'CdataMode','auto','Nbins', [200 200], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('median z/L from P04, P05, P09, P10 towers')
ylabel('z/L from P03 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('P03 Systematic Bias')
lvec=[-100:1:100];
hold on;
plot(lvec, lvec,'k','Linewidth', 4)

%% TI vs mean/ median L from P04 P05 P10

medL=zeros(1,length(xq));
meanL=zeros(1,length(xq));
for i=1:length(xq)
    medL(i)=nanmedian([vq4(i) vq5(i) vq9(i)]);
    meanL(i)=nanmean([ vq4(i) vq5(i) vq9(i)]);
end

%% MEAN TKE vs L subplot
close all;
medL(find(10./medL > 5))=NaN;
meanL(find(10./meanL >5))=NaN;
medL(find(10./medL < -5))=NaN;
meanL(find(10./meanL <-5))=NaN;
vqTKE4(find(vqTKE4 > 40))=NaN;
vqTKE5(find(vqTKE5 > 40))=NaN;
vqTKE10(find(vqTKE10 > 40))=NaN;



figure;
subplot(2,3,1)
hist3([10./meanL', vqTKE3'],'CdataMode','auto','Nbins', [200 200], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TKE from P03 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P03 vs Mean z/L')
%xlim([-500 500])
caxis([0 175])
ylim([0 10])
grid off


subplot(2,3,2)
%mean L vs TI from P04
hist3([10./meanL', vqTKE4'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TKE from P04 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P04 vs Mean z/L')
%xlim([-500 500])
%ylim([0 1])
%caxis([0 175])
ylim([0 10])
grid off

%mean L vs TI from P05
subplot(2,3,3)
hist3([10./meanL', vqTKE5'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TKE from P05 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P05 vs Mean z/L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
ylim([0 10])
grid off


%mean L vs TI from P09
subplot(2,3,4)
hist3([10./meanL', vqTKE9'],'CdataMode','auto','Nbins', [200 200], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TKE from P09 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P09 vs Mean L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
ylim([0 10])
grid off


%mean L vs TI from P10
subplot(2,3,5)
hist3([10./meanL', vqTKE10'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P10 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P10 vs Mean z/L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
%colormap(flipud(hot))
ylim([0 10])
grid off
sgtitle('TKE vs Mean z/L')
%%  Median z/L vs TKE subplot

figure;
subplot(2,3,1)
hist3([10./medL', vqTKE3'],'CdataMode','auto','Nbins', [200 200], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TKE from P03 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P03 vs Median z/L')
%xlim([-500 500])
caxis([0 175])
ylim([0 10])
grid off


subplot(2,3,2)
%mean L vs TI from P04
hist3([10./medL', vqTKE4'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TKE from P04 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P04 vs Median z/L')
%xlim([-500 500])
%ylim([0 1])
caxis([0 175])
ylim([0 10])
grid off

%mean L vs TI from P05
subplot(2,3,3)
hist3([10./medL', vqTKE5'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TKE from P05 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P05 vs Median z/L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
ylim([0 10])
grid off


%mean L vs TI from P09
subplot(2,3,4)
hist3([10./medL', vqTKE9'],'CdataMode','auto','Nbins', [200 200], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TKE from P09 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P09 vs Median z/L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
ylim([0 10])
grid off


%mean L vs TI from P10
subplot(2,3,5)
hist3([10./medL', vqTKE10'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TI from P10 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P10 vs Median z/L')
% xlim([-500 500])
%ylim([0 1])
caxis([0 175])
%colormap(flipud(hot))
ylim([0 10])
grid off
sgtitle('TKE vs Median z/L')
%%  TI vs MEAN L subplot

%plot TI from each tower based on average L from 3 sonic anemometer towers
medL(find(10./medL > 5))=NaN;
meanL(find(10./meanL >5))=NaN;  %%%%%%%% Get rid of outlier data
medL(find(10./medL < -5))=NaN;
meanL(find(10./meanL <-5))=NaN;


figure;
%mean L vs TI from P03
subplot(2,3,1)
hist3([10./meanL', vqTI3'],'CdataMode','auto','Nbins', [170 170], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P03 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P03 vs Mean z/L')
%xlim([-500 500])
caxis([0 80])
grid off


subplot(2,3,2)
%mean L vs TI from P04
hist3([10./meanL', vqTI4'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P04 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P04 vs Mean z/L')
%xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off

%mean L vs TI from P05
subplot(2,3,3)
hist3([10./meanL', vqTI5'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P05 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P05 vs Mean z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off


%mean vs TI from P09
subplot(2,3,4)
hist3([10./meanL', vqTI9'],'CdataMode','auto','Nbins', [170 170], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P09 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P09 vs Mean z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off


%mean L vs TI from P10
subplot(2,3,5)
hist3([10./meanL', vqTI10'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P10 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P10 vs Mean z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
%colormap(flipud(hot))
grid off

sgtitle('TI vs Mean z/L')



%%  TI vs MEDIAN L subplot

figure;
%mean L vs TI from P03
subplot(2,3,1)
hist3([10./medL', vqTI3'],'CdataMode','auto','Nbins', [170 170], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TI from P03 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P03 vs Median z/L')
%xlim([-500 500])
caxis([0 80])
grid off


subplot(2,3,2)
%mean L vs TI from P04
hist3([10./medL', vqTI4'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Med z/L from P04, P05, P10 towers')
ylabel('TI from P04 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P04 vs Median z/L')
%xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off

%mean L vs TI from P05
subplot(2,3,3)
hist3([10./medL', vqTI5'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from P05 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P05 vs Median z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off


%mean vs TI from P09
subplot(2,3,4)
hist3([10./medL', vqTI9'],'CdataMode','auto','Nbins', [170 170], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TI from P09 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P09 vs Median z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
grid off


%mean L vs TI from P10
subplot(2,3,5)
hist3([10./medL', vqTI10'],'CdataMode','auto','Nbins', [200 400], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TI from P10 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P10 vs Median z/L')
% xlim([-500 500])
ylim([0 1])
caxis([0 80])
%colormap(flipud(hot))
grid off

sgtitle('TI vs Median z/L')

%% TI and TKE from 80m compared with Median L values form p04 P05 P10

figure;
subplot(1,2,1)
hist3([10./medL(8001:end)', vqTI12'],'CdataMode','auto','Nbins', [600 250], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TI from 80m P12 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P12 vs Median z/L from P04 P05 P10')
% xlim([-500 500])
ylim([0 1])
caxis([0 30])
xlim([ -2 2])
%colormap(flipud(hot))
grid off

subplot(1,2,2)
hist3([10./meanL(8001:end)', vqTI12'],'CdataMode','auto','Nbins', [600 250], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TI from 80m P12 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI from P12 vs Mean z/L from P04 P05 P10')
% xlim([-500 500])
ylim([0 1])
caxis([0 30])
xlim([-2 2])
%colormap(flipud(hot))
grid off
sgtitle('TI from P12 vs z/L')
%%


figure;
subplot(1,2,1)
hist3([10./medL(8001:end)', vqTKE12'],'CdataMode','auto','Nbins', [250 500], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Median z/L from P04, P05, P10 towers')
ylabel('TKE from 80m P12 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P12 vs Median z/L from P04 P05 P10')
% xlim([-500 500])
ylim([0 7])
caxis([4 60])
%colormap(flipud(hot))
grid off
xlim([-3 3] )


subplot(1,2,2)
hist3([10./meanL(8001:end)', vqTKE12'],'CdataMode','auto','Nbins',[250 500], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Mean z/L from P04, P05, P10 towers')
ylabel('TKE from 80m P12 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TKE from P12 vs Mean z/L from P04 P05 P10')
% xlim([-500 500]
ylim([0 7])
caxis([4 60])
xlim([-3 3] )
grid off
sgtitle('TKE from P12 vs z/L')

%% TI vs WS from 80m P12 tower

scatter(vqWS12, vqTI12, '.')
ylim([ 0 1] )
xlabel('Wind Speed (m/s) at P12 tower')
ylabel('TI from 80m P12 tower')
title('TI vs Wind Speed at P12')
hold on;
x=linspace(0,25, length(tq));

fit1 = fit(vqWS12,vqTI12,'3')
% plot(fit1)
%%
figure;

scatter(vqWS12, vqTKE12, '.')
ylim([ 0 1] )
xlabel('Wind Speed (m/s) at P12 tower')
ylabel('TKE from 80m P12 tower')
title('TKE vs Wind Speed at P12')
%%
hist3([vqWS12', vqTI12'],'CdataMode','auto','Nbins',[150 150], 'EdgeColor', 'none')
set(gca,'zscale', 'log');
xlabel('Wind Speed (m/s) at P12 tower')
ylabel('TI from 80m P12 tower')
a = colorbar;
a.Label.String = 'Number of Points in bin';
view(2)
title('TI vs Wind Speed at P12')
% xlim([-500 500]
ylim([0 1])
caxis([4 10])
xlim([0 25] )
grid off
