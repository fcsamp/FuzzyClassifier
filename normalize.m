function x = normalize(x0)

% Funcao retorna vetor x0 normalizado

x = (x0 - min(x0))./(max(x0)-min(x0));

end