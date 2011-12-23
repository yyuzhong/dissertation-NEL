function [output,delta_dB]=AddNoise(input,BBN,snr)
%
%%% This function takes an input signal
% and adds  noise at specified SNR.
% [LTASS = Long Term Average Speech Spectrum]
%
%  function [output,delta_dB]=AddNoise(input,snr)
% input - This is is the original signal
% snr -  Required SNR
%
% output - The input signal with white noise added
% delta_dB - The level difference in dB (positive = higher output)
%
% Ex: [output,delta_dB]=AddNoise(input,-2)
% adds noise to the input. This noise is added to the wavform
% at a SNR of -2 dB.
%
% Programmed by Jon Boley on 12/22/11
% (based on SNR_ASA_Compute by Jayaganesh Swaminathan)

if (snr<Inf)
    dB_before=20*log10(sqrt(mean(input.^2))/(20e-6));
    
    % compute the RMS of the original signal
    rms_signal=sqrt(mean(input.^2));
    
    % scale the noise based on SNR
    rms_scale=10^(snr/20);
    rms_noise=sqrt(mean(BBN.^2));
    BBN=((1/rms_scale).*rms_signal.*BBN./rms_noise).';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    output=input+BBN(1:length(input)).';
    delta_dB = 20*log10(sqrt(mean(output.^2))/(20e-6))-dB_before;
else
    output=input;
    delta_dB=0;
end

