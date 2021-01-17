%{
This is the main function.
Author: Hui Liang
Date: 15 Jan, 2021

Moified: 17 Jan, 2021
Moified V2: 5:00pm, 17 Jan, 2021
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
unavilableComBidScale = 2;
bidSubmitLog = [];


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

while (1)
    if (ALLBID(j).stage == t)
        fprintf('j = %d.\n',j)
        currentBlockBid = ALLBID(j);
        comBid = comBidGen(currentBlockBid,e);
        fprintf('This is agent %d, stage %d composit bid based on bid %d.\n',...
            ALLBID(j).agent, ALLBID(j).stage, j)
        if isempty(comBid)
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
    if unavailableComBidCounter > unavilableComBidScale*stageBidderNum(1,t)
        t = t + 1;
        unavailableComBidCounter = 0;
    end
    if t == I
        break;
    end
end

disp("PAUSE is finished!")

% Bidder submit bids.
APPlineNum = length(APPCOMBIDLOG);
nonEmptyNum = ~cellfun(@isempty,struct2cell(APPCOMBIDLOG));
for i = 1:length(APPCOMBIDLOG)
    lengthCurrentLine = sum(nonEmptyNum(:,:,i)) - 1;
    for k = 1:lengthCurrentLine
        bidSubmitLog(i,APPCOMBIDLOG(i).("block"+k).agent) = ...
            APPCOMBIDLOG(i).("block"+k).value;
    end
end

figure('Name','Bids of each bidder')
roundIndex = (1:APPlineNum);
for i = 1:N
    plot(roundIndex,bidSubmitLog(:,i),'LineWidth',1)
    hold on
end
set(gca,'FontName','times new Roman');
legend('Agent 1','Agent 2','Agent 3','Agent 4')
xlabel('Round number','FontName','Times New Roman','FontSize',11)
ylabel('Bid value','FontName','Times New Roman','FontSize',11)





    