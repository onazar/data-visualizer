require 'json'

profiles = %w(two four)

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"next_profile" => profiles.sample}))
end
