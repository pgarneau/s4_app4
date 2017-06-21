function [total] = GetRMS(og_data, new_data)
total = 0;
for index = 1:70000
    result = (new_data(index) - og_data(index))^2;
    total = total + result;
end
total = total / 70000;
total = sqrt(total);
end

