app_environment_variables = File.join(Rails.root, 'config/variables', Rails.env.to_s + '.rb')
load(app_environment_variables)