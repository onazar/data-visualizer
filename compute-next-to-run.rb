require 'json'

profiles = %w(two four)
profile = profiles.sample

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"next_profile" => profile}))
end
