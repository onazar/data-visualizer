require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"second_profile" => "two", "fourth_profile" => "four"}))
end
