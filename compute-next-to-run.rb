require 'json'

File.open("solano-plan-variables.json", "w") do |f|
    if ENV['first_run_dynamic_profile'].nil? || ENV['first_run_dynamic_profile'].empty?
        f.write(JSON.dump({"next_profile_two" => "two"}))
        ENV['first_run_dynamic_profile'] = "fired"
    else
        f.write(JSON.dump({"next_profile_four" => "four"}))
    end
end
