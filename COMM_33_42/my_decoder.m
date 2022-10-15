
function decoder = my_decoder(bits,r,symbols)
    decoder = zeros(symbols,1);
    j = 0;
    for i=1:r:length(bits)-r+1
        j = j + 1;
        bit = bits(i:i-1+r);
        decoder(j) = mode(bit);
    end
end