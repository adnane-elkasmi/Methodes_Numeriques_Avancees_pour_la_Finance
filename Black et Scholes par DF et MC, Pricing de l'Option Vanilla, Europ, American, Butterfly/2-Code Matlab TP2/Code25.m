
Graphe_MC_DF_Butterfly()

function [] = Graphe_MC_DF_Butterfly()

% Définition des constantes %

K=10;
L=60;
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
    V(M+2,j)=PayOff_Butterfly(S(j),K);
end

% Discrétisation de l'équation de Black et Scholes %

for n=M+2:-1:2
for i=2:N+1
    V(n-1,i)=V(n,i)+dt*(r*S(i)*(V(n,i+1)-V(n,i-1))/(2*ds)+(1/2)*(sigma^2)*(S(i)^2)*((V(n,i+1)+V(n,i-1)-2*V(n,i))/(ds^2))-r*V(n,i));    
end

% Implementation des conditions aux limites de Neumann %

    V(n-1,1)=V(n-1,2)+ds;
    V(n-1,N+2)=V(n-1,N+1);
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
plot(S0,PayOff_Butterfly(S0,K))
xlabel('Prix S0')
ylabel('V(t=0,S0)')
legend('Monte-Carlo','Différences Finies','Payoff\_Butterfly')
title('Graphe du prix call de l option Butterfly N_{mc}=100000')

end

function [prix] = Prix_Europ_S0_fixe_MC(S0)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nmc=100000;
sum=0;

% Methode Monte-Carlo pour calculer S %

for n=1:Nmc
    S(n)=S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*randn);
    sum=sum+PayOff_Butterfly(S(n),K);
end

prix=exp(-r*T)*sum/Nmc;
end

% la condition finale %

function [f] = PayOff_Butterfly(S,K)
f = max(S-K,0)+max(S-3*K,0)-2*max(S-2*K,0);
end
