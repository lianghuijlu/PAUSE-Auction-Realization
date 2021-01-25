%{
Different epsilon comparsion
Author: Hui Liang
Date: 25 Jan, 2021

%}
%%
clc
clear

LOOPNUM = 2;

itemNumBegin = 4;
itemNumEnd = 5;
itemRange = [itemNumBegin:itemNumEnd];
% epsilonBegin = 5;
% epsilonEnd = 21;
% epsilonRange = [epsilonBegin:5:epsilonEnd];
% epsilonRange = [1 epsilonRange];
epsilonRange = [1,5,15,25];



for LOOP = 1:LOOPNUM
    
    for itemOrder = 1:length(itemRange)
        
        % Parameter Setting
        global ITEMNUM N
        ITEMNUM = itemRange(itemOrder);
        N = 4; % Bidder Number
        I = ITEMNUM; % Item Number
        ItemsPre = [];
        i = 1;
        j = 1;
        t = 2;
        %         e = 1;
        unavilableComBidScale = 2;
        bidSubmitLog = [];
        
        
        % Varible Setting
        global ALLBID APPCOMBIDLOG
        ALLBID = struct;
        APPCOMBIDLOG = struct;
        APPCOMBIDLOGTemp = struct;
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
        
        
        % disp("ALLBID has done!")
        stageOneComBid()
        APPCOMBIDLOGTemp = APPCOMBIDLOG;
        
        % disp("stageOne has done!")
        
        %% PAUSE Auction
        for epsilonOrder = 1:length(epsilonRange)
            e = epsilonRange(epsilonOrder);
            while (1)
                if (ALLBID(j).stage == t)
                    %         fprintf('j = %d.\n',j)
                    currentBlockBid = ALLBID(j);
                    comBid = comBidGen(currentBlockBid,e);
                    %         fprintf('This is agent %d, stage %d composit bid based on bid %d.\n',...
                    %             ALLBID(j).agent, ALLBID(j).stage, j)
                    if isempty(comBid)
                        %             fprintf('The unsubmit bid is bid %d.\n',j)
                        ifContinous(2) = j;
                        if ifContinous(2)-ifContinous(1) == 1
                            unavailableComBidCounter = unavailableComBidCounter + 1;
                            ifContinous(2) = 0;
                            %                 fprintf('The unavailable composite bid number is %d.\n', unavailableComBidCounter)
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
            
            disp('PAUSE has done!')
            PAUSERecord(itemOrder,LOOP,epsilonOrder) = APPCOMBIDLOG(length(APPCOMBIDLOG)).value;
            APPCOMBIDLOG = APPCOMBIDLOGTemp;
            j = 1;
            t = 2;
        end
    
    centralValue = centralSolution();
    centralRecord(LOOP,itemOrder) = centralValue;
    disp('Central has done!')
    end
    %     randomValue = randomSolution();
    %     randomRecord(LOOP,itemOrder) = randomValue;
    %     disp('Random has done!')
    
    
    fprintf('LOOP NUM is %d.\n',LOOP)
end
%%


%% Figure 1: Bidder submit bids.
% APPlineNum = length(APPCOMBIDLOG);
% nonEmptyNum = ~cellfun(@isempty,struct2cell(APPCOMBIDLOG));
% for i = 1:length(APPCOMBIDLOG)
%     lengthCurrentLine = sum(nonEmptyNum(:,:,i)) - 1;
%     for k = 1:lengthCurrentLine
%         bidSubmitLog(i,APPCOMBIDLOG(i).("block"+k).agent) = ...
%             APPCOMBIDLOG(i).("block"+k).value;
%     end
% end
% 
% figure('Name','Bids of each bidder')
% roundIndex = (1:APPlineNum);
% for i = 1:N
%     %     plot(roundIndex,bidSubmitLog(:,i),'LineWidth',1)
%     stairs(roundIndex,bidSubmitLog(:,i),'LineWidth',1.5)
%     hold on
% end
% set(gca,'FontName','times new Roman');
% legend('Agent 1','Agent 2','Agent 3','Agent 4')
% xlim([1,APPlineNum])
% xlabel('Round number','FontName','Times New Roman','FontSize',11)
% ylabel('Bid value','FontName','Times New Roman','FontSize',11)

%% Figure 2: Methods comparsion
% PAUSEMean = mean(PAUSERecord,1);
% centralMean = mean(centralRecord,1);
% randomMean = mean(randomRecord,1);
% figure('Name','Social welfare comparsion')
% plot(itemRange,PAUSEMean,'LineWidth',1.5)
% hold on
% plot(itemRange,centralMean,'LineWidth',1.5)
% hold on
% plot(itemRange,randomMean,'LineWidth',1.5)
% hold on
% grid on
% legend('PAUSE','Central','Random')
% set(gca,'FontName','times new Roman');
% xlabel('Items','FontName','Times New Roman','FontSize',11)
% ylabel('Social welfare','FontName','Times New Roman','FontSize',11)

%% Figure 3: Different epsilon
centralMean = mean(centralRecord,1);
epsilonMean = mean(PAUSERecord,2);

for i = 1:length(epsilonRange)
    epsilonDisp(i,:) = epsilonMean(:,:,i)';    
end

figure('Name','Different Epsilon comparsion')
for i = 1:length(epsilonRange)
    plot(itemRange,epsilonDisp(i,:),'LineWidth',1.5)
    hold on
end
plot(itemRange,centralMean,'LineWidth',1.5)
hold on

grid on
legend('Epsilon=1','Epsilon=5','Epsilon=15','Epsilon=25','Central')
set(gca,'FontName','times new Roman');
xlabel('Items','FontName','Times New Roman','FontSize',11)
ylabel('Social welfare','FontName','Times New Roman','FontSize',11)



    