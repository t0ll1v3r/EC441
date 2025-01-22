% Program plots the percentage of packet loss versus the network load.

packetLossPercentages = zeros(1, 10);

% loop over files and calculate packet loss for each load
for i = 1:10
    % load sent and received data
    sentFile = sprintf('sent%d.tr', i);
    rcvdFile = sprintf('rcvd%d.tr', i);
    
    % read data
    sentData = readtable(sentFile, 'Delimiter', ' ', 'ReadVariableNames', false, 'FileType', 'text');
    rcvdData = readtable(rcvdFile, 'Delimiter', ' ', 'ReadVariableNames', false, 'FileType', 'text');
    
    % get packet numbers from the first column
    sentPackets = sentData.Var1;
    rcvdPackets = rcvdData.Var1;
    
    % total packets sent
    totalSent = length(sentPackets);
    
    % total packets received
    totalRcvd = length(rcvdPackets);
    
    % calculate packet loss as percent
    packetLossPercentages(i) = (totalSent - totalRcvd) / totalSent * 100;
end

loadValues = 1:10;

% plot
figure;
plot(loadValues, packetLossPercentages, '-o', 'LineWidth', 2);
xlabel('Network Load');
ylabel('Packet Loss (%)');
title('Packet Loss vs Network Load');
grid on;
