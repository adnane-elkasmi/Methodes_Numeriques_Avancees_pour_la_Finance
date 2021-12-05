tracer_condition_finale()
    
function [] = tracer_condition_finale()

% Définition des constantes %

L=20;
K=10;
T=0.5;
r=0.1;
sigma=0.5;
N=99;
M=4999;

% Définition des vecteurs %

S=linspace(0,L,N+2);
t=linspace(0,T,M+2);
dt=T/(M+2);
ds=L/(N+2);
V=zeros(M+2,N+2);

% Implementation de la condition finale %

for i=1:N+2
    V(M+2,i)=condition_finale(S(i),K);
end

figure;
plot(S,V(M+2,:))
xlabel('Prix S')
title('Condition finale')

end

% la condition finale %

function [f] = condition_finale(S,K)
f = max(S-K,0);
end

