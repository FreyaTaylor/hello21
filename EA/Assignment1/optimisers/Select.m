%按照轮盘算法进行选择，n为选择数量
function selectPop=Select(pop,fitness,number_offspring)
sumF = sum(fitness(:));%轮盘算法准备 计算总体适应度之和
accF = cumsum(fitness/sumF);%轮盘算法准备 计算修正后（除以sumF）的累加fitness
%轮盘算法
for i = 1:number_offspring
    select = find(accF>rand);%得到大于rand的所有数
    if isempty(select)%若为空，则重新选择
        continue
    end
    %select(1)
    selectPop(i,:) = pop(select(1),:); %取第一个数  
end
end
