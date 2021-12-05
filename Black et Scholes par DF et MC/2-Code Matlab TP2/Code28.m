
S0=10;

fprintf("La variance de fonction Pay-Off actualisé pour S0=10 est: %f\n",Variance(S0));


function [V_estime1] = Variance(S0)

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
    esperance=esperance+Phi(K,r,T,sigma,S0,g);
    esperance_carre=esperance_carre+Phi(K,r,T,sigma,S0,g)^2;
end

V_estime1=(esperance_carre/Nmc)-(esperance/Nmc)^2;

end

function [f] = Phi(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*g)-K,0);

end