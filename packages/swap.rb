package :swap do
  swap_size = [opts[:swap_size].to_i, 2].max * 1_000_000_000
  swap_fstab = '/swapfile   none    swap    sw    0   0'

  # fallocate now accepts bytes
  runner "sudo fallocate -l #{swap_size} /swapfile"
  runner 'sudo chmod 600 /swapfile'
  runner 'sudo mkswap /swapfile'
  runner 'sudo swapon /swapfile'
  runner "sudo sh -c \"echo '#{swap_fstab}' >> /etc/fstab\""

  verify do
    file_contains '/etc/fstab', swap_fstab
    has_file '/swapfile'
    has_swap_memory(swap_size)
  end
end
