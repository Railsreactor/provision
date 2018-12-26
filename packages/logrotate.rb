# Sample setup for Rails app
#
# ssh ...
#
# sudo su
#
# cd /home/ubuntu/xxx/shared/log && ls -la && vi /etc/logrotate.d/xxx.conf
#
# /home/ubuntu/xxx/current/log/*.log {
#  su root
#  daily
#  maxsize 10M
#  missingok
#  notifempty
#  rotate 14
#  compress
#  delaycompress
#  copytruncate
#  dateext
#}
#
# logrotate /etc/logrotate.d/xxx.conf && ls -la /home/ubuntu/xxx/shared/log
#
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
