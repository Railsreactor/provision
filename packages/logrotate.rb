package :logrotate do
  description 'Install logrotate'

  apt 'logrotate' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'logrotate'
    has_file '/etc/cron.daily/logrotate'
  end
end
