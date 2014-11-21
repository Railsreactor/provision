package :create_deployer_user do
  # create basic ssh key for all users - this is unsafe and does not work or every linux distro
  runner 'mkdir -p /etc/skel/.ssh'
  id_rsa_pub = `cat ~/.ssh/id_rsa.pub`.strip
  runner "sh -c \"echo '#{id_rsa_pub}' > /etc/skel/.ssh/authorized_keys\""

  # create deployer user
  runner 'useradd -m -s /bin/bash ubuntu'
  runner "sh -c \"echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers\""
  runner 'chmod 0700 /home/ubuntu/.ssh'
  runner 'chown -R ubuntu:ubuntu /home/ubuntu/.ssh'
  runner 'chmod 0700 /home/ubuntu/.ssh/authorized_keys'

  verify do
    has_file '/etc/skel/.ssh/authorized_keys'
    has_file '/home/ubuntu/.ssh/authorized_keys'
  end
end
