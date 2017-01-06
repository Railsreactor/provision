package :logrotate do
  description 'Install logrotate'

  apt 'logrotate' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'logrotate'
    has_file '/etc/cron.daily/logrotate'
  end
end
