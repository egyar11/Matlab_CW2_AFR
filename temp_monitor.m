function temp_monitor(a)
    % TEMP_MONITOR monitors the temperature in real time and indicates if it is
    % within the acceptable range. 
    % 
    % Every second the voltage is measured through a thermistor that is 
    % connected to an arduino and calculates the thermistor temperature. A 
    % graph of temperature against time is plotted and updated live. When the 
    % temperature is within the acceptable range of 18-24 degrees C, a green 
    % LED is lit, when it is below the range a yellow LED blinks at 0.5s 
    % intervals, when it is above the range a red LED blinks at 0.25s 
    % intervals. The arduino object is passed as an argument.

    % create variable to hold time in seconds since the start of the 
    % function for each reading and set it to 0
    time = 0;
    % get first reading for temperature
    % read voltage from thermistor
    voltage = readVoltage(a,"A0");
    % calculate temperature using current voltage of thermistor, 0 
    % degree voltage ofthermistor, and temperature coefficient of 
    % thermistor
    temperature = (voltage - 0.5) / 0.01;
    % plot graph of temperature against time
    graph = animatedline(time,temperature);
    % create axis labels including units
    xlabel('Time (s)')
    ylabel('Temperature (°C)')
    % loop indefinitely
    while true
        % if temperature is below 18 degrees C blink yellow LED at 0.5s
        % intervals for 1 second
        if temperature < 18
            % if green LED is on power it off
            writeDigitalPin(a,'D11',0);
            % power yellow LED on
            writeDigitalPin(a,'D12',1);
            % wait 0.5 seconds
            pause(0.5);
            % power yellow LED off
            writeDigitalPin(a,'D12',0);
            % wait 0.5 seconds
            pause(0.5);
        % otherwise if temperature is above 24 degrees C blink red LED at
        % 0.25s intervals for 1 second
        elseif temperature > 24
            % if green LED is on power it off
            writeDigitalPin(a,'D11',0);
            % power red LED on
            writeDigitalPin(a,'D13',1);
            % wait 0.25 seconds
            pause(0.25);
            % power red LED off
            writeDigitalPin(a,'D13',0);
            % wait 0.25 seconds
            pause(0.25);
            % power red LED on
            writeDigitalPin(a,'D13',1);
            % wait 0.25 seconds
            pause(0.25);
            % power red LED off
            writeDigitalPin(a,'D13',0);
            % wait 0.25 seconds
            pause(0.25);
        % otherwise temperature is within acceptable range so power green
        % LED on for 1 second
        else
            % power green LED on
            writeDigitalPin(a,'D11',1)
            % wait one second
            pause(1)
        end
        % read voltage from thermistor
        voltage = readVoltage(a,"A0");
        % calculate temperature using current voltage of thermistor, 0 
        % degree voltage ofthermistor, and temperature coefficient of
        % thermistor
        temperature = (voltage - 0.5) / 0.01;
        % increment time
        time = time + 1;
        % update graph
        addpoints(graph,time,temperature)
        drawnow
    end
end