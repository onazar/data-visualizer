require 'json'

File.open("solano-plan-variables.json", "w") do |f|
  f.write(JSON.dump({"next_profile" => "two"})) if ENV['next_profile'].nil?
  f.write(JSON.dump({"next_profile" => "four"})) unless ENV['next_profile'].nil?
end
