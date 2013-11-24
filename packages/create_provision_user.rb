package :create_provision_user do
  # create basic ssh key for all users
  runner 'mkdir -p /etc/skel/.ssh'
  id_rsa_pub = `cat ~/.ssh/id_rsa.pub`.strip
  runner "sh -c \"echo '#{id_rsa_pub}' > /etc/skel/.ssh/authorized_keys\""

  # create provision user
  runner 'useradd provision -m'
  runner "sh -c \"echo 'provision ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers\""

  verify do
    has_file '/etc/skel/.ssh/authorized_keys'
  end
end
