function [BETA,index] = intensity(x,MF)

% Funcao calcula as intensidades de cada regra para uma determinada classe

[nmf,~] = size(MF);     % numero de funcoes de pertinencia considerados

mi = [];

for i=1:nmf
   
    mi = [mi evalmf(x,MF(i,:),'trimf')]; % armazena as pertinencias de cada variavel
    
end

[~,ncol] = size(mi);

BETA = zeros(nmf^4,1);      % guarda as intensidades de cada regra
index = zeros(nmf^4,4);     % guarda os indices das regras

t=0;

for i = 1:4:(ncol-3)
    for j = 2:4:(ncol-2)
        for k = 3:4:(ncol-1)
            for l = 4:4:ncol
                
                t = t+1;
                
                index(t,:) = [i,j,k,l];
                
                BETA(t) = sum(mi(:,i).*mi(:,j).*mi(:,k).*mi(:,l));
                
            end
        end
    end
end