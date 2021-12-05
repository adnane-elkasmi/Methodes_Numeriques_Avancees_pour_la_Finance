tracer_condition_limites()
    
function [] = tracer_condition_limites()

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

% Implementation des conditions aux limites %

for n=1:M+1
    V(n,1)=0;
    V(n,N+2)=L-K*exp(-r*(T-t(n)));
end

figure;
plot(t,V(:,1));
plot(t,V(:,N+2))
xlabel('temps t')
title('Conditions aux limites')

end


