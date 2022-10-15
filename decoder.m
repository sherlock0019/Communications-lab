function b = decoder(symbols,r,N)
    map = reshape (symbols,r,N);
    b = (sum(map)>1);
end