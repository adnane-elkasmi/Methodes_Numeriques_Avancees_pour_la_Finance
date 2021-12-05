
Graphe_Call_Europ()

function [] = Graphe_Call_Europ()

% Définition des constantes %

K=10;
L=20;
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

for j=1:N+2
    V(M+2,j)=Payoff_Europ_Call(S(j),K);
end

% Implementation des conditions aux limites Dirichlet %

for k=1:M+1
    V(k,1)=0;
    V(k,N+2)=L-K*exp(-r*(T-t(k)));
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end
end

% Methode Monte-Carlo pour calculer S quelconque %

for l=1:N+2
    S0(l)=(l-1)*(L/(N+2));
    prix_option(l)=Prix_Europ_S0_fixe_MC(S0(l));
end

figure;
hold;
plot(S0,prix_option)
plot(S,V(1,:));
plot(S0,Payoff_Europ_Call(S0,K))
xlabel('Prix S0')
ylabel('V(t=0,S0)')
legend('Monte-Carlo','Différences Finies','Payoff\_Europ\_Call')
title('Graphe du prix call de l option Européenne Nmc=1000')

end

function [prix] = Prix_Europ_S0_fixe_MC(S0)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nmc=1000;
sum=0;

% Methode Monte-Carlo pour calculer S %

for n=1:Nmc
    S(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    sum=sum+Payoff_Europ_Call(S(n),K);
end

prix=exp(-r*T)*sum/Nmc;
end

% la condition finale %

function [f] = Payoff_Europ_Call(S,K)
f=max(S-K,0);
end
