%% GCAMP Analysis Master Script
% Christian Cazares, Drew Schreiner, Christina Gremel
% University of California, San Diego
% 2/16/21
%% Loop through each Excel File in Selected Folder to extract raw behavioral events and fluorescent signals
% Saves each session as a .mat containing that data
% GCAMP_Save_Dir = 'G:\CIE DMS paper\71.5\edit\CIE';
GCAMP_Save_Dir = 'C:\Users\etbaltz\Downloads\RENAMED DATA';
extractData(GCAMP_Save_Dir)
%% Loops through each .mat GCAMP session and peforms peri-event GCaMP trace analysis
% Function:
        % extract_PeriEventAnalysis(base_time_start, base_time_end, time_end)
    % Parameters:
    %   base_time_start: time (in seconds) before onset of lever press for
    %       start of baseline window
    %   base_time_end: time (in seconds) before onset of lever press for
    %       end of baseline window
    %   time_end: time (in seconds) after onset of event for
    %       end of analys window
    
    base_time_start = -10; % old -15
    base_time_end = -5;   % old -2
    time_end = 2; %old 5
    extract_PeriEventAnalysis(base_time_start, base_time_end, time_end)
    
% 1. Extracts timestamps of each behavioral event (Onset, Offset, Head Entry, Reward)
    % Subfunction: 
            % extract_EventTimestamps(GCAMP)
        % Parameters:
            % GCAMP: Session including extract raw excel timestamps of
            % events and photometry signals
% 2. Baseline normalization of each session's peri-event GCAMP traces (Onset, Offset, Head Entry, Reward, Quantile, Interpolated)
    % Subfunction: 
            % baselineNormalized_PeriEventTraces(GCAMP)
        % Parameters:
            % GCAMP: Session including extract raw excel timestamps of
            % events and photometry signals
% 3. Performs Linear Mixed Effect Model (LME) Analysis on each session's peri-event GCAMP
%       traces (pre-Onset, post-Onset, post-Offset)

%% Plots example session peri-event GCAMP traces (onset, offset, first head entry after reward, duration)
plotExampleSession(GCAMP) %this is for a single session
%% Group GCAMP data
% [GroupedGCAMP_OFC] = groupGCAMPData();
[Grouped_GCAMP] = groupGCAMPData(); %asking for where the .mat files are; will stack the data
%can run the regression on this
% [GroupedGCAMP_PV] = groupGCAMPData();
%% Probability
base_time_start = -5; % old -15
base_time_end = -2;   % old -5
time_end = 5;
extract_PeriEventAnalysis_Probability(base_time_start, base_time_end, time_end)
% 

% 
[Grouped_GCAMP] = groupGCAMPData_Probability();
[Grouped_GCAMP] = groupGCAMPData_Stats_Probability(Grouped_GCAMP);
plotGroupedSessions_Probability(Grouped_GCAMP);
% plotExampleSession_Probability(GCAMP)
% 
%% Regression
[Model] = GCAMP_grand_regression_indivshuffles_r(Grouped_GCAMP);
save('Model','Model' , '-v7.3') %this version allows you to save very large files "v7.3"

% %% Decoder
% accuracy_testing_new
%% N-1
% If N-1 is Rewarded or not
Grouped_GCAMP = nBackReward(Grouped_GCAMP);

% What duration distribution quartile does N-1 belong to?
Grouped_GCAMP = nBackQuartile(Grouped_GCAMP);

%% Perform Statistical Comparisons in Grouped GCAMP data
%performs permutation tests against the mean of each- fail or met; will
%create variable for when p values are significant in the trace
[Grouped_GCAMP] = groupGCAMPData_Stats(Grouped_GCAMP);

%% Plots grouped session peri-event GCAMP traces (onset, offset, first head entry after reward, duration)
% Loops through each individual GCAMP session in folder and places
% peri-event data traces into a cohort-sized data structure
plotGroupedSessions(Grouped_GCAMP); %this is met vs fail
plotGroupedSessions_n1Reward(Grouped_GCAMP); %n vs n-1, n reward vs n-1 reward, etc, etc
plotGroupedSessions_n1Quartile(Grouped_GCAMP); %distribution of durations is the quartile here, takes into account individual performance

%% OFC-M2
% [GroupedGCAMP_Air] = groupGCAMPData();
% [GroupedGCAMP_CIE] = groupGCAMPData();
% GroupedGCAMP_Air = nBackReward(GroupedGCAMP_Air);
% GroupedGCAMP_CIE = nBackReward(GroupedGCAMP_CIE);
% 
% GroupedGCAMP_Air = nBackQuartile(GroupedGCAMP_Air);
% GroupedGCAMP_CIE = nBackQuartile(GroupedGCAMP_CIE);
% 
% [GroupedGCAMP_Air] = groupGCAMPData_Stats(GroupedGCAMP_Air);
% [GroupedGCAMP_CIE] = groupGCAMPData_Stats(GroupedGCAMP_CIE);
% 
% 
% [Air_Model] = GCAMP_grand_regression_indivshuffles_r(GroupedGCAMP_Air);
% save('Air_Model','Air_Model' , '-v7.3')
% 
% [CIE_Model] = GCAMP_grand_regression_indivshuffles_r(GroupedGCAMP_CIE);
% save('CIE_Model','CIE_Model' , '-v7.3')
% 
% plotGroupedSessions(GroupedGCAMP_Air);
% plotGroupedSessions(GroupedGCAMP_CIE);
% 
% plotGroupedSessions_n1Quartile(GroupedGCAMP_Air);
% plotGroupedSessions_n1Quartile(GroupedGCAMP_CIE);