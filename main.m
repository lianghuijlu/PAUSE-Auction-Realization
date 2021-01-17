%{
This is the main function.
Author: Hui Liang
Date: 15 Jan, 2021

Moified: 17 Jan, 2021
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
j = 1;
t = 2;
e = 1;


% Varible Setting
global ALLBID APPCOMBIDLOG 
ALLBID = struct;
APPCOMBIDLOG = struct;

ALLBID = bidGen(N,I);
bidNum = length(ALLBID);
% Calculate the bidder number of each stage
stageBidderNum = [];
stageMat = cell2mat({ALLBID.stage});
for s = 1:I
    stageBidderNum = [stageBidderNum sum(stageMat(:)==s)];    
end
unavailableComBidCounter = 0;
ifContinous = zeros(1,2);

disp("ALLBID has done!")
stageOneComBid()
disp("stageOne has done!")

% for t = 2:I-1
    
%     for j = 1:bidNum
while (1)
    if (ALLBID(j).stage == t)
        fprintf('j = %d.\n',j)
        currentBlockBid = ALLBID(j);
        comBid = comBidGen(currentBlockBid,e);
        fprintf('This is agent %d, stage %d composit bid based on bid %d.\n',...
            ALLBID(j).agent, ALLBID(j).stage, j)
        if isempty(comBid)
%             unavailableComBidNum = unavailableComBidNum + 1;
            fprintf('The unsubmit bid is bid %d.\n',j)
            ifContinous(2) = j;
            if ifContinous(2)-ifContinous(1) == 1
                unavailableComBidCounter = unavailableComBidCounter + 1;
                ifContinous(2) = 0;
                fprintf('The unavailable composite bid number is %d.\n', unavailableComBidCounter)
            end
        end
        ifContinous(1) = ifContinous(2);
    end
    j = j+1;
    if j == bidNum + 1
        j = 1;
    end
    if unavailableComBidCounter > 2*stageBidderNum(1,t)
        t = t + 1;
        unavailableComBidCounter = 0;
    end
    if t == I
        break;
    end
end
%     end

% end



disp("PAUSE is finished!")
    