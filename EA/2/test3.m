clc;clear;close all;
% 20209.21
% 第三版，完成以下任务：
% 1 画图(ok)
% 为什么迭代最后，适应度集中在一起，但是，总是和最佳值有差
% 变异率加大，迭代次数加大，会好一点
    



%参数
%命名规范：实词首字母大写
GeneLength=20;%基因长度
PopSize=50;%种群大小
VariationRate=0.01;%变异率
numStart=0;%基因表现型是数，数区间的左端点
numEnd=10;%数区间的右端点
EliteRate=0.2;%精英率，级下一代中父代精英所占的比例
SelectRate=0.4;%选择率，父代成为父母的概率
Iteration=1000;%迭代次数
displayStep=10;%每迭代几次，打印结果

pop=InitPop(PopSize,numStart,numEnd);%初始化

x=linspace(0,10,1000);%画曲线
y=x/10+sin(x);
plot(x,y);
hold on%
for i=1:size(pop,2)%画点
    plot(pop(i),pop(i)/10+sin(pop(i)),'ro');%红色O
end
hold off%hold on
title('初始种群');

%开始迭代
for i=1:1
    if mod(i,displayStep)==0
        [num,index]=max(fitness);%
        disp(['Iteration：',num2str(i)]);%打印
        disp(['最大x：' num2str(pop(index))]);
        disp(['最大y：' num2str(num-1)]);
    end
    fitness=Fitness(pop);%计算适应度
         
    parentsPop=Select(pop,fitness,SelectRate,2*(PopSize-round(EliteRate*PopSize)));%交叉遗传后代选好父母
    binKidsPop=Crossover(parentsPop,numStart,GeneLength,EliteRate,PopSize);%交叉遗传，得到下一代
    
    eliteParent=Select(pop,fitness,SelectRate,round(EliteRate*PopSize));%选择精英父母
    binElitePop=toBinary(eliteParent,numStart,GeneLength);
    
    
    Nbinpop=[binKidsPop,binElitePop]; %列拼接(;是行拼接)%拼接得到下一代
    varied=variation(Nbinpop,VariationRate,GeneLength);%在二进制的状态下变异
    Npop=toDecimal(varied);%处理为十进制
    pop=Npop;
end


figure
x=linspace(0,10,1000);%画曲线
y=x/10+sin(x);
plot(x,y);
hold on%
for i=1:size(pop,2)%画点
    plot(pop(i),pop(i)/10+sin(pop(i)),'ro');
end
hold off%hold on
title('终止种群');



% 得到十进制，并在要求范围之内
% 因为没有计算0~10究竟需要多少位二进制合适，所以参照该算法中变成二进制的操作，直接除10^5
function pop=toDecimal(binpop)
pop = zeros(1,size(binpop,2));
for i=1:size(binpop,2)
    pop(i)=bin2dec(binpop(1,i))/(10^5);
    
end
end







%Variation
function binpop=variation(binpop,VariationRate,GeneLength)
for i=1:size(binpop,2)
    if rand<VariationRate
        temp = binpop{i};
        Vindex = floor(rand*GeneLength);
        if Vindex==0%matlab数组是从1开始的，若索引为0会出错，故此处将0修改为1
            Vindex=1;
        end

        temp = [temp(1:Vindex-1) num2str(~temp(Vindex)) temp(Vindex+1:end)];
        binpop{i}=temp;
    end
end

end


%交叉遗传
function kidsPop=Crossover(parentsPop,numStart,GeneLength,EliteRate,PopSize)
binaryPop=toBinary(parentsPop,numStart,GeneLength);
k=1;
for i =1:2:2*(PopSize-round(EliteRate*PopSize))
    father = binaryPop{1,i};
    mother = binaryPop{1,i+1};
    crossIndex=floor(rand*GeneLength);
    if crossIndex==0
        crossIndex=1;
    end
    
    father(1,crossIndex:end) = mother(1,crossIndex:end);
    kidsPop{k} = father;
    k=k+1;
end
end


%toBinary
function binaryPop=toBinary(pop,numStart,GeneLength)
pop=round((pop-numStart)*10^5);
for i=1:size(pop,2)%列
    for j=1:size(pop,1)%行，只有一行
        binaryPop{j,i}=dec2bin(pop(j,i));%binaryPop是cell数组，类似于广义表，下标用{}
        lengthpop=length(binaryPop{j,i});%补0
        for s=1:GeneLength-lengthpop
            binaryPop{j,i}=['0' binaryPop{j,i}];
        end
    end
end
a=size(binaryPop)
class(binaryPop)
binaryPop{1}
b=size(pop)
end


%按照轮盘算法进行选择，n为选择数量
function selectPop=Select(pop,fitness,SelectRate,n)
sumF = sum(fitness(:));%轮盘算法准备 计算总体适应度之和
accF = cumsum(fitness/sumF);%轮盘算法准备 计算修正后（除以sumF）的累加fitness
%轮盘算法
for i = 1:n
    select = find(accF>rand);%得到大于rand的所有数
    if isempty(select)%若为空，则重新选择
        continue
    end
    selectPop(:,i) = pop(:,select(1)); %取第一个数  
end
end


%计算适应度
%适应度出现负值应该调整(通过+常量)
function fitness=Fitness(pop)
PopSize = size(pop,2);
fitness=zeros(1,PopSize);
for i=1:PopSize
    x=pop(:,i);%所有行，第i列
    fitness(:,i)=x/10+sin(x)+1;
    
end
end



% 随机产生初始种群
function pop=InitPop(PopSize,numStart,numEnd)
pop=zeros(1,PopSize); 
for i=1:PopSize
    pop(:,i)=numStart+rand*(numEnd-numStart);
end
end




















