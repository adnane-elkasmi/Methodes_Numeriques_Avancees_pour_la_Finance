Nmc=10000;

graphe_V_estime(Nmc)

function [] = graphe_V_estime(Nmc)

K=10;

for j=1:500
    S0(j)=0.4*(j-1);
    [prix_graphe1(j),prix_graphe2(j)]=V_estime(S0(j),Nmc);
end

figure;
hold;
plot(S0,prix_graphe1)
plot(S0,prix_graphe2)
plot(S0,max(S0-K,0))
xlabel('Prix S_0')
ylabel('V_{estime}(S_0,0)')
legend('V_{estime1}(S_0,0)','V_{estime2}(S_0,0)','Pay-Off');
title('Graphe des estimateurs 1 et 2 de l option N_{mc}=10000')

end


function [prix1,prix2] = V_estime(S0,Nmc)

% Définition des constantes %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
esperance1=0;
esperance2=0;

for n=1:Nmc
    g=randn;
    esperance1=esperance1+Phi(K,r,T,sigma,S0,g);
    esperance2=esperance2+((Phi(K,r,T,sigma,S0,g)+Phi_Sym(K,r,T,sigma,S0,g))/2);
end

prix1=esperance1/Nmc;
prix2=esperance2/Nmc;

end


function [f] = Phi(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T+sigma*sqrt(T)*g)-K,0);

end

function [f] = Phi_Sym(K,r,T,sigma,S0,g)

f=exp(-r*T)*max(S0*exp((r-(sigma^2)/2)*T-sigma*sqrt(T)*g)-K,0);

end