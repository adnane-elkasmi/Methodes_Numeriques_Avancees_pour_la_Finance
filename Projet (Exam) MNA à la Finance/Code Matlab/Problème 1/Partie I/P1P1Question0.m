

tracer_condition_finale()
    
function [] = tracer_condition_finale()

% Définition des constantes %

r0=0.3;
sigma=0.5;
L=40;
K=10;
T=0.5;
N=99;
M=1999;

% Définition des vecteurs %

S=linspace(0,L,N+2);
t=linspace(0,T,M+2);
dt=T/(M+2);
ds=L/(N+2);
V=zeros(M+2,N+2);

% Implementation de la condition finale %

for i=1:N+2
    V(M+2,i)=Pay_off_Asset(S(i),K);
end

figure;
plot(S,V(M+2,:))
xlabel('Prix S')
title('Condition finale')

end


function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
else
    f=0;
end

end


