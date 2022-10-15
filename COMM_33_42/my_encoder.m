function rep = my_encoder(bits,r)
    rep = [];
    new = zeros(r,1);
    for i=1:length(bits)
        % Selects the Bit
        bit = bits(i);
        % Repeats the bits
        for j=1:r
            new(j) = bit;
        end
        % Adds the bits
        rep = [rep new'];
    end
    rep = rep';
end
    