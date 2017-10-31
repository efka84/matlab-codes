
%% description
% routine to determine the pulse width. First it loads the files
% calls for Time2EnergyStreaking.m then passes the energy Vs counts to
% peakfit.m which determines the peak-width (FWHM). After that the returned
% fitparmeters are sorted and the average is saved in a text file.
% 2017 FK Hamburg

%% 
clear all; clc
%close all
tic
P = [];
load('CH2');
CH2 =CH2+12;
[tof, steps] = size(CH2);

time = 1:267;
s = steps;
CH2 =CH2(time,:);
%time = 7:size(CH2,1);   %time vector need for Time2EnergyStreaking.m

% myformat = '%3.4f \t %3.4f\n';
% fileName = 'un-streaked-CH2.txt';
peak1 =[];
peak2 =[];
%%%%%%%%%%%%%%%%%%%%%  For Loop  %%%%%%%%%%%%%%%%%%%%
for k = 1:s
         D = CH2(:,k);
         %t = t+0.6;
         values = D;
%call function with variables
[delay,energie_interpol,Intensitaet,N_interpol,tp,vp]=Time2EnergyStreaking(values,time,1,50);
% put the above func into peakfit         
[Fit,GOF,baselin,coeff,res,xi,yi]=peakfit([energie_interpol',N_interpol'],17,4,2,1,0,3,[14.5 1 16.5 1],0,0,0);
P =[P;Fit];
if Fit(1,1) == 1
     peak1 = [peak1; k Fit(1,2)];
else
    peak2 = [peak2; k Fit(1,2)];
end
if Fit(2,1) ==2
    peak2 = [peak2; k Fit(2,2)];
else
    peak1 = [peak1; k Fit(2,2)];
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End of Loop %%%%%%%%%%%%%%%%%%%%%
x1 =peak1(:,1);y1=peak1(:,2);
x2 =peak2(:,1);y2=peak2(:,2);



% calc average of fwhm of peaks

% P
% half = length(P(:,1))/2; % for average of peak fwhm
%  % sort peaks by their position and NOT by their nr. col2 is peakposition
% P = sortrows(P,2);
% fileID = fopen(fileName,'W');
% fprintf(fileID,'%6s %12s\r\n','% av1','av2');%header
% fprintf(fileID,myformat,mean(P(1:half,4)),mean(P(half+1:end,4)));
% fclose(fileID);
% P
% %copyfile *.txt ..\..
% %           -------------------------------------------
% %           plot tof and energy
% %           ------------------------------------------
%   figure(4);  
%   subplot(2,1,1)
%   plot(energie_interpol,N_interpol)
%   %title(datFile)
%   xlabel('energy (eV)')
%   ylabel(' arb units')
%   legend('interpolated')
%   grid on
%   
%   subplot(2,1,2) 
%   plot(time,values)
%    xlabel('time (ns)')
%   ylabel(' arb units')
%   grid

% save('workspace')
toc
