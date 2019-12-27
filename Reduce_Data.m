%Aufnahme 10. sek / Reduce the Data
end_data_I = size(Inputs);
end_data_O = size(Targets);
for n3 = 1:end_data_O(2)
for n2 = 1:end_data_I(2)
for n = 1:10:end_data_I(1)
    Inputs_red((n+9)./10,n2) = Inputs(n,n2);
    Targets_red((n+9)./10,n3) = Targets(n,n3);
end
end
end
Inputs_1=Inputs_red(1:40000,:);
Targets_1=Targets_red(1:40000,:);
Inputs_2=Inputs_red(40001:end,:);
Targets_2=Targets_red(40001:end,:);
clear n n2 n3 end_data_I end_data_O
