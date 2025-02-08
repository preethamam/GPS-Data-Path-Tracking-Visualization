function [totalDist_KiloMeters, totalDist_Miles] = plotRoadmap(latlong, apiKey, plotpath)

    % PLOTROADMAP Plots a roadmap using latitude and longitude data.
    %
    %   [totalDist_KiloMeters, totalDist_Miles] = PLOTROADMAP(latlong, apiKey, plotpath)
    %   plots a roadmap based on the provided latitude and longitude data.
    %
    %   INPUT:
    %       latlong - A matrix containing latitude and longitude data.
    %       apiKey - A string containing the API key for accessing map services.
    %       plotpath - A boolean indicating whether to plot the path on the map.
    %
    %   OUTPUT:
    %       totalDist_KiloMeters - The total distance of the plotted path in kilometers.
    %       totalDist_Miles - The total distance of the plotted path in miles.
    %
    %   Example:
    %       latlong = [34.0522, -118.2437; 36.1699, -115.1398];
    %       apiKey = 'your_api_key_here';
    %       plotpath = Plot save path;
    %       [totalDist_KiloMeters, totalDist_Miles] = plotRoadmap(latlong, apiKey, plotpath);
    %
    %   This function uses the provided latitude and longitude data to plot a roadmap
    %   and calculates the total distance of the path in both kilometers and miles.

    % plot route data using Google map
    % Please note that Google Maps API Key is mandatory!
    figure;
    hold on
    p1 = plot(latlong(:, 1), latlong(:, 2),  'r--', 'LineWidth', 2);
    plot_google_map('maptype', 'roadmap', 'APIKey', apiKey);
    
    starting = line(latlong(1, 1), latlong(1, 2), 'Marker', 'o', ...
    'Color', 'g', 'MarkerFaceColor', 'g', 'MarkerSize', 10);    
    
    ending = line(latlong(end, 1), latlong(end, 2), 'Marker', 's', ...
    'Color', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);

    legend([p1 starting ending],'VectorNav', 'Start', 'End')
    
    xlim([min(latlong(:,2)), max(latlong(:,2))]);
    axis equal off
    axis off
    hold off

    % Export figure
    exportgraphics(gcf, plotpath)
    
    %% GPS data track-length    
    latlong = fliplr(latlong);
    
    % Find the distance of the experiment. Compute distances (in degrees) 
    % between consecutive lat/long pairs.
    d_deg = distance(latlong(1:end-1,1), latlong(1:end-1,2), ...
                     latlong(2:end,1),   latlong(2:end,2));

    % Convert distances from degrees to kilometers.
    vehiDistArray = distdim(d_deg, 'deg', 'kilometers');
    
    totalDist_KiloMeters = sum(vehiDistArray);      % In kilometers
    totalDist_Miles = totalDist_KiloMeters / 1.6;   % Convert to miles
end