function de_interleaved = my_deinterleaver(d_il_bits)
    
    l = length(d_il_bits);
    k=l/4;
    TxArray2 = zeros(4,k);
    de_interleaved = zeros(1,l);
    for x=1:l
        if x<=k
            TxArray2(1,x)=d_il_bits(x);
        elseif x>k && x<=2*k
            TxArray2(2,x-k)=d_il_bits(x);
        elseif x>2*k && x<=3*k
            TxArray2(3,x-2*k)=d_il_bits(x);
        else
            TxArray2(4,x-3*k)=d_il_bits(x);
        end

        
    end
    for y=1:k
        de_interleaved((4*(y-1)+1))=TxArray2(1,y) ;
        de_interleaved((4*(y-1)+2))=TxArray2(2,y)  ;
        de_interleaved((4*(y-1)+3))= TxArray2(3,y);
        de_interleaved((4*(y-1)+4))=TxArray2(4,y) ;
    end
end
