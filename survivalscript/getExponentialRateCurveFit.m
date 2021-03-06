% GET RATE USING AN EXPONENTIAL MODEL OF THE TYPE ' y = N^rx ' where 'N' is the initial size of the population 
%'r' is the decay rate and 'x' is time. In this case 'y' represents
%survival percentage
function [decayRate] = getdecayRate(survival, pls);
%We generate decay rate data for each well using survival time and
%percentage
for i= pls %1:length(survival);%[1 3:8 10:18];
    X = survival(i).t;%we generate these vectors to fit them later to an exponential fit
    Y = survival(i).s;   
    tmpRate = [];
    for w = 1:96;
        
        cien = find((Y(:,w)) == 100 ); %esta secci?n es para que no calcule el ajuste con los primeros d?as en los que todav?a no hay 100% de crecimiento
        if cien > 1
            Y(1:cien-1,w)=NaN;
        end
        
        f = find(~isnan(Y(:,w))); %index created to elminate NaN
        if length(f)<3;%fit needs at least more than 2 data points
            tmpfit.b = NaN;%if this is the case then 'b' or rate equals NaN 
        else
                tmpfit = CurveFit(X(f,w),Y(f,w),'exp1'); %CurveFit, vi que el "fit" de la compu del lab y el "fit" de esta compu son distintos, baj'e el del lab y le puse CurveFit
        end
           tmpRate = [tmpRate,tmpfit.b];%Decay Rate
           decayRate(i) = struct('r',tmpRate);%Matrix containing decay rate for each well acording to time and survival.s
     
    end
     
end

