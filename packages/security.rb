package :security do
  description 'Security features: fail2ban daemon, iptables rules'
  
  apt 'fail2ban iptables-persistent' do
    post :install, [
      'sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local',
      "sed -i 's/bantime  = 600/bantime = 86400/g' /etc/fail2ban/jail.local",
      '/etc/init.d/fail2ban restart'
    ]
  end

  iptables_template = File.join(File.dirname(__FILE__), 'configs', 'rules.v4')
  file '/etc/iptables/rules.v4', contents: File.read(iptables_template), sudo: true
  runner 'iptables-restore < /etc/iptables/rules.v4'
end
