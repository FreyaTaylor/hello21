% bestx: the best solution found by your algorithm
% recordedAvgY: array of  average fitnesses of each generation
% recordedBestY: array of best fitnesses of each generation

% 'noisyQuartic'
% 'ackley'
% 'shekel'
% clc
% [bestx, recordedAvgY, recordedBestY]=EA1('noisyQuartic',30,-100,100,150000);
% function [bestx, recordedAvgY, recordedBestY]=EA1(funcName,n,lb,ub,nbEvaluation)

function [bestx, recordedAvgY, recordedBestY]=EA(funcName,n,lb,ub,nbEvaluation)
 disp('**********************************************')
disp(funcName);
warning on MATLAB:divideByZero
if nargin < 5
  error('input_example :  not enough input')
end

eval(sprintf('objective=@%s;',funcName)); % Do not delete this line
allBestY=-realmax;
recordedAvgY=[];
recordedBestY=[];

GeneLength=ceil(log2(ub-lb));%基因长度=8
PopSize=10;%种群大小
VariationRate=0.01;%变异率
numStart=lb;%基因表现型是数，数区间的左端点
numEnd=ub;%数区间的右端点
EliteRate=0.2;%精英率，级下一代中父代精英所占的比例
SelectRate=0.4;%选择率，父代成为父母的概率
Iteration=3;%迭代次数
%Iteration=nbEvaluation;
displayStep=1;%每迭代几次，打印结果



pop=InitPop(PopSize,numStart,numEnd,n);%初始化
for i=1:Iteration
    disp('***********************')
    disp(i)
    

    %会规范化上下界
    fitness=Fitness(pop,funcName,numStart,numEnd);%计算适应度
    
    %update
    AvgY=mean(fitness);
    [BestY,index]=max(fitness);
    allBestY;
    recordedAvgY=[recordedAvgY,AvgY];
    recordedBestY=[recordedBestY,BestY];
    if BestY>allBestY
        %disp('BestY>allBestY')
        allBestY=BestY;
        bestx=pop(index,:);
    end
    size(fitness);
    parentsPop=Select(pop,fitness,2*(PopSize-round(EliteRate*PopSize)));%交叉遗传后代选好父母


     binKidsPop=Crossover(parentsPop,numStart,numEnd,GeneLength,EliteRate,PopSize);%交叉遗传，得到下一代
     size(binKidsPop);
     eliteParent=Select(pop,fitness,round(EliteRate*PopSize));%选择精英父母
     binElitePop=toBinary(eliteParent,numStart,numEnd,GeneLength);
    size(binKidsPop);
    size(binElitePop);


     Nbinpop=[binKidsPop,binElitePop]; %列拼接(;是行拼接)%拼接得到下一代
     varied=variation(Nbinpop,VariationRate,GeneLength*n);%在二进制的状态下变异
    Npop=toDecimal(varied,GeneLength);%处理为十进制
    size(Npop);
    pop=Npop;
end



end























