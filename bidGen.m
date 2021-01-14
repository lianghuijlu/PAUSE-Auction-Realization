% function [outputArg1,outputArg2] = bidGen(inputArg1,inputArg2)
% %BIDGEN Summary of this function goes here
% %   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;
% end


clear

N = 4; % Bidder Number
I = 4; % Item Number
ItemsPre = [];
i = 1;

for StageIndex = 1:I
    SelectNum = StageIndex;
    for AgentIndex = 1:N
        AllCombiNum = nchoosek(I,SelectNum);
        SelectTimes = unidrnd(AllCombiNum);
        for Times = 1:SelectTimes
            Items = randperm(I,SelectNum);
            if ~ismember(sum(Items),ItemsPre)
                Value = randi([5*(StageIndex-1),5*StageIndex],1);
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
end

save('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/allBids','bid')

