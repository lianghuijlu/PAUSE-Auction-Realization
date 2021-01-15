%{
This is the main function.
Author: Hui Liang
Date: 15 Jan, 2021
%}

clear

% Parameter Setting
N = 4; % Bidder Number
I = 4; % Item Number
ItemsPre = [];
i = 1;


% Varible Setting
global ALLBID APPCOMBIDLOG
ALLBID = struct;
APPCOMBIDLOG = struct;

ALLBID = bidGen(N,I);
disp("ALLBID has done!")
stageOneComBid(I)
disp("stageOne has done!")