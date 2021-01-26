function [winBid] = centralCost()
%CENTRALSOLUTION Summary of this function goes here
%   Detailed explanation goes here


global ALLBID ITEMNUM

% ITEMNUM = 4;
% N = 4;

bid = ALLBID;
constraintMat = [];
SelNum = length(find(cell2mat({bid.stage})<=ITEMNUM-1));
constraintMat = zeros(SelNum,ITEMNUM);
Bid = bid(1:SelNum);
Value = cell2mat({Bid.value});
maxNumforEachItem = ones(1,ITEMNUM);
lowerBound = zeros(1,SelNum);
upperBound = ones(1,SelNum);
intcon = [1:SelNum];

for i = 1:SelNum
    for j = 1:length(Bid(i).item)
        constraintMat(i,Bid(i).item(1,j)) = 1;
    end
end

constraintMat = constraintMat';

f = -Value;
A = constraintMat;
b = maxNumforEachItem;
lb = lowerBound;
ub = upperBound;
[x, fval] = intlinprog(f,intcon,A,b,[],[],lb,ub);

centralValue = -fval;
find(x ~= 0)
winBid = find(x==1);
% disp(['Winner bids are:',mat2str(winBid)])
% disp(['Total value is:',mat2str(-fval)])



end

