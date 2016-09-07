require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    puts ENV["PROFILE"]
    puts ENV["profile"]
    puts ENV.inspect
    if ENV["PROFILE"] == "two"
        f.write(JSON.dump({"second_profile" => "two"}))
    end
    if ENV["PROFILE"] == "two"
        f.write(JSON.dump({"fourth_profile" => "four"}))
    end
end
