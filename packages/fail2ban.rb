package :fail2ban, :provides => :bruteforce_protection do
  description "Fail2ban - ssh brute-force protection"
  
  apt 'fail2ban' do
    post :install, [
      'sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local',
      "sed -i 's/bantime  = 600/bantime = 86400/g' /etc/fail2ban/jail.local",
      '/etc/init.d/fail2ban restart'
    ]
  end
end
