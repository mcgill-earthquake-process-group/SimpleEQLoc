clc;clear all;



run('./src/globalVar.m');
notuseS = 0;% 0: use S phases; 1: not use S phases
visualize = 0;% 1:plot RMS during iterations
Pwt= 1; Swt = 1;
examplePath = './examples/example1/';

origLat = 37.2893;
origLon = -121.6692;
fEvt  = [examplePath,'/event.dat'];
fSta = [examplePath,'/station.dat'];
fPhase = [examplePath,'/ttime.csv'];
fVel = [examplePath,'/vel.mod'];
status = readData(fEvt,fSta,fPhase,fVel,origLat,origLon);

evtNum = length(evtID);
[~,phaseStaID] = ismember(phaseSta,staNameSorted);


%% GridSearch
for i = 1:evtNum
    locI = find(phaseEvt == evtID(i));
    staIDI = phaseStaID(locI);
    staXI = staX(staIDI); staYI = staY(staIDI);

    ttimeMatrix = ttime(locI);
    ttimeMatrixWt = phaseWt(locI);
    ttimeMatrixPhase = wvphase(locI);
    
   visualize =0;
   f=@calEQRMS;
   options = optimset('PlotFcns',@optimplotfval);
   EQloc0 = [evtX(i),evtY(i),evtDep(i),0];% x y z origin time.
   lb = [-100 -100 0.05 -100];
   ub = [100 100 30 100];
   if visualize
      [EQloc,RMS] = fmincon(f,EQloc0,[],[],[],[],lb,ub,[],options);
   elseif ~visualize
      [EQloc,RMS] = fmincon(f,EQloc0,[],[],[],[],lb,ub);
   end
    [lat(i),lon(i)]=utm2ll (EQloc(1)*1000+X0,EQloc(2)*1000+Y0,F0);
end

