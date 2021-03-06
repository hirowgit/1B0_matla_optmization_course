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
% # @File    : A2_Object_Move_Normal.m

%%  Main program
% clear all
clc

Nd=10;
vehi=[0,1,1,-1,-1,0;2,1,-1,-1,1,2]; % vehi originally in 
% "Robot Modeling" by Kazuyuki Kobayashi (ISBN 978-4-274-20431-9) https://www.ohmsha.co.jp/book/9784274204319/
contr=[-0.15,0.15,0.7,0.7,-0.7,-0.7,-0.15,-0.15,0.15,0.15;1,1,1,-1,-1,1,1,-1,-1,1];

gAng=@(x1,y1,x2,y2) atan2(y2-y1,x2-x1)-pi/2;
gAng=@(x1,y1,x2,y2) atan2(y2-y1,x2-x1);
RotM=@(theta) [cos(theta),-sin(theta);sin(theta),cos(theta)];

% Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);

xS=100; yS=100;
yPos=repmat(yS,[1,Nd]);
xPos=(1:Nd)+xS;
sTraj=[xPos' yPos'];

figure(1); clf

plot(sTraj(:,1),sTraj(:,2),'.-','lineWidth',2,'MarkerSize',20);
grid on;

figure(2); clf;

plot(contr(1,:),contr(2,:),'.-','lineWidth',2,'MarkerSize',20);
axis equal;

figure(3); clf;
for k=1:Nd-1
    x1=sTraj(k,1); y1=sTraj(k,2);
    x2=sTraj(k+1,1); y2=sTraj(k+1,2);
    Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);
    plot(Pcontr(1,:),Pcontr(2,:),'.-','lineWidth',2,'MarkerSize',20),hold on;
    
%     set(gca,'xlim',[100 110],'ylim',[100 110]);
%     set(gca,'xlim',[min(sTraj(:,1)) max(sTraj(:,1))],'ylim',[min(sTraj(:,2)) max(sTraj(:,2))+10]);
    set(gca,'xlim',[min(sTraj(:,1)) max(sTraj(:,1))]);
    plot(sTraj(:,1),sTraj(:,2),'.-','lineWidth',2,'MarkerSize',20);
    plot([x1,x2],[y1,y2],'k.-','lineWidth',2,'MarkerSize',20);
    axis equal; 
    pause(0.2);
    drawnow;
    hold off
end

Nd=10*4;
tAng=0:((2*pi)./Nd):2*pi;

Radi=20;
sTraj=[Radi.*cos(tAng)' Radi.*sin(tAng)'];

figure(31);clf;
plot(sTraj);
figure(4); clf;

for k=1:Nd-1
    x1=sTraj(k,1); y1=sTraj(k,2);
    x2=sTraj(k+1,1); y2=sTraj(k+1,2);
    Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);
    plot(Pcontr(1,:),Pcontr(2,:),'.-','lineWidth',2,'MarkerSize',20),hold on;
    
%     set(gca,'xlim',[100 110],'ylim',[100 110]);
    set(gca,'xlim',[min(sTraj(:,1)) max(sTraj(:,1))],'ylim',[min(sTraj(:,2)) max(sTraj(:,2))]);
%     set(gca,'xlim',[min(sTraj(:,1)) max(sTraj(:,1))]);
    plot(sTraj(:,1),sTraj(:,2),'.-','lineWidth',2,'MarkerSize',20);
    plot([x1,x2],[y1,y2],'k.-','lineWidth',2,'MarkerSize',20);
    axis equal; 
    pause(0.2);
    drawnow;
    hold off
end
