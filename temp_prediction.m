function temp_prediction(a)
    % TEMP_PREDICTION monitors the rate of change of temperature over the 
    % last 10 seconds and uses it to predict the temperature after 5 
    % minutes.
    %
    % The temperature is read using a thermistor every second and the last 
    % 10 readings are stored. These are then used to find the rate of 
    % change of the temperature and if it is above 4°C/min a red LED is 
    % lit, if it is below -4°C/min a yellow LED is lit, otherwise a green 
    % LED is lit. The rate of change of temperature is then used to predict
    % the temperature in 5 minutes.

    % get first reading for temperature
    % read voltage from thermistor
    voltage = readVoltage(a,"A0");
    % calculate temperature using current voltage of thermistor, 0 
    % degree voltage ofthermistor, and temperature coefficient of 
    % thermistor
    temperature = (voltage - 0.5) / 0.01;
    % create list to hold the 10 most recent temperature readings and add 
    % the current temperature
    recentTemps = [temperature];
    % loop indefinitely through the next section of code
    while true
        pause(1);
        % get first reading for temperature
        % read voltage from thermistor
        voltage = readVoltage(a,"A0");
        % calculate temperature using current voltage of thermistor, 0 
        % degree voltage ofthermistor, and temperature coefficient of 
        % thermistor
        temperature = (voltage - 0.5) / 0.01
        % if recentTemps has <10 values in it then just append current
        % temperature
        if length(recentTemps) < 10
            recentTemps = [recentTemps, temperature]
        % if recent temps already has 10 values then shift all values to
        % the left by 1 to make room for the current temperature
        else
            recentTemps = [recentTemps(2:end), temperature]
        end
        % calculate rate of change of temperature based on the recent
        % temperature readings and print it to the screen
        tempChangeRate = (recentTemps(length(recentTemps)) - ...
            recentTemps(1)) / (length(recentTemps) - 1);
        fprintf('Rate of change of temperature = %f °C/s',tempChangeRate)
        % predict temperature in 5 minutes and print it to the screen
        predictedTemp = temperature + (tempChangeRate * 300)
        fprintf('Predicted temperature in 5 minutes = %f °C',predictedTemp)
        % if rate of change of temperature is greater than 4°C/min turn on
        % red LED and turn green and yellow LEDs off
        if tempChangeRate > (4/60)
            writeDigitalPin(a,'D13',1)
            writeDigitalPin(a,'D12',0)
            writeDigitalPin(a,'D11',0)
        % if rate of change of temperature is less than -4°C/min turn on
        % yellow LED and turn green and red LEDs off
        elseif tempChangeRate < (-4/60)
            writeDigitalPin(a,'D13',0)
            writeDigitalPin(a,'D12',1)
            writeDigitalPin(a,'D11',0)
        % otherwise turn green LED on and yellow and red LEDs off
        else
            writeDigitalPin(a,'D13',0)
            writeDigitalPin(a,'D12',0)
            writeDigitalPin(a,'D11',1)
    end
end