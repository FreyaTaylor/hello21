%交叉遗传
function kidsPop=Crossover(parentsPop,numStart,numEnd,GeneLength,EliteRate,PopSize)

binaryPop=toBinary(parentsPop,numStart,numEnd,GeneLength);
size(binaryPop)
class(binaryPop)
k=1;

for i =1:2:2*(PopSize-round(EliteRate*PopSize))
    father = binaryPop{1,i};
    mother = binaryPop{1,i+1};
    crossIndex=floor(rand*GeneLength*size(parentsPop,2));
    if crossIndex==0
        crossIndex=1;
    end
    father
    size(father)
    mother
    size(mother)
    crossIndex
    
    father(1,crossIndex:end) = mother(1,crossIndex:end);
    kidsPop{k} = father;
    k=k+1;
end
end
