%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2021 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE. */
%% Specifications and requirements
% # @Time    : 2021-1-16 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B0_matla_optmization_course
% # @IDE     : MATLAB R2018a
% # @File    : A2_Object_Move_Plus.m

%%  Main program
% clear all
clc

contr=[-0.15,0.15,0.7,0.7,-0.7,-0.7,-0.15,-0.15,0.15,0.15;1,1,1,-1,-1,1,1,-1,-1,1];
gAng=@(x1,y1,x2,y2) atan2(y2-y1,x2-x1);
RotM=@(theta) [cos(theta),-sin(theta);sin(theta),cos(theta)];

% Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);


Ndstep=10;
Nd=7;
Radi=2*4*Ndstep/(2*pi);
Radi=4*Radi;

prange=pi/2;

dAng=prange*(Ndstep./(2*pi*Radi*(prange./(2*pi))));  
% \delta \theta=R_p \cdot \frac{N_d}{2\pi r \frac{R_p}{2\pi}}\\ R_p=prange, \\ N_d=Ndstep
tAng=0:(dAng):prange;
tAng=fliplr(tAng);

sTraj=[(Radi.*cos(tAng))' (Radi.*sin(tAng))'];  
sTraj_full=sTraj;

xS=0; yS=Radi;
yPos=repmat(yS,[1,(Nd+1)]);
xPos=-(0:Ndstep:(Nd+1)*Ndstep)+xS;
sTraj=[xPos(2:Nd+1)' yPos(2:Nd+1)'];
sTraj_full=[flipud(sTraj); sTraj_full];

xS=Radi; yS=0;
xPos=repmat(xS,[1,(Nd+1)]);
yPos=-(0:Ndstep:(Nd+1)*Ndstep)+yS;
sTraj=[xPos(2:Nd+1)' yPos(2:Nd+1)'];
sTraj_full=[sTraj_full; sTraj];


figure(1); clf

plot(sTraj_full(:,1),sTraj_full(:,2),'.-','lineWidth',2,'MarkerSize',20);
axis equal;
grid on;
title('Trajectory');
xlabel('x'); ylabel('y');

figure(31);clf;
plot(sTraj_full,'.-');
grid on;
title('Temporal sequence of x and y coordinates to reconstract the trajectory');
xlabel('x'); ylabel('y');

figure(4); clf;

marginR=[-20 20];
for k=1:size(sTraj_full,1)-1
    x1=sTraj_full(k,1); y1=sTraj_full(k,2);
    x2=sTraj_full(k+1,1); y2=sTraj_full(k+1,2);
    Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);
    plot(Pcontr(1,:),Pcontr(2,:),'.-','lineWidth',2,'MarkerSize',20),hold on;
    
    set(gca,'xlim',[min(sTraj_full(:,1)) max(sTraj_full(:,1))]+marginR,'ylim',[min(sTraj_full(:,2)) max(sTraj_full(:,2))]+marginR);
    plot(sTraj_full(:,1),sTraj_full(:,2),'.-','lineWidth',2,'MarkerSize',20);
    plot([x1,x2],[y1,y2],'k.-','lineWidth',2,'MarkerSize',20);
    axis equal; grid on; xlabel('x'); ylabel('y');
    title('Object movement in the trajectory');
    pause(0.2);
    drawnow;
    hold off
end
