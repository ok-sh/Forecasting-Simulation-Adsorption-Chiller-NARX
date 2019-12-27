%2.Validation
%Test Prediction the Network
%test_perform_narx Closed Loop: Multi-Step Prediction
Xtest = tonndata(Inputs_2,false,false);
Ttest = tonndata(Targets_2,false,false);
whos Xtest Ttest;
[x,xi,ai,t] = preparets(netc,Xtest,{},Ttest);
y2 = netc(x,xi,ai);
e3 = gsubtract(t,y2);
test_perform = perform(netc,t,y2);
e22=cell2mat(e3');
plot(e22);
clear  e22;
%%
%Plot Regression all
%Plot Regression
trOut = yc(tr.trainInd);
vOut = yc(tr.valInd);
tsOut = yc(tr.testInd);
trTarg = Tc(tr.trainInd);
vTarg = Tc(tr.valInd);
tsTarg = Tc(tr.testInd);
plotregression(trTarg, trOut, 'Train', vTarg, vOut, 'Validation', tsTarg, tsOut, 'Testing',t, y2, 'Validation 2');
set(gcf,'toolbar','figure');
plot(trTarg, trOut);

%%
%Seperate Regression
%Targets
at=cell2mat(t);
aaThot=num2cell(at(1,:));
aaTvd=num2cell(at(2,:));
aaTrk=num2cell(at(3,:));
%Outputs
ab=cell2mat(y2);
abThot=num2cell(at(1,:));
abTvd=num2cell(at(2,:));
abTrk=num2cell(at(3,:));

plotregression(aaThot,abThot,'Validation T_h_o_t');
