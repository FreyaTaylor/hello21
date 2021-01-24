
%toBinary
function binaryPop=toBinary(pop,numStart,numEnd,GeneLength)
%pop=round((pop-numStart)*(numEnd-numStart));
pop=round((pop-numStart));

binaryPop=cell(1,size(pop,1));


for i=1:size(pop,1)%每一个solution
    for j=1:size(pop,2)%一个solution的每一维
        binaryPop1{i,j}=dec2bin(pop(i,j));%binaryPop是cell数组，类似于广义表，下标用{}
        lengthpop=length(binaryPop1{i,j});%补0
        if GeneLength>lengthpop
            
            for s=1:GeneLength-lengthpop
                %disp('&&&&&&&&&&&&&&&&&&&&')
                binaryPop1{i,j}=['0' binaryPop1{i,j}];
            end
        end
        binaryPop1{i,j};
    end
    
    
    bi=[];%把30维复合到一串二进制
    for k=1:size(pop,2)
        bi=[bi,binaryPop1{i,k}];
    end
    
    
    
    binaryPop{1,i}=bi;
    disp('&&&&&&&&&&&&&&&&&&&&'+i)
    size(bi)
    if size(bi,2)~=60
        for k=1:size(pop,2)
            binaryPop1{i,k}
        end
    end
        
   
    
end


end
