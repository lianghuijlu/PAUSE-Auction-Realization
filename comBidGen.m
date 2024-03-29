function [comBidBack] = comBidGen(initialBlockBid, epsilon)
% %COMBIDGEN Summary of this function goes here
% %   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;
% end

% clear
% load('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/allBids','bid')
% ALLBID = bid;
% load('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/oneStageComBid','APPCOMBIDLOG')

global ALLBID APPCOMBIDLOG ITEMNUM 

% itemNum = 4;
% initialBlockBid = ALLBID(8);
itemNum = ITEMNUM;
e = epsilon;
blockBid = initialBlockBid;
comBid.("block"+1) = blockBid;
currentComBidValue = 0;
preComBidValue = 0;
j = 2;
ex_i = 0;
ex_k = 0;
comBidBackTemp = [];
APPlineNum = length(APPCOMBIDLOG);
nonEmptyNum = ~cellfun(@isempty,struct2cell(APPCOMBIDLOG));

for i = 1:APPlineNum
    lengthCurrentLine = sum(nonEmptyNum(:,:,i)) - 1;
    for k = 1:lengthCurrentLine
        if i ~= ex_i && k ~= ex_k
            if sum(ismember(blockBid.item,APPCOMBIDLOG(i).("block"+k).item)) == 0
                comBid.("block"+j) = APPCOMBIDLOG(i).("block"+k);
                blockBid.item = [blockBid.item APPCOMBIDLOG(i).("block"+k).item];
                comBid.value = currentComBidValue + APPCOMBIDLOG(i).("block"+k).value;
                currentComBidValue = comBid.value;
                j = j + 1;
                if length(blockBid.item) == itemNum
                    if comBid.value > preComBidValue
                        comBidBackTemp = comBid;
                        preComBidValue = currentComBidValue;
                        currentComBidValue = 0;
                        blockBid = initialBlockBid;
                        j = 2;
                    end
                    ex_i = i;
                    ex_k = k;
                    i = 1;
                    k = 1;
                end
            end
 
        end
        
    end
end

if  isempty(comBidBackTemp)
    comBidBack = [];

elseif (APPCOMBIDLOG(i).value - comBidBackTemp.value) < initialBlockBid.value
    
    comBidBackTemp.("block"+1).value = APPCOMBIDLOG(i).value - comBidBackTemp.value + e;
    comBidBackTemp.value = APPCOMBIDLOG(i).value + e;
    APPCOMBIDLOG(i+1).value = comBidBackTemp.value;
    for k = 1:(numel(fieldnames(comBid))-1)
        APPCOMBIDLOG(i+1).("block"+k) = comBidBackTemp.("block"+k);
    end
    i = i+1;
    comBidBack = comBidBackTemp;
else
    comBidBack = [];
end




end

