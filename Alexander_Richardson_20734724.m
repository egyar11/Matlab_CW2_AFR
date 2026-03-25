% Alexander Richardson
% egyar11@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

% Insert answers here

% establish connection to arduino (it seems that once this has been done
% once it does not need to be done again so this line is commented to avoid
% errors when running the code to test it)
a = arduino("COM6", "Uno")
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
Tc = 10;
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

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
