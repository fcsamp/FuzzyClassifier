run banco.m

p1 = find(Yt == 1);     % Indices das variaveis classificadas como tipo 1
p2 = find(Yt == 2);     % Indices das variaveis classificadas como tipo 2
p3 = find(Yt == 3);     % Indices das variaveis classificadas como tipo 1

% Separa os conjunto de treinamento pelas suas respectivas classes

x1 = Xt(p1,:);
x2 = Xt(p2,:); 
x3 = Xt(p3,:);     

% Define as funcoes de pertinencia consideradas no problema

MF1 = [0 0 0.5];
MF2 = [0.5 1 1];
MF3 = [0 0.5 1];
MF4 = [0 0.25 0.5];
MF5 = [0.5 0.75 1];

% Matrizes com as funcoes de pertinencia de cada sistema de inferencia K

S2 = [MF1;MF2];             % K = 2
S3 = [MF1;MF2;MF3];         % K = 3
S4 = [MF1;MF2;MF4;MF5];     % K = 4

% Obtem as matrizes com as intensidades de cada classe para cada regra

B2 = [intensity(x1,S2),intensity(x2,S2),intensity(x3,S2)];  % Intensidades do sistema 2
B3 = [intensity(x1,S3),intensity(x2,S3),intensity(x3,S3)];  % Intensidades do sistema 3
B4 = [intensity(x1,S4),intensity(x2,S4),intensity(x3,S4)];  % Intensidades do sistema 4

% Obtem os consequentes (Classe e CF) de cada regra de cada sistema

[CL2,CF2] = outRule(B2);       % Classes e CF's do sistema de regras 2
[CL3,CF3] = outRule(B3);       % Classes e CF's do sistema de regras 3 
[CL4,CF4] = outRule(B4);       % Classes e CF's do sistema de regras 4 

% Validacao do Classificador

[nlin,~] = size(Xv);     

yx = zeros(nlin,1);     % Recebe as respostas do classificador

for i = 1:nlin
   
    x = Xv(i,:);        % Coleta variavel do Banco de Validacao
    
    alfa2 = compatibility(x,S2,CF2);    % Obtem compatibilidades das regras do sistema 2
    alfa3 = compatibility(x,S3,CF3);    % Obtem compatibilidades das regras do sistema 3
    alfa4 = compatibility(x,S4,CF4);    % Obtem compatibilidades das regras do sistema 4
    
    % Obtem as maiores compatibilidades de cada sistema de regras
    
    [a2,i2] = max(alfa2);       
    [a3,i3] = max(alfa3);
    [a4,i4] = max(alfa4);
        
    % Obtem a maior compatibilidade dentre os sistemas de regras
    
    [alfa,index] = max([a2, a3, a4]);   
 
    % Baseado no indice, obtem a classe a qual o indice pertence
    
    if index == 1
        
        yx(i) = CL2(i2);
        
    elseif index == 2
        
        yx(i) = CL3(i3);
        
    elseif index == 3  
        
        yx(i) = CL4(i4);
    
    end

end

numel(find(yx == Yv))/numel(Yv)     % Taxa de Acerto
