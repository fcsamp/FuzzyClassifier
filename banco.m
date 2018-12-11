% Script para tratar o banco de dados

load fisheriris.mat

x1 = normalize(meas(:,1));
x2 = normalize(meas(:,2));
x3 = normalize(meas(:,3));
x4 = normalize(meas(:,4));

y=zeros(numel(species),1);

for i=1:numel(species)
   
    if strcmp(species{i},'versicolor')
        
        y(i) = 1;
        
    elseif strcmp(species{i},'virginica')
        
        y(i) = 2;
        
    elseif strcmp(species{i},'setosa')
        
        y(i) = 3;
        
    end
        
end

X = [x1 x2 x3 x4];  Y = y;

pt = randperm(numel(Y),0.8*numel(Y));   % treino
pv = setdiff(1:numel(Y),pt);            % validacao

Xt = X(pt,:);
Yt = Y(pt,:);

Xv = X(pv,:);
Yv = Y(pv,:);

save params
