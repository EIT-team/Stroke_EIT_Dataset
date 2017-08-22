
load ('P1_MF1-BV.mat'); % load BV, keep_idx, PhaseAngle, ExpSetup, prt_full
amplitudes = ExpSetup.Amp;
load ('System_gain.mat', 'gain')% load correction gain

% selecting non-injecting channels, converting to mV, computing Real compnent,normalizing for I, correcting for biosemi gain
for frame=1: size(BV{1},2); % for each frame (2-3)
    Real= NaN(size(keep_idx,2),size(BV,2));
    for frq= 1:size(BV,2); % for each frequency (17)
        Real(:,frq)= (BV{frq}(keep_idx,frame)./1000).*cos(PhaseAngle{frq}(keep_idx,frame));
        Real(:,frq)= Real(:,frq)/amplitudes(frq)*max(amplitudes);
        Real(:,frq)= Real(:,frq)*gain(frq);
    end
    
    R{frame}= Real;
    % plotting frame
    figure;
    plot(abs(Real'));
    title(['Frame No. ', num2str(frame)])
end 

% After choosing preferred frame by eye 
Chosen_frame= 2;
Real= R{Chosen_frame};

% cleaning
load('10H_real.mat', 'Ave') % loading a reference signal, an averaged data frame of 10 healthy subjects
Cleaned_real= Real;
prt= prt_full(keep_idx, :);
data_counter= 0; % removed data points counter
DP_removed= []; % removed data

for frq= 1: size(Real,2) % for each frequency (17)
    for comb= 1: size(Real)
        if (abs(Real(comb, frq)) > (abs(Ave(comb, frq)) + 20)) % cleaning criteria 
            Cleaned_real(comb, frq)= NaN;
            data_counter= data_counter+1; 
            DP_removed(data_counter, 1:3)= prt(comb,1:3);
            DP_removed(data_counter, 4)= frq;
        end
    end
end

save('P8Ar1.mat', 'Real', 'Cleaned_real', 'DP_removed');