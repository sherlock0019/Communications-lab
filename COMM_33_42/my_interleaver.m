function interleaved_bits = my_interleaver(tr_bits)
    
    l = length(tr_bits);
    k=round(l/4);
    tr_Array1 = zeros(k,4);
    interleaved_bits = zeros(1,l);
    for i=1:k
        tr_Array1(i,1) = tr_bits((4*(i-1)+1));
        tr_Array1(i,2) = tr_bits((4*(i-1)+2));
        tr_Array1(i,3) = tr_bits((4*(i-1)+3));
        tr_Array1(i,4) = tr_bits((4*(i-1)+4));
    end
    for y=1:l
        if y<=k
            interleaved_bits(y)=tr_Array1(y,1);
        elseif y>k && y<=2*k
          
          
            interleaved_bits(y)=tr_Array1((y-k),2);
        elseif y>2*k && y<=3*k
            interleaved_bits(y)=tr_Array1((y-2*k),3);
        else
            
            
            interleaved_bits(y)=tr_Array1((y-3*k),4);
        end

        
    end
end
