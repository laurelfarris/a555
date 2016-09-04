% ASTR 555 hw03
close all; clear all; clc;

c = 3e+8;
H = 67;
step = .1;
minimum = 0;
maximum = 200;
mu = 22.0; mg = 22.2; mr = 22.2; mi = 21.3; mz = 20.5;

%--------Redshift--------%
fid = fopen('z.txt','r');
Z = fscanf(fid,'%f');
fclose(fid);

%----------Flux---------%
fid = fopen('absMag_g.txt','r'); % open file
FG = fscanf(fid,'%f');           % read file
fclose(fid);                     % close file
GD = []; GZ = [];
GD = [GD; (10.^((mg-FG-5)/5))/(10^6)]; % 
GZ = [GZ; H*(10.^((mg-FG-5)/5))/c];

fid = fopen('absMag_i.txt','r');
FI = fscanf(fid,'%f');
fclose(fid);
ID = []; IZ = [];
ID = [ID; (10.^((mi-FI-5)/5))/(10^6)];
IZ = [IZ; H*(10.^((mi-FI-5)/5))/c];

fid = fopen('absMag_r.txt','r');
FR = fscanf(fid,'%f');
fclose(fid);
RD = []; RZ = [];
RD = [RD; (10.^((mr-FR-5)/5))/(10^6)];
RZ = [RZ; H*(10.^((mr-FR-5)/5))/c];

fid = fopen('absMag_u.txt','r');
FU = fscanf(fid,'%f');
fclose(fid);
UD = []; UZ = [];
UD = [UD; (10.^((mu-FU-5)/5))/(10^6)];
UZ = [UZ; H*(10.^((mu-FU-5)/5))/c];

fid = fopen('absMag_z.txt','r');
FZ = fscanf(fid,'%f');
fclose(fid);
ZD = []; ZZ = [];
ZD = [ZD;(10.^((mz-FZ-5)/5))/(10^6)];
ZZ = [ZZ; H*(10.^((mz-FZ-5)/5))/c];

%-----------Plot color vs. magnitude-----------%

% plot((FR-FI),FR,'.', 'MarkerSize', 1  );
% title('R-I Color Index vs. Magnitude');
% xlabel('R-I');
% ylabel('R');


%------Print Raw Luminosity Function-----------%
binranges=[];
for i = minimum:step:maximum    % From min to max magnitude...
    binranges = [binranges; i]; % create step-sized bins
end
bincounts = histc(FG./(GD.^3),binranges); % distribute FG values into bins
%bincounts = histc(GD,binranges);
plot(binranges,bincounts)
hold on;

binranges=[];
for i = minimum:step:maximum
    binranges = [binranges; i];
end
bincounts = histc(FI./(ID.^3),binranges);
%bincounts = histc(ID, binranges);
plot(binranges,bincounts,'r')
hold on;

binranges=[];
for i = minimum:step:maximum
    binranges = [binranges; i];
end
bincounts = histc(FR./(RD.^3),binranges);
%bincounts = histc(RD,binranges);
plot(binranges,bincounts,'g')
hold on;

binranges=[];
for i = minimum:step:maximum
    binranges = [binranges; i];
end
bincounts = histc(FU./(UD.^3),binranges);
%bincounts = histc(UD,binranges);
plot(binranges,bincounts,'c')
hold on;

binranges=[];
for i = minimum:step:maximum
    binranges = [binranges; i];
end
bincounts = histc(FZ./(ZD.^3),binranges);
%bincounts = histc(ZD,binranges);
plot(binranges,bincounts,'k')
hold on;

legend('G','I','R','U','Z')

%axis([-500 20000 0 325]);
title('Raw Luminosity Function')
xlabel('Absolute Magnitude');
ylabel('Volume (Mpc^3)');




