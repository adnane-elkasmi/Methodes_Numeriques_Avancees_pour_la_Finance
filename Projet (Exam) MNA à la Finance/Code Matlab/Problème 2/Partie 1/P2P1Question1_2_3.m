
volatilite_fixe()

function [] = volatilite_fixe()

% Définition des constantes et vecteurs %

L=30;
T=0.5;
Ns=99;
Nt=99;
ds=L/Ns;

for j=1:(Ns+1)
    for k=1:(Nt+1)   
    St(j)=(L/Ns)*(j-1);
    t(k)=(T/Nt)*(k-1);
    V(k,j)=Prix_Call_St_fixe_t_fixe(t(k),St(j));
    end
end




% Question 1

figure;
hold on;
plot(St,V(Nt+1,:));
plot(St,V(1,:));
legend('V(t=T,S)','V(t=0,S)');
title('Prix de l option t=T et t=0 par MC pour N_{mc}=10000')

% Question 2

fprintf("V(t=T/3,S0=6)=%f",V(floor(T/(3*ds))+1,floor(6/(ds))+1));

% Question 3

figure;
mesh(St,t,V)
xlabel('Prix de l actif S_t')
ylabel('temps t')
zlabel('Prix de l option V')
title('Surface du prix de loption par MC pour N_{mc}=10000')

end

function [prix] = Prix_Call_St_fixe_t_fixe(t,St)

% Définition des constantes et vecteurs %

K=10;
T=0.5;
r=0.4;
sigma=0.5;
Nmc=10000;

for n=1:Nmc
    ST(n)=St*exp((r-(sigma^2)/2)*(T-t)+sigma*sqrt(T-t)*randn);
    gain(n)=Pay_off_Asset(ST(n),K);
end

prix=exp(-r*(T-t))*mean(gain);

end

function [f] = Pay_off_Asset(S,K)

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
end

end
