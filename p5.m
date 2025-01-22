minDelays = zeros(1, 10);
maxDelays = zeros(1, 10);

% loop over files and calculate delays for each load
for i = 1:10
    % load sent and received data
    sentFile = sprintf('sent%d.tr', i);
    rcvdFile = sprintf('rcvd%d.tr', i);
    
    % read sent and received data
    sentData = readtable(sentFile, 'Delimiter', ' ', 'ReadVariableNames', false, 'FileType', 'text');
    rcvdData = readtable(rcvdFile, 'Delimiter', ' ', 'ReadVariableNames', false, 'FileType', 'text');
    
    % extract the packet numbers and times
    sentPackets = sentData.Var1;
    sentTimes = sentData.Var2;
    rcvdPackets = rcvdData.Var1;
    rcvdTimes = rcvdData.Var2;
    
    % match packets by number and calculate e2e delays
    [dnc, idxSent, idxRcvd] = intersect(sentPackets, rcvdPackets);
    e2eDelays = rcvdTimes(idxRcvd) - sentTimes(idxSent);

    % calculate max n min delays for the current load
    minDelays(i) = min(e2eDelays);
    maxDelays(i) = max(e2eDelays);
end

% plot both graphs
figure;
plot(1:10, minDelays, '-o', 'LineWidth', 2, 'DisplayName', 'Min Delay');
hold on;
plot(1:10, maxDelays, '-o', 'LineWidth', 2, 'DisplayName', 'Max Delay');
xlabel('Network Load');
ylabel('End to End Delay (s)');
title('Min and Max End to End Delay vs Network Load');
legend('show');
grid on;
ylim([0 10*10^-4])