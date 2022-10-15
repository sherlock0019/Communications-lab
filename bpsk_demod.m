function decision = bpsk_demod(bits)
    decision((bits < 0)) = -1 ;
    decision((bits >= 0)) = 1 ;
end