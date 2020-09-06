clear 
clc
global P

ncomp = 2; 
x(1) = 0.5; % benzeno
x(2) = 0.5; % tolueno

P = 1*760; % mmHg
p = Antoine.data;
disp(p)

bnz = p.bnz;
tol = p.tol;

T0 = 90; 
options = optimset('Display','iter');
TB = fzero(@BOLT,T0, options,x,bnz,tol);

y_bnz = @(T) bnz.Psat(T)/P*x(1);
y_tol = @(T) tol.Psat(T)/P*x(2);

disp(y_bnz(TB))
disp(y_tol(TB))

T = 70:110;

figure(1)
plot(T,y_bnz(T)+y_tol(T),'k-.','LineWidth',2);
hold on
plot(T,y_bnz(T),'r-','LineWidth',2);
plot(T,y_tol(T),'b--','LineWidth',2);
plot(TB,y_bnz(TB),'sr','MarkerSize',15);
plot(TB,y_tol(TB),'sb','MarkerSize',15);
plot(TB,1,'sk','MarkerSize',15);
ylim([0 1.2])
xlabel('T (C)')
ylabel('Fracao molar no vapor')
title('Benzeno e Tolueno fracoes molares no vapor')
legend('y_{bnz}+y_{tol}','y_{bnz}','y_{tol}','Location','NE')
hold off





function res = BOLT(T,x,bnz,tol)
    global P 
    res = P - bnz.Psat(T)*x(1) - tol.Psat(T)*x(2);
end