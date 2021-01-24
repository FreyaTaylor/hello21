
% 随机产生初始种群
function pop=InitPop(PopSize,numStart,numEnd,n)

pop=zeros(PopSize,n); 
for i=1:PopSize
    for j=1:n
        pop(i,j)=numStart+rand*(numEnd-numStart);
    end
end
end