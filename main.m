N = 10^5; %no of bits
r = 4; %no of repititions
mode = 1; %mode for deciding modulation scheme
bits = randsrc(1,N)>0; %bits in binary
esn0dB = (0:12); % multiple Es/N0 values

%predefining the vectors
decision = zeros(1,r*N);
symbol_practical_error = zeros(1,length(esn0dB));
bit_practical_error = zeros(1,length(esn0dB));

%modulation
if mode == 1 %BPSK modulation scheme
    
    for i = 2:r
        %source encoding
        bits_encoded = encoder(bits,i);
        symbols = bpsk_mod(bits_encoded);
        noise = 1/sqrt(2)*(randn(1,i*N) + 1i*randn(1,i*N));% gaussian noise

        for n = 1:length(esn0dB)
            transmitted = symbols + 10^(-esn0dB(n)/20)*noise; % additive white gaussian noise

            % demodulation
            decision = bpsk_demod(transmitted);
            %bits conversion from demodulated symbols
            bits_out = (1+decision)/2;

            %decoding the bits recieved
            decoded_bits = decoder(bits_out,i,N);
            %dynamic allocation of arrays
            %symbol_practical_error(n) = size(find(symbols- decision),2);
            bit_practical_error(i,n) = size(find(bits - decoded_bits),2);
        end
    end
    
    %symbol_error_rate = symbol_practical_error/N;
    theoretical_symbol = qfunc(sqrt((10.^(esn0dB/10))));
    theoretical_bit = theoretical_symbol;
    bit_error_rate = bit_practical_error/N;
    close all
    
    semilogy(esn0dB,theoretical_bit,'b.-');
    hold on
    semilogy(esn0dB,bit_error_rate,'gx-');
    
    axis([0 7 10^-5 1])
    grid on
end