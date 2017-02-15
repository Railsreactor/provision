package :mysql_client do
  description 'Install mysql client'

  apt 'libmysqlclient-dev' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'libmysqlclient-dev'
  end
end
