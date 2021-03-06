package :git do
  description 'Install git'

  apt 'git-core' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'git-core'
  end
end
