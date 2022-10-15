% symbol error rate for QPSK(4-QAM) modulation

N = 2*10^5; % number of symbols
esn0dB = (0:20); % multiple Eb/N0 values
decision = zeros(1,N);

bits = (2*(rand(1,N)>0.5)-1) + 1i*(2*(rand(1,N)>0.5)-1); %
bits_normalized = (1/sqrt(2))*bits; % normalization of energy to 1
noise = 1/sqrt(2)*(randn(1,N) + 1i*randn(1,N)); % white guassian noise, 0dB variance

for n = 1:length(esn0dB)
    transmitted = bits_normalized + 10^(-esn0dB(n)/20)*noise; % additive white gaussian noise

    % demodulation
    y_re = real(transmitted); % real
    y_im = imag(transmitted); % imaginary
    decision((y_re < 0 & y_im < 0)) = -1 + -1*1i;
    decision((y_re >= 0 & y_im > 0)) = 1 + 1*1i;
    decision((y_re < 0 & y_im >= 0)) = -1 + 1*1i;
    decision((y_re >= 0 & y_im < 0)) = 1 - 1*1i;
    %dynamic allocation of arrays
    practical_error(n) = size(find(bits- decision),2); % couting the number of errors
end

practical = practical_error/N;
theoretical = erfc(sqrt(1/2*(10.^(esn0dB/10)))) - (1/4)*(erfc(sqrt(1/2*(10.^(esn0dB/10))))).^2;
close all

%plots
figure

semilogy(esn0dB,theoretical,'b.-');
hold on
semilogy(esn0dB,practical,'mx-');

axis([0 12 10^-5 1])
grid on
legend('theory-QPSK', 'simulation-QPSK');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol error probability curve for QPSK(4-QAM)')