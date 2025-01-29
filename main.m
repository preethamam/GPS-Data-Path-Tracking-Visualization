%//%************************************************************************%
%//%*                  Annotation Image Quality Checker                    *%
%//%*                                                                      *%
%//%*             Author(s): Dr. Preetham Manjunatha                       *%
%//%*             Github link: https://github.com/preethamam               *%
%//%*             Submission Date: --/--/----                              *%
%//%************************************************************************%
%//%*             Viterbi School of Engineering,                           *%
%//%*             Sonny Astani Dept. of Civil Engineering,                 *%
%//%*             University of Southern california,                       *%
%//%*             Los Angeles, California.                                 *%
%//%************************************************************************%


%% Start Commands
clc; close all; clear;
clcwaitbarz = findall(0,'type','figure','tag','TMWWaitbar'); 
delete(clcwaitbarz);
tic;

%% input 
apiKey = 'some_long_string'; % Google Maps API key

%% load route data
% load NatickToBOS
clc  ; clear; close all
Data001 = load ('04-29-2014-VectorNavGPS.txt');
Data001 = [ Data001(:,2), Data001(:,1) ];

Data002 = load ('04-29-2014-Garmin.txt');
Data002 = [ Data002(:,2), Data002(:,1) ];


%% plot route data
% Google map
% Please note that Google Maps API Key is mandatory!
hold on
    p1 = plot(Data001(:, 1), Data001(:, 2),  'r--', 'LineWidth', 2);
    f1 = plot_google_map('maptype', 'roadmap', 'APIKey', apiKey);
    
    starting1 = line(Data001(1, 1), Data001(1, 2), 'Marker', 'o', ...
    'Color', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);

    p2 = plot(Data002(:, 1), Data002(:, 2),  'g-.', 'LineWidth', 2);
    f2 = plot_google_map('maptype', 'roadmap', 'APIKey', apiKey);
    
    starting2 = line(Data002(1, 1), Data002(1, 2), 'Marker', 's', ...
    'Color', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
    
 
    legend([p1 p2 starting1 starting2],'VectorNav', 'Garmin', 'Start', 'End')

    xlim([min(Data001(:,2)), max(Data001(:,2))]);
    axis equal on
    axis off
hold off
exportgraphics(gcf, 'assets/path_plot.png')

%% GPS data track-length    
Data001 = fliplr(Data001);

% Find the distance of the experiment
parfor i = 1:length(Data001)-1
    vehiDistArray(i,1) = distdim(distance(Data001(i,1), Data001(i,2), ...
                                   Data001(i+1,1), Data001(i+1,2)),...
                                   'deg','kilometers');
end

totalDist_KiloMeters = sum(vehiDistArray);      % In kilometers
totalDist_Miles = totalDist_KiloMeters / 1.6;   % Convert to miles

%% End Commands
clcwaitbarz = findall(0,'type','figure','tag','TMWWaitbar');
delete(clcwaitbarz);
Runtime = toc;


