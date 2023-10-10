%    calculating the transient response analysis of a linear control system
% Parameter values of model
L = 0.01 ; %inertance in units of cm H2O s2/L
C = 0.1 ; %compliance in units of L/cm H2O
R = 1 ; %resistance in units of cm H2O s/L
lambda = 1 ; %open-loop case
 
% set up transfer function
num = [1];
den = [L*C  R*C  lambda]; 
Hs = tf(num,den);
 
% generate time vector
t = [0:0.005:0.8];
 
% compute and plot impulse response
x = impulse(Hs,t);
plot(t,x);
disp(' Press <Enter> to continue >>');
pause;
 
% compute and plot step response
y = step(Hs,t);
stepinfo(Hs)
figure;
plot(t,y);
disp(' Press <Enter> to continue >>');
pause;
%pz map 
[z1,p1,k1]=tf2zp(num,den)
pzmap(Hs,'r')
 
 
% compute and plot response to arbitrary input, u (square wave)
[u,t]=gensig('square',0.5,5,0.005);
y=lsim(Hs,u,t);
figure;
plot(t,y)
 
%PID controller
Kp=25;
Ki=52;
Kd=1.7;
contr=tf([Kd Kp Ki],[1 0]);
sys_cl=feedback(contr*Hs,1);
t=0:0.01:2;
step(sys_cl,t)
stepinfo(sys_cl)
