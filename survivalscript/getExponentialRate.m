% GET RATE USING AN EXPONENTIAL MODEL OF THE TYPE ' y = N^rx ' where 'N' is the initial size of the population 
%'r' is the decay rate and 'x' is time. In this case 'y' represents
%survival percentage
function [decayRate] = getExponentialRate(survival, pls);
%We generate decay rate data for each well using survival time and
%percentage
for i= pls %1:length(survival);%[1 3:8 10:18];
    X = survival(i).t;%/24;%we generate these vectors to fit them later to an exponential fit
    Y = survival(i).s;   
    tmpRate = [];
    tmpA =[];
    for w = 1:96;
        
        cien = find((Y(:,w)) == 100 ); %esta sección es para que no calcule el ajuste con los primeros días en los que todavía no hay 100% de crecimiento
        if cien > 1
            Y(1:cien-1,w)=NaN;
        end
        
        f = find(~isnan(Y(:,w))); %index created to elminate NaN
        if length(f)<3;%fit needs at least more than 2 data points
            tmpfit.b = NaN;%if this is the case then 'b' or rate equals NaN 
            tmpfit.a = NaN
        else
%                tmpfit = CurveFit(X(f,w),Y(f,w),'exp1'); %CurveFit, vi que el "fit" de la compu del lab y el "fit" de esta compu son distintos, baj'e el del lab y le puse CurveFit
%                 if i==4 && w==76 % lo usé para detener el script en el plato 4 pozo 76
%                     i
%                 end
                tmpfit = fit(X(f,w),Y(f,w),'exp1'); %Exponential Fit
        end
           tmpRate = [tmpRate,tmpfit.b];%Decay Rate
           tmpA = [tmpA ,tmpfit.a];%Decay Rate
           decayRate(i) = struct('r',tmpRate);%Matrix containing decay rate for each well acording to time and survival.s
           decayRate(i).r(2,:) = tmpA;
    end
end

