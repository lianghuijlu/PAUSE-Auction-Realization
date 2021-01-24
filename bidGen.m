function [bid] = bidGen(agentNum,itemNum)
% All items are bid at stage one Version.
% Date: 24 Jan. 2021



% clear
% 
% agentNum = 4; % Bidder Number
% itemNum = 4; % Item Number
% % ItemsPre = [];
% % i = 1;

N = agentNum;
I = itemNum;
ItemsPre = [];
i = 1;
stageOneItemNum = 0;


for StageIndex = 1:I
    SelectNum = StageIndex;
    for AgentIndex = 1:N
        AllCombiNum = nchoosek(I,SelectNum);
        SelectTimes = unidrnd(AllCombiNum);
        for Times = 1:SelectTimes
            Items = randperm(I,SelectNum);
            if ~ismember(sum(Items),ItemsPre)
                Value = randi([5*StageIndex*(StageIndex-1),5*StageIndex*StageIndex],1);
                bid(i).agent = AgentIndex;
                bid(i).stage = StageIndex;
                bid(i).value = Value;
                bid(i).item = Items;
                ItemsPre = [ItemsPre,sum(Items)];
                i = i+1;
            end
        end
        ItemsPre = [];
    end
    if StageIndex == 1
       stageOneItems = cell2mat({bid.item});
       stageOneItemNum = numel(unique(stageOneItems));
        while (stageOneItemNum ~= I)
            for AgentIndex = 1:N
                AllCombiNum = nchoosek(I,SelectNum);
                SelectTimes = unidrnd(AllCombiNum);
                for Times = 1:SelectTimes
                    Items = randperm(I,SelectNum);
                    if ~ismember(sum(Items),ItemsPre)
                        Value = randi([5*StageIndex*(StageIndex-1),5*StageIndex*StageIndex],1);
                        bid(i).agent = AgentIndex;
                        bid(i).stage = StageIndex;
                        bid(i).value = Value;
                        bid(i).item = Items;
                        ItemsPre = [ItemsPre,sum(Items)];
                        i = i+1;
                    end
                end
                ItemsPre = [];
            end
            stageOneItems = cell2mat({bid.item});
            stageOneItemNum = numel(unique(stageOneItems));
        end
    end
end
end

% save('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/allBids','bid')

