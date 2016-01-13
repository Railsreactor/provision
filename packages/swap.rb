package :swap do
  swap_size = (opts[:swap_size] || 2) * 1024 * 1024
  swap_fstab = '/swapfile   none    swap    sw    0   0'

  runner "fallocate -l #{swap_size} /swapfile"
  runner 'sudo chmod 600 /swapfile'
  runner 'sudo mkswap /swapfile'
  runner 'sudo swapon /swapfile'
  runner "sh -c \"echo '#{swap_fstab}' >> /etc/fstab\""

  verify do
    file_contains '/etc/fstab', swap_fstab
    has_file '/swapfile'
    has_swap_memory(swap_size)
  end
end
