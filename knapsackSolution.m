%{
function [knapsackValue] = knapsackSolution(inputArg1,inputArg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end
%}

%%

global ALLBID ITEMNUM

bid = ALLBID;
constraintMat = [];
SelNum = length(find(cell2mat({bid.stage})<=ITEMNUM-1));
constraintMat = zeros(SelNum,ITEMNUM);
Bid = bid(1:SelNum);
Value = cell2mat({Bid.value})';
maxNumforEachItem = ones(1,ITEMNUM)';
%%

for i = 1:SelNum
    for j = 1:length(Bid(i).item)
        constraintMat(i,Bid(i).item(1,j)) = 1;
    end
end

constraintMat = constraintMat';
%%
option.N          = 10000;
option.rho        = 5*10e-3;
option.alpha      = 0.7;
option.d          = 10;
option.T_max      = 1000;

p = Value;
W = constraintMat;
c = Value;

out               = ce_knapsack(p , W , c , option);

disp(sprintf('\n S_CE = %8.2f, S_opt = %8.2f' , out.S_opt , S_opt))
%%