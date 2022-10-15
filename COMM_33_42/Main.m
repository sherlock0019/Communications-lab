
clc;
clear 
close all

%mod_type = input("The mode of modulation is : ", 's');

modtype = 'SQAM'
N = 10000; % number of bits
if modtype == 'BPSK'
    b=1;
elseif modtype == '4QAM'
    b=2;
elseif modtype == 'SQAM'
    b=4;
end


for r = 1:2:5  % r is number of repetetions 
 Tr_Bits = zeros(N,1);
    for n=1:N
        Tr_Bits(n) = randi([0,1]);
    end

    interleaved_bits = my_interleaver(Tr_Bits);
    repeated_bits = my_encoder(interleaved_bits,r);
    mod_bits = my_modulator(repeated_bits,modtype);
    len_mod = length(mod_bits);
    
    % Gaussian noise creation for the system
    noise=zeros(len_mod,1);
    
    snr = 0:1:20; 
    %snr=2
    lenghth_snrs = length(snr);
    
    
    error_estimate_1 = zeros(lenghth_snrs,1);
    bit_error = zeros(lenghth_snrs,1);
    for i = 1:lenghth_snrs 
        snr_now = snr(i);
    
        % Convertingthe db to decimal
        ebno=10^(snr_now/10);
    
        
        if modtype == 'BPSK'
            sigma=sqrt(1/(1*ebno)); % sigma is variance 
        elseif modtype == '4QAM'
            sigma=sqrt(1/(2*ebno)); 
        elseif modtype == 'SQAM'
            sigma=sqrt(1/(4*ebno)); 
        end
          
        
        noise = sigma*(randn(len_mod,1)+1i.*randn(len_mod,1));
    
        
        received_bits = mod_bits + noise';
    
       
       bits_d = my_demodulator(received_bits,len_mod,modtype);
    
       bits_dr = my_decoder(bits_d,r,N);
       bits_dril = my_deinterleaver(bits_dr);
       errors = (bits_dril' ~= Tr_Bits); %estimating error for each SNR value 
        
        
        error_estimate_1(i) = sum(errors)/len_mod;%summing BER for every symbol 
        bit_error(i) = error_estimate_1(i)/b;
    end   
    
    % Plotting the error obtained from demodulation and the theoretical
   % error 
  
    
    semilogy(snr,bit_error);
   
    hold on;
    grid on;

    
end

xlabel("SNR");
ylabel("Bit Error Rate");




