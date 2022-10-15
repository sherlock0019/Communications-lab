% symbol error rate for 16-QAM modulation

N = 2*10^5; % number of symbols
symbols = [-3 -1 1 3]; % 16-QAM parameters

esn0dB = (0:20); % multiple Es/N0 values
decision = zeros(1,N);

bits = randsrc(1,N,symbols) + 1i*randsrc(1,N,symbols);
bits_normalized = (1/sqrt(10))*bits; %normalization of energy to 1
noise = 1/sqrt(2)*(randn(1,N) + 1i*randn(1,N));


for n = 1:length(esn0dB)
    
    transmitted = bits_normalized + 10^(-esn0dB(n)/20)*noise; %additive white gaussian noise

    % demodulation
    y_re = real(transmitted); % real part
    y_im = imag(transmitted); % imaginary part

    decision_re(y_re< -2/sqrt(10))           = -3; %dynamic allocation of arrays
    decision_im((y_im< -2/sqrt(10)))           = -3; %dynamic allocation of arrays
    
    decision_re(y_re > 2/sqrt(10))           =  3; %dynamic allocation of arrays
    decision_im((y_im > 2/sqrt(10)))           =  3; %dynamic allocation of arrays
    
    decision_re(y_re>-2/sqrt(10) & y_re<=0)  = -1; %dynamic allocation of arrays
    decision_im((y_im>-2/sqrt(10) & y_im<=0))  = -1; %dynamic allocation of arrays
    
    decision_re(y_re>0 & y_re<=2/sqrt(10))   =  1; %dynamic allocation of arrays
    decision_im((y_im>0 & y_im<=2/sqrt(10)))   =  1; %dynamic allocation of arrays
    
    decision = decision_re + 1i*decision_im;
    
    %dynamic allocation of arrays
    practical_error(n) = size(find(bits- decision),2); % counting the number of errors
end

practical = practical_error/N;
theoretical = 3/2*erfc(sqrt(0.1*(10.^(esn0dB/10))));
close all

%plots
figure

semilogy(esn0dB,theoretical,'b.-','LineWidth',2);
hold on

semilogy(esn0dB,practical,'mx-','Linewidth',2);
axis([0 20 10^-5 1])
grid on

legend('theory', 'simulation');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol error probability curve for 16-QAM modulation') 