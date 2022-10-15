
function modSym = my_modulator(TxBits,mod_type)


if mod_type == 'BPSK'
   
    constellation = exp(1i*2*pi.*TxBits/2);
    constellation = constellation';
    
elseif mod_type == '4QAM'
    range = [1+1i*1 -1+1i*1 1-1i*1 -1-1i*1]/sqrt(2);
    constellation = range(TxBits+1);
elseif mod_type == 'SQAM'
    range = [1+1i*1 1+1i*3 3+1i*1 3+1i*3 -1+1i*1 -1+1i*3 -3+1i*1 -3+1i*3 1-1i*1 1-1i*3 3-1i*1 3-1i*3 -1-1i*1 -1-1i*3 -3-1i*1 -3-1i*3]/sqrt(4);
    constellation = range(TxBits(:)+1);
end
modSym = constellation;   

end