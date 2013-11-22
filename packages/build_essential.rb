package :build_essential do
  description 'Build tools'

  apt 'build-essential' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'build-essential'
  end
end
