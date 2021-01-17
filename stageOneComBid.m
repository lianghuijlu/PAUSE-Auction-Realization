function stageOneComBid()
% %STAGEONECOMBID Summary of this function goes here
% %   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;
% end

% clear 
% 
% load('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/allBids','bid')

% ALLBID = bid;
% I = 4;
% currentValue = 0;
% j = 1;
% APPCOMBIDLOG(1).value = 0;


global ALLBID APPCOMBIDLOG ITEMNUM
APPCOMBIDLOG(1).value = 0;
I = ITEMNUM;
currentValue = 0;
j = 1;
k = 0;
m = 1;
allItem = [1:I];
% mentionedItem = [];

for i = 1:I
    while(ALLBID(j).stage == 1)
        if ALLBID(j).item == i
            if m == 1
               k = k+1; 
            end
            if ALLBID(j).value >= currentValue
                currentValue = ALLBID(j).value;
                APPCOMBIDLOG(1).("block"+k) = ALLBID(j);
            end
%             mentionedItem = [mentionedItem i];
        m = m + 1;
        end       
        j = j+1;
    end
    m = 1;
    j = 1;
    APPCOMBIDLOG(1).value = APPCOMBIDLOG(1).value + currentValue;
    currentValue = 0;
end
    
% if (numel(fieldnames(APPCOMBIDLOG))-1) ~= ITEMNUM
%     mentionedItem = unique(mentionedItem);
%     suppItem = setxor(mentionedItem,allItem);
%     for m = 1:numel(suppItem)
%         APPCOMBIDLOG(1).("block"+suppItem(m))=[];
%     end       
% end

end

% save('/Users/hui/OneDrive/1.MyProject/MyWork4/myPAUSE/Variables/oneStageComBid','APPCOMBIDLOG')

