%{
This is the main function.
Author: Hui Liang
Date: 15 Jan, 2021
%}
clc
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
stageOneComBid()
disp("stageOne has done!")

for t = 2:I-1
    for j = 1:bidNum
        while(ALLBID(j).stage == t)
            currentBlockBid = ALLBID(j);
            comBid = comBidGen(currentBlockBid);
            fprintf('This is agent %d, stage %d composit bid based on bid %d.\n',...
                ALLBID(j).agent, ALLBID(j).stage, j)
            if ~isempty(comBid)
                if (APPCOMBIDLOG(i).value - comBid.value) < ALLBID(j).value
                    comBid.("block"+1).value = APPCOMBIDLOG(i).value - comBid.value + e;
                    comBid.value = APPCOMBIDLOG(i).value + e;
                    APPCOMBIDLOG(i+1).value = comBid.value;
                    for k = 1:(numel(fieldnames(comBid))-1)
                        APPCOMBIDLOG(i+1).("block"+k) = comBid.("block"+k);
                    end
                    i = i+1;
                end
            end
            j = j+1;
        end
        j = j+1;
    end
end

disp("PAUSE is finished!")
    