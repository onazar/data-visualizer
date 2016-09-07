require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    if ENV["PROFILE"] == "one"
        f.write(JSON.dump({"second_profile" => "two"}))
    end
    if ENV["PROFILE"] == "three"
        f.write(JSON.dump({"fourth_profile" => "four"}))
    end
end
