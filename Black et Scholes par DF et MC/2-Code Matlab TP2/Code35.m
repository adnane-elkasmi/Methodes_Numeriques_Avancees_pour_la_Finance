Nmc=10000;

graphe_V_estime2(Nmc)

function [] = graphe_V_estime2(Nmc)

K=10;

for j=1:500
    S0(j)=0.4*(j-1);
    prix_graphe(j)=V_estime2(S0(j),Nmc);
end

figure;
hold;
plot(S0,prix_graphe)
plot(S0,max(S0-K,0))
xlabel('Prix S_0')
ylabel('V_{estime2}(S_0,0)')
title('Graphe du deuxieme estimateur de l option N_{mc}=10000')

end


function [prix] = V_estime2(S0,Nmc)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
esperance=0;

for n=1:Nmc
    g=randn;
    esperance=esperance+((Phi(K,r,T,sigma,S0,g)+Phi_Sym(K,r,T,sigma,S0,g))/2);
end

prix=esperance/Nmc;

end


function [f] = Phi(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*g)-K,0);

end

function [f] = Phi_Sym(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T-sigma*sqrt(T)*g)-K,0);

end