
S0=10;
Intervalle_de_confiance_2(S0)

function [] = Intervalle_de_confiance_2(S0)

% Définition des constantes %

Nmc=1000;
[prix,V_estime2] = Variance_2(S0);
a= prix-1.96*sqrt(V_estime2/Nmc);
b= prix+1.96*sqrt(V_estime2/Nmc);

% Afficher l(intervalle de confiance avec probabilité 95% %

fprintf("La variance à S0=10 est: %f\n",V_estime2);
fprintf("Intervalle de confiance pour Call à S0=10 est: [%f,%f]\n",a,b);
fprintf("Le prix de l option estimé pour Call à S0=10 est: %f dans [%f,%f]\n",prix,a,b);

end


function [prix,V_estime2] = Variance_2(S0)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nmc=1000;
esperance=0;
esperance_carre=0;

for n=1:Nmc
    g=randn;
    esperance=esperance+((Phi(K,r,T,sigma,S0,g)+Phi_Sym(K,r,T,sigma,S0,g))/2);
    esperance_carre=esperance_carre+((Phi(K,r,T,sigma,S0,g)+Phi_Sym(K,r,T,sigma,S0,g))/2)^2;
end

V_estime2=(esperance_carre/Nmc)-(esperance/Nmc)^2;
prix=esperance/Nmc;

end

function [f] = Phi(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*g)-K,0);

end

function [f] = Phi_Sym(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T-sigma*sqrt(T)*g)-K,0);

end