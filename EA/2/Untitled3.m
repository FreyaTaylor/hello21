clc;clear;close all;

    



%参数
%命名规范：实词首字母大写

GeneLength=30;%基因长度
PopSize=100;%种群大小
N_size=10;
nbe=300000;
Iteration=nbe/PopSize;%迭代次数
numStart=-1.28;%基因表现型是数，数区间的左端点
numEnd=1.28;%数区间的右端点
a=0.5;%交叉参数

VariationRate=0.01;%变异率
EliteRate=0.2;%精英率，级下一代中父代精英所占的比例
SelectRate=0.4;%选择率，父代成为父母的概率
displayStep=100




pop=InitPop(PopSize,GeneLength,numStart,numEnd);%初始化


%开始迭代
for i=1:Iteration
    


    fitness=Fitness(pop);%计算适应度
    if mod(i,displayStep)==0
        disp(['%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%',num2str(i)])
        disp(max(fitness));
    end
    
    KidsPop=Crossover(pop, fitness, PopSize,a);
    pop=Variation(KidsPop,VariationRate);



end












%Variation
function kidsPop=Variation(pop,VariationRate)

for i=1:size(pop,1)
    if rand<VariationRate
        for j=1:size(pop,2)
            pop(i,j)=pop(i,j)+normrnd(0,1,1);
        end
    end
end
kidsPop=pop;
end


%交叉遗传
function kidsPop=Crossover(pop, fitness, PopSize,a)
GeneLength=size(pop,2);
k=1;
kidsPop=zeros( PopSize,GeneLength);
while k<=PopSize
    father =Select(pop,fitness);
    mother =Select(pop,fitness);

    for j=1:size(father,2)
        kidsPop(k,j)  =a*father(j)+(1-a)*mother(j);
        kidsPop(k+1,j)=a*mother(j)+(1-a)*father(j);
        
    end

    k=k+2;
end

end




%按照轮盘算法进行选择一个Pop
function selectPop=Select(pop,fitness)
sumF = sum(fitness(:));%轮盘算法准备 计算总体适应度之和
accF = cumsum(fitness/sumF);%轮盘算法准备 计算修正后（除以sumF）的累加fitness
%轮盘算法
selectPop=[];
while size(selectPop,1)==0
    select = find(accF>rand);%得到大于rand的所有数
    if isempty(select)%若为空，则重新选择
        continue
    end
    selectPop = pop(select(1),:); %取第一个数  
end
end


%计算适应度
%适应度出现负值应该调整(通过+常量)
function fitness=Fitness(pop)
fitness=zeros(1,size(pop,1));
for i=1:size(pop,1)
    y=0;
    for j=1:size(pop,2) 
        x=pop(i,j);
        y=y+j*x^4;
    end
    y=y+rand;
    fitness(i)=1/y;%27.8435
end
end



% 随机产生初始种群
function pop=InitPop(PopSize,GeneLength,numStart,numEnd)
pop=zeros(1,PopSize); 
for i=1:PopSize
    for j=1:GeneLength
        pop(i,j)=numStart+rand*(numEnd-numStart);
    end
    
end
end




















