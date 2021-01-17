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
unavailableComBidNum = 0;

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
            unavailableComBidNum = unavailableComBidNum + 1;
            fprintf('The unsubmit bid is bid %d.\n',j)
            fprintf('The unavailable composite bid number is %d.\n', unavailableComBidNum)
            
            %                 else
            %                     if (APPCOMBIDLOG(i).value - comBid.value) < ALLBID(j).value
            %
            %                         comBid.("block"+1).value = APPCOMBIDLOG(i).value - comBid.value + e;
            %                         comBid.value = APPCOMBIDLOG(i).value + e;
            %                         APPCOMBIDLOG(i+1).value = comBid.value;
            %                         for k = 1:(numel(fieldnames(comBid))-1)
            %                             APPCOMBIDLOG(i+1).("block"+k) = comBid.("block"+k);
            %                         end
            %                         i = i+1;
            %                     else
            %                         unavailableComBidNum = unavailableComBidNum + 1;
            %                     end
        end
    end
    j = j+1;
    if j == bidNum + 1
        j = 1;
    end
    if unavailableComBidNum == stageBidderNum(1,t)
        t = t + 1;
        unavailableComBidNum = 0;
    end
    if t == I
        break;
    end
end
%     end

% end



disp("PAUSE is finished!")
    