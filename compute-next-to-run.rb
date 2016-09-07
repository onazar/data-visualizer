require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"second_profile" => "two", "fourts_profile" => "four"}))
end
