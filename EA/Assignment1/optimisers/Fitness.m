%计算适应度
%适应度出现负值应该调整(通过+常量)
function fitness=Fitness(pop,funcName,numStart,numEnd)

PopSize = size(pop,1);

fitness=zeros(1,PopSize);
for i=1:PopSize
    x=pop(i,:);%所有行，第i列

    [a,b]=find(x>numEnd);
    x(a,b)=numEnd;
    [c,d]=find(x<numStart);
    x(c,d)=numStart;
    
    pop(i,:)=x;
    

    
    
    %[y] = sphere(x)
    eval(['y = ',funcName,'(x);']);
    fitness(:,i)=-y;
    %fitness(:,i) = objective(x) 
end

end
