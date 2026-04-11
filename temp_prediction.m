function temp_prediction(a)
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
    end
end