% 得到十进制，并在要求范围之内
% 因为没有计算0~10究竟需要多少位二进制合适，所以参照该算法中变成二进制的操作，直接除10^5
function pop=toDecimal(binpop,GeneLength)
pop = zeros(1,size(binpop,2));
for i=1:size(binpop,2)
    solution=binpop{1,i};
    for k=1:size(solution,2)/GeneLength
        onenumber=solution([(k-1)*GeneLength+1,k*GeneLength]);
        pop(i,k)=bin2dec(onenumber);
    end
    

end

end