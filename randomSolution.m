function [randomValue] = randomSolution()
%RANDOMSOLUTION Summary of this function goes here
%   Detailed explanation goes here

global ALLBID ITEMNUM N

% ITEMNUM = 4;
% N = 4;
bid = ALLBID;
SelNum = length(find(cell2mat({bid.stage}) <= N-1));
Bid = bid(1:SelNum);
itemSel = [];
itemSelTemp = [];
selIndex = [];
selIndexTemp = [];
value = [];
valueTemp = [];



while(length(itemSel) ~= ITEMNUM)
    selIndexTemp = unidrnd(SelNum);
    itemSelTemp = Bid(selIndexTemp).item;
    if sum(ismember(itemSel,itemSelTemp)) == 0
        itemSel = [itemSel itemSelTemp];
        selIndex = [selIndex selIndexTemp];
    end
end

for i = 1:length(selIndex)
    valueTemp = Bid(selIndex(1,i)).value;
    value = [value valueTemp];
end

randomValue = sum(value);

% disp(['Selected bid number is:',mat2str(selIndex)])
% disp(['Selected items are:',mat2str(itemSel)])
% disp(['Total value is:', mat2str(sum(value))])

end

