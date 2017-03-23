function [ ttimeRMS ] = calEQRMS( input )

run('globalVar.m');
x=input(1);
         y=input(2);
         z=input(3);
if length(input) == 4
         
         t=input(4);
elseif length(input) ==3;
    t = 0;
end

   deltaI = sqrt((repmat(x,length(locI))-staXI).^2+...
    (repmat(y,length(locI))-staYI).^2);  
         
        ttimeMatrixCal = zeros(size(ttimeMatrix));
for j = 1:length(ttimeMatrix)
    if ttimeMatrixPhase{j} == 'P'
  [ thetaP, tCalP,isRefractP ,refractLayerP] = ...
        traveltimeCal( velMod',depthMod',deltaI(j),z );
      ttimeMatrixCal(j) = tCalP;
    elseif ttimeMatrixPhase{j} == 'S'
        [ thetaS, tCalS,isRefractS ,refractLayerS] = ...
        traveltimeCal( velMods',depthMod',deltaI(j),z );
    ttimeMatrixCal(j) = tCalS;
    end
    
end

ttimeRMS = sum(abs(ttimeMatrixCal-ttimeMatrix).*ttimeMatrixWt)...
    /(sum(ttimeMatrixWt));



end

