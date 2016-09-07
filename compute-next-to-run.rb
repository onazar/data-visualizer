require 'json'

File.open("solano-plan-variables.json", "w") do |f|
  if !(ENV['second_run'].nil? || ENV['second_run'].empty?)
    f.write(JSON.dump({"next_profile_two" => "two"}))
    ENV['second_run'] = 'true'
  else
    f.write(JSON.dump({"next_profile_two" => "two", "next_profile_four" => "four"}))
  end
end
