package :git do
  apt 'git-core' do
    pre :install, ['aptitude update']
  end

  verify { has_apt 'git-core' }
end