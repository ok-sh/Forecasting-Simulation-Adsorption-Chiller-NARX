
%generate a NARX network and trainings properties

net = narxnet(iD,fD,hiddenSizes,'open',trainM);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
trainM = 'trainlm';
iD = 1:4;
fD = 1:4;
hiddenSizes = 15;
net.trainParam.min_grad = 1.0e-20;
net.trainParam.mu_max =1.0e15;
%Preparing Data 
%Inputs=Inputs'; %row or column data sets?
%Targets=Targets';
X = tonndata(Inputs_1,false,false); %for columns
T = tonndata(Targets_1,false,false);
whos X T; %short check
%Preparing Data 
[Xs,Xi,Ai,Ts] = preparets(net,X,{},T);
%Setup Division of Data for Training, Valitation, Testing
net.divideFcn = 'divideblock';  % Divide data
%net.divideMode = 'time'; %Divide up every sample
net.divideParam.trainRatio = 75/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 10/100;

%Performance funktion
net.performFcn = 'mse';  % Mean Squared Error

%Plotfunctions
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotresponse', 'ploterrcorr', 'plotinerrcorr'};

% TRAINING
[net,tr] = train(net,Xs,Ts,Xi,Ai);

%TEST
y = net(Xs,Xi,Ai);
e = gsubtract(Ts,y);
performance = perform(net,Ts,y);
view(net);
plotregression(Ts,y);
%plotresponse(Ts,'T_hot_out',Narx_Out);

% Plots
 figure, plotperform(tr)
 figure, plottrainstate(tr)
 figure, ploterrhist(e)
 figure, plotregression(Ts,y)
 figure, plotfit(net,x,t)


