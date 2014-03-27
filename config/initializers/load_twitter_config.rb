unless ENV["RAILS_ENV"] == 'test'
  social_keys = File.join(Rails.root, 'config', 'social_keys.yml')
  CONFIG = HashWithIndifferentAccess.new(YAML::load(IO.read(social_keys)))[Rails.env]
  CONFIG.each do |k,v|
    ENV[k.upcase] ||= v
  end
end
