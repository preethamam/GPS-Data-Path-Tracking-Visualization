function [totalDistKiloMeters, totalDistMiles] = plotRoadmapSpeed(gpsdat, latlong, apiKey, ...
                                                    pathtype, linespecifiers, speedplotpath)

    % PLOTROADMAPSPEED Plots a roadmap with speed data.
    % 
    % [totalDistKiloMeters, totalDistMiles] = plotRoadmapSpeed(gpsdat, latlong, apiKey, pathtype, linespecifiers, speedplotpath)
    %
    % This function takes GPS data and plots a roadmap with speed information.
    %
    % Inputs:
    %   gpsdat - GPS data containing latitude, longitude, and speed information.
    %   latlong - Latitude and longitude data for the roadmap.
    %   apiKey - API key for accessing map services.
    %   pathtype - How to join GPS latitude and longitude data [discrete | continuous].
    %   linespecifiers - Line specifiers for customizing the plot appearance.
    %   speedplotpath - Path where the speed plot will be saved.
    %
    % Outputs:
    %   totalDistKiloMeters - Total distance covered in kilometers.
    %   totalDistMiles - Total distance covered in miles.

    % plot route data using Google map
    % Please note that Google Maps API Key is mandatory!    
    
    % Find the distance of the experiment. Compute distances (in degrees) 
    % between consecutive lat/long pairs.
    d_deg = distance(gpsdat(1:end-1,1), gpsdat(1:end-1,2), ...
                     gpsdat(2:end,1),   gpsdat(2:end,2));

    % Convert distances from degrees to kilometers.
    vehiDistArray = distdim(d_deg, 'deg', 'kilometers');

    totalDistKiloMeters = sum(vehiDistArray);       % In kilometers
    totalDistMiles = totalDistKiloMeters / 1.6;     % Convert to miles
    
    %--------------------------------------------------------------------------
    % Plot pavement distress classification and route data by Google map
    switch pathtype
        case 'continuous'
            latlold = [ latlong(1,1), latlong(1, 2) ];        
            figure;
            set(gcf, 'Position',  [50, 50, 850, 700])
            hold on
            for i = 2:length(gpsdat)
                if ((gpsdat(i,5) >= 0) && (gpsdat(i,5) <= 30))
                    latlnew = [latlong(i,1), latlong(i, 2)];
                    long = [latlold(1); latlnew(1)];
                    lat  = [latlold(2); latlnew(2)];
                    if (linespecifiers == 1)
                        h(1) = plot(long, lat , '-o', 'color', ...
                               [233 17 212]/255, 'LineWidth', 1); 
                    elseif (linespecifiers == 0)
                        h(1) = plot(long, lat , 'color', ...
                               [233 17 212]/255, 'LineWidth', 2);                        
                    end
                    
                elseif ((gpsdat(i,5) > 30) && (gpsdat(i,5) <= 40))
                    latlnew = [latlong(i,1), latlong(i, 2)];
                    long = [latlold(1); latlnew(1)];
                    lat  = [latlold(2); latlnew(2)];
                    if (linespecifiers == 1)
                        h(2) = plot(long, lat , '-x', 'color', ...
                               [0 153 0]/255, 'LineWidth', 1); 
                    elseif (linespecifiers == 0)
                        h(2) = plot(long, lat , 'color', ...
                               [0 153 0]/255, 'LineWidth', 2);                        
                    end                    
                    
                elseif ((gpsdat(i,5) > 40) && (gpsdat(i,5) <= 50))
                    latlnew = [latlong(i,1), latlong(i, 2)];
                    long = [latlold(1); latlnew(1)];
                    lat  = [latlold(2); latlnew(2)];
                    if (linespecifiers == 1)
                        h(3) = plot(long, lat , '-d', 'color', ...
                               [0 0 128]/255, 'LineWidth', 1); 
                    elseif (linespecifiers == 0)
                        h(3) = plot(long, lat , 'color', ...
                               [0 0 128]/255, 'LineWidth', 2);                        
                    end                     
                   
                elseif ((gpsdat(i,5) > 50) && (gpsdat(i,5) <= 60))
                    latlnew = [latlong(i,1), latlong(i, 2)];
                    long = [latlold(1); latlnew(1)];
                    lat  = [latlold(2); latlnew(2)];
                    if (linespecifiers == 1)
                        h(4) = plot(long, lat , '-v', 'color', ...
                               [0 255 255]/255, 'LineWidth', 1); 
                    elseif (linespecifiers == 0)
                        h(4) = plot(long, lat , 'color', ...
                               [0 255 255]/255, 'LineWidth', 2);                        
                    end  
                   
                else
                    latlnew = [latlong(i,1), latlong(i, 2)];
                    long = [latlold(1); latlnew(1)];
                    lat  = [latlold(2); latlnew(2)];
                    if (linespecifiers == 1)
                        h(5) = plot(long, lat , '-^', 'color', ...
                               [255 51 51]/255, 'LineWidth', 1); 
                    elseif (linespecifiers == 0)
                        h(5) = plot(long, lat , 'color', ...
                               [255 51 51]/255, 'LineWidth', 2);                        
                    end  
                    
                end
                latlold = latlnew;
            end
            hold off
        
        case 'discrete'            
            figure;
            set(gcf, 'Position',  [150, 150, 850, 700])
            hold on
            for i = 1:length(gpsdat)
                if ((gpsdat(i,5) >= 0) && (gpsdat(i,5) <= 30))                  
                    h(1) = plot(latlong(i,1), latlong(i,2) , 'color', [233 17 212]/255, 'Marker', 'o', 'MarkerSize', 5); 
                elseif ((gpsdat(i,5) > 30) && (gpsdat(i,5) <= 40))                   
                    h(2) = plot(latlong(i,1), latlong(i,2), 'color', [0 153 0]/255, 'Marker', 'x', 'MarkerSize', 5); 
                elseif ((gpsdat(i,5) > 40) && (gpsdat(i,5) <= 50))                   
                    h(3) = plot(latlong(i,1), latlong(i,2), 'color', [0 0 128]/255, 'Marker', 'd', 'MarkerSize', 5); 
                elseif ((gpsdat(i,5) > 50) && (gpsdat(i,5) <= 60))                   
                    h(4) = plot(latlong(i,1), latlong(i,2), 'color', [0 255 255]/255, 'Marker', 'v', 'MarkerSize', 5);
                else                    
                    h(5) = plot(latlong(i,1), latlong(i,2), 'color', [255 51 51]/255, 'Marker', '^', 'MarkerSize', 5); 
                end                
            end
            hold off             
    end
        plot_google_map('maptype', 'roadmap', 'APIKey', apiKey);
        annotation('textbox', [.15 0.8 0.1 0.1], 'BackgroundColor', [1 1 1], ...
                   'String', ['Track Length: ' num2str(totalDistMiles)...
                   ' miles']);
   
        starting = line(latlong(1, 1), latlong(1, 2), 'Marker', 'o', ...
        'Color', [104 104 11]/255, 'MarkerFaceColor', [104 104 11]/255, 'MarkerSize', 10);

        ending = line(latlong(end, 1), latlong(end, 2), 'Marker', 's', ...
        'Color', [102 0 0]/255, 'MarkerFaceColor', [102 0 0]/255, 'MarkerSize', 10);           
            
        % Speed legend string
        legend_string_cell{1} = '00-30 MPH';
        legend_string_cell{2} = '30-40 MPH';
        legend_string_cell{3} = '40-50 MPH';
        legend_string_cell{4} = '50-60 MPH';
        legend_string_cell{5} = ' > 60 MPH';

        % Start/end point legend string
        legend_string_cell{6} = 'Start Point';
        legend_string_cell{7} = 'End Point';
        
        % Legend
        if isscalar(h) 
            legend([h starting ending], {legend_string_cell{1}, legend_string_cell{6}, legend_string_cell{7}})
        elseif numel(h) == 2
            legend([h starting ending], {legend_string_cell{1}, legend_string_cell{2}, legend_string_cell{6}, ...
                                         legend_string_cell{7}})
        elseif numel(h) == 3
            legend([h starting ending], {legend_string_cell{1}, legend_string_cell{2}, legend_string_cell{3}, ...
                                         legend_string_cell{6}, legend_string_cell{7}})
        elseif numel(h) == 4
            legend([h starting ending], {legend_string_cell{1}, legend_string_cell{2}, legend_string_cell{3}, ...
                                         legend_string_cell{4}, legend_string_cell{6}, legend_string_cell{7}})
        elseif numel(h) == 5
            legend([h starting ending], {legend_string_cell{1}, legend_string_cell{2}, legend_string_cell{3}, ...
                                         legend_string_cell{4}, legend_string_cell{5}, legend_string_cell{6}, ...
                                         legend_string_cell{7}})
        end

        % Axis
        axis off
        
        % Export figure
        exportgraphics(gcf, speedplotpath)
end