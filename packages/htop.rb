package :htop do
  apt 'htop' do
    pre :install, ['aptitude update']
  end

  verify { has_apt 'htop' }
end