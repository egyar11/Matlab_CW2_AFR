% Alexander Richardson
% egyar11@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

% Insert answers here

% establish connection to arduino
a = arduino("COM6", "Uno");
% loop blinking the light 5 times
for i = 1:5
    % turn light on
    writeDigitalPin(a,'D13',1)
    % wait 5 seconds
    pause(0.5)
    % turn light off
    writeDigitalPin(a,'D13',0)
    % wait 5 seconds
    pause(0.5)
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

% create variable to hold the acquisition time in seconds, assign the
% initial value of 600
duration = 600;

% create arrays to store voltage read from thermistor, and temperatures
% calculated from the voltages
voltages = [];
temperatures = [];
% loop through 1 second intervals until acquistion time is 0 - 10 minutes 
% will have passed
% assign temperature coefficient and zero-degree voltage of thermistor to
% variables
Tc = 0.01;
V0c = 0.5;
while duration > 0
    % read voltage and assign it to a temporary variable, then append it to
    % the array
    tempVoltage = readVoltage(a,"A0");
    voltages = [voltages, tempVoltage];
    % convert the voltage to a temperature using the temperature
    % coefficient and the zero-degree voltage for the thermistor
    tempTemperature = (tempVoltage - V0c) / Tc;
    temperatures = [temperatures, tempTemperature];
    % decrement remaining acquisition time
    duration = duration - 1;
end

% find minimum temperature 
minTemperature = min(temperatures);
% find maximum temperature
maxTemperature = max(temperatures);
% find average temperature
averageTemperature = mean(temperatures);

% plot temperature/time, first an array that golds the time from start for
% each temperature reading must be created since duration counts down from
% 600 seconds
times = 0:(length(temperatures)-1);
% create plot
plot(times, temperatures)
% create axis labels including units
xlabel('Time (s)')
ylabel('Temperature (°C)')

% get current date
date= datetime('today');
% change date to desired format
date.Format = 'd/M/yyyy';
date = char(date);
% print current date
toPrint = sprintf('Data logging initiated - %s', date);
disp(toPrint)
% print location
toPrint = sprintf('Location - Nottingham');
disp(toPrint)
% iterate through each minute from 0 to 10, printing the temperature
for i = 0:10
    toPrint = sprintf('\nMinute        %.0f\nTemperature   %.2f C', i, ...
        temperatures(i + 1));
    disp(toPrint)
end
% print maximum, minimum, and average tremperature
toPrint = sprintf('\nMax temp      %.2f C', maxTemperature);
disp(toPrint)
toPrint = sprintf('Min temp      %.2f C', minTemperature);
disp(toPrint)
toPrint = sprintf('Average temp  %.2f C', averageTemperature);
disp(toPrint)
% print message that data logging has ended
toPrint = sprintf('\nData logging terminated');
disp(toPrint)

% open file for writing capsule temperatures
fileID = fopen('capsule_temperature.txt', 'w');
% write all of the above text to the file using fprintf
fprintf(fileID, 'Data logging initiated - %s\n', date);
fprintf(fileID, 'Location - Nottingham\n');
for i = 0:10
    fprintf(fileID, '\nMinute        %.0f\nTemperature   %.2f C\n', i, ...
        temperatures(i + 1));
end
fprintf(fileID, '\nMax temp      %.2f C\n', maxTemperature);
fprintf(fileID, 'Min temp      %.2f C\n', minTemperature);
fprintf(fileID, 'Average temp  %.2f C\n', averageTemperature);
fprintf(fileID, '\nData logging terminated');
% close the file
fclose(fileID);

% open generated file and check that the data has been written correctly
fileID = fopen('capsule_temperature.txt', 'r');
fileText = fscanf(fileID, '%c');
fclose(fileID);
disp(fileText)

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here

% call temperature monitor function
% temp_monitor(a)
%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here
temp_prediction(a)

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
