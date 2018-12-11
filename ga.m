clear;clc;

n = 20;             % numero de individuos
d = 353;            % numero de variaveis
tmax = 1e3;         % numero maximo de geracoes
mr = 0.01;          % taxa de mutacao
cr = 0.8;           % taxa de cruzamento    
mantem = 10;        % individuos mantidos para a prox geracao 

x = zeros(n,d);
fitness = zeros(n,1);
pai = zeros(n-mantem,d);

% cria a populacao inicial e avalia cada individuo

for i=1:n
    
    x(i,:) = randi([0 1],[1 353]);
    
    fitness(i) = fob(x(i,:));
    
end

% ordena a populacao em ordem decrescente

t = 0;                      % inicializa contador de geracoes
conv = zeros(1,tmax);       % armazena as aptidoes
conv_md = zeros(1,tmax);    % armazena a media das aptidoes

progressbar(0)

while t < tmax

    progressbar(t/tmax)
    
    t = t + 1;
    
    % organiza os individuos do mais apto ao menos apto
    
    [fitness,index] = sort(fitness,'descend');
    x = x(index,:);
    
    best = x(1,:);                  % melhor individuo
    fmax = fitness(1);              % menor valor encontrado
    conv(t) = fmax;                 % curva de convergencia
    conv_md(t) = mean(fitness);     % curva da media de aptidao

    % Selecao
    
    % calcula as probabilidades de selecao de cada individuo
    
    prob = fitness - min(fitness);      % normaliza fitness
    prob = cumsum(prob);                % calcula a soma acumulada das aptidoes
    prob = prob./max(prob);             % divide pela soma de todas as aptidoes
    prob = [0; prob];
    
    % Realiza a selecao de (n-mantem) pais
    
    for i=1:(n-mantem)
        
        r = rand;   % escolhe valor aleatorio
        
        for k=1:n-1 

            if prob(k) <= r && r <= prob(k+1)   % encontra intervalo ao qual o valor pertence

                pai(i,:) = x(k,:);    % seleciona os pais 

            end
            
        end
        
    end 
 
    % Cruzamento 
    
    for i=1:2:(n-mantem-1)
        
        if rand < cr
                       
            % Crossover Simples
            
            % Seleciona um valor dentro da dimensao
            
            a = randi(d,1);  
            
            x(mantem+i,:) = [pai(i,1:a) pai(i+1,(a+1):d)];
            x(mantem+i+1,:) = [pai(i+1,1:a) pai(i,(a+1):d)];
            
        end
     
    end

    % Mutacao
    
    for i=(mantem+1):n
       
        for j=1:d
            
            if rand < mr
               
                if x(i,j) == 0
                    
                    x(i,j) = 1;
                    
                elseif x(i,j) == 1
                    
                    x(i,j) = 0;
                    
                end
                
            end
            
        end
        
    end
    
    % Atualiza a aptidao dos individuos
    
    for i=1:n
    
        fitness(i) = fob(x(i,:));
    
    end
     
end

progressbar(1)

plot(conv)
grid
title('Convergencia')
ylabel('Aptidao')
xlabel('Iteracoes')
