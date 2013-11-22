package :bundler do
  description 'Setup bundler'
  gem 'bundler' do
    version '1.3.5'
  end

  verify do
    has_gem 'bundler', version
  end
end