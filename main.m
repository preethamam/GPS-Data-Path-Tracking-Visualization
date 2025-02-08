%//%************************************************************************%
%//%*                 GPS Path tracking and visualization                  *%
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
apiKey = 'some_long_string';            % Google Maps API key
garminGPSfile = 'ZZZ_GPSoutput_1.txt';  % Header: % Latitude, Longitude, Latitude Velocity, Longitude Velocity, MPH, KMPH, Unix timestamps,
vectorNavGPSfile = '04-29-2014-VectorNavGPS.txt';  % Header: % Latitude, Longitude, ?
plotpath = 'assets/path_plot.png';                 % Simple path plot file path
speedplotpath = 'assets/path_speed_plot.png';      % Simple path + speed plot file path
pathtype = 'continuous';                % How to join GPS latitude and longitude data [discrete | continuous]
linespecifiers = 1;                     % Turn on/off speed markers

%% load route data
% Load VectorNav data
vectorNavData = load(vectorNavGPSfile);
vectorNavData = [vectorNavData(:,2), vectorNavData(:,1)];

% Load Garmin data
garminGPSData = load(garminGPSfile);
garminGPSlatlong = [garminGPSData(:,2), garminGPSData(:,1)];

%% Plot paths and speeds
% Simple roadmap and path tracks
[totalDistKiloMetersVectorNav, totalDistMilesVectorNav] = plotRoadmap(vectorNavData, apiKey, plotpath);

% Path with speeds
[totalDistKiloMetersGarmin, totalDistMilesGarmin] = plotRoadmapSpeed(garminGPSData, garminGPSlatlong, ...
                                                            apiKey, pathtype, linespecifiers, speedplotpath);

%% End Commands
clcwaitbarz = findall(0,'type','figure','tag','TMWWaitbar');
delete(clcwaitbarz);
Runtime = toc;


