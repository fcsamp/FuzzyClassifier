function [classe,CF] = outRule(B)

[Bmax,classe] = max(B,[],2);

CF = (Bmax - ((sum(B,2)-Bmax)./2))./sum(B,2);