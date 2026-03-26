% define function
function temp_monitor(a)
    % loop indefinitely
    while true
        % read voltage from thermistor
        voltage = readVoltage(a,"A0");
        % calculate temperature using current voltage of thermistor, 0 
        % degree voltage ofthermistor, and temperature coefficient of
        % thermistor
        temperature = (voltage - 0.5) / 0.01;
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
    end
end