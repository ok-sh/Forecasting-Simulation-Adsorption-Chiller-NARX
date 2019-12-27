
%Prepare Data
Xc = tonndata(Inputs_1,false,false);
Tc = tonndata(Targets_1,false,false);
whos Xc Tc; %short check

%Close the loop to make Multi-step Prediction
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc);
[xc,xic,aic,tc] = preparets(netc,Xc,{},Tc);
yc = netc(xc,xic,aic);
closedLoopPerformance = perform(net,tc,yc);

%---------------- Optional
%Step-Ahead Prediction Network 
%nets = removedelay(net);
%nets.name = [net.name ' - Predict One Step Ahead'];
%view(nets)
%[xs,xis,ais,ts] = preparets(nets,X,{},T);
%ys = nets(xs,xis,ais);
%stepAheadPerformance = perform(nets,ts,ys);
%---------------

%TRAINING Properties
netc.divideFcn = 'divideblock';  
netc.divideMode = 'time'; %Divide up every sample
netc.divideParam.trainRatio = 75/100;
netc.divideParam.valRatio = 15/100;
netc.divideParam.testRatio = 10/100;
netc.performFcn = 'mse'; %Performance function Mean Squared Error

%Plotfunctions
netc.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotresponse', 'ploterrcorr', 'plotinerrcorr'};

% TRAINING again for better results
[netc,tr] = train(netc,xc,tc,xic,aic);

%TEST
yc = netc(xc,xic,aic);
e = gsubtract(tc,yc);
closedLoopPerformance2 = perform(netc,tc,yc);

