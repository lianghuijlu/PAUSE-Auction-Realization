%{
This is the main function.
Author: Hui Liang
Date: 15 Jan, 2021
%}

clear

% Parameter Setting
global ITEMNUM
ITEMNUM = 4;
N = 4; % Bidder Number
I = ITEMNUM; % Item Number
ItemsPre = [];
i = 1;
e = 1;

% Varible Setting
global ALLBID APPCOMBIDLOG 
ALLBID = struct;
APPCOMBIDLOG = struct;

ALLBID = bidGen(N,I);
bidNum = length(ALLBID);
disp("ALLBID has done!")
stageOneComBid(I)
disp("stageOne has done!")

for t = 2:I
    for j = 1:bidNum
        while(ALLBID(j).stage == t)
            currentBlockBid = ALLBID(j);
            comBid = comBidGen(currentBlockBid);
            j = j+1;
            if (APPCOMBIDLOG.value(i) - comBid.value) < ALLBID(j).value
               comBid.value = APPCOMBIDLOG.value(i) + e;
               APPCOMBIDLOG.("block"+1) = ALLBID(j).value + e;
               APPCOMBIDLOG(i+1) = comBid;
               i = i+1;
            end   
        end
        j = j+1;
    end
end
    