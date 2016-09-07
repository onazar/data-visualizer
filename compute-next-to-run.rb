require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"next_profile_two" => "two", "next_profile_four" => "four"}))
end
