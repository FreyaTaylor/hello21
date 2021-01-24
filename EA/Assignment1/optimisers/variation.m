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