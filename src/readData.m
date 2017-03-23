function [ status ] = readData( fEvt,fSta,fPhase,fVel,origLat,origLon )

run('globalVar.m');
[X0,Y0,F0] = ll2utm(origLat,origLon);
vel = load(fVel);
velMod = vel(:,1);
velMods = velMod/1.73;
depthMod = vel(:,2);

evtData = load(fEvt);
evtID = evtData(:,14);
evtLat = evtData(:,7); 
evtLon = evtData(:,8);
evtDep = evtData(:,9);
[evtXT,evtYT,evtFT] = ll2utm(evtLat,evtLon);
evtX = (evtXT - X0)/1000;
evtY = (evtYT - Y0)/1000;

uSta = fopen(fSta);
staData = textscan(uSta,'%s %f %f');
fclose(uSta);
staName = staData{1};
staLat = staData{2};
staLon = staData{3};

staNameSorted = sort(staName);
[a,b]=intersect(staName,staNameSorted);
staLatSorted = staLat(b);
staLonSorted = staLon(b);
[staXT,staYT,staFT]  = ll2utm(staLatSorted,staLonSorted);
staX = (staXT - X0)/1000;
staY = (staYT - Y0)/1000;
staID = [1:length(staX)];


uTime = fopen(fPhase);
phaseData = textscan(uTime,'%f %s %f %f %s','Delimiter',',');
fclose(uTime);
phaseEvt = phaseData{1};
phaseSta = phaseData{2};
ttime = phaseData{3};
phaseWt = phaseData{4};
wvphase = phaseData{5};
status = 1;

end

