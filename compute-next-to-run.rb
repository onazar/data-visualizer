require 'json'

File.open("solano-plan-variables.json", "w") do |f|
  f.write(JSON.dump({"next_profile_two" => "two"})) if ENV['next_profile'].nil?
  f.write(JSON.dump({"next_profile_four" => "four"})) unless ENV['next_profile'].nil?
end
