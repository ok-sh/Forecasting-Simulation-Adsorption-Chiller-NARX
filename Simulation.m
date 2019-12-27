%Prepare Data
Xc = tonndata(Inputs_1,false,false); 
Tc = tonndata(Targets_1,false,false);


%Close the loop to make multiple predicts
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc);
[xc,xic,aic,tc] = preparets(netc,Xc,{},Tc);
yc = netc(xc,xic,aic);
closedLoopPerformance = perform(net,tc,yc);

%Simulation Xs
sw=tonndata(Inputs,false,false);
[Xs,Xi,Ai,Ts] = preparets(net,sw,{},T);

Sim_Values=sim(net ,Xs);
Sim_Values=cell2mat(Sim_Werte);
plot(Sim_Values');

%Format data 
toPredict = tonndata(predict_input,false,false);
X = tonndata(knownInput,false,false);
A = tonndata(knownY,false,false);
[ai,ab,ac] = preparets(net_2,X,{},A);
[y1,xf,af] = net_2(ai,ab,ac);


