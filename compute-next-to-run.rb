require 'json'

profile = %w(two).sample

File.open("solano-plan-variables.json", "w") do |f|
    f.write(JSON.dump({"next_profile" => "#{profile}"}))
end
