package :swap do
  block_size_mb = 128
  block_count = 16 # 2Gb swap
  swap_fstab = '/swapfile   none    swap    sw    0   0'

  runner "sudo dd if=/dev/zero of=/swapfile bs=#{block_size_mb}M count=#{block_count}"
  runner 'sudo chmod 600 /swapfile'
  runner 'sudo mkswap /swapfile'
  runner 'sudo swapon /swapfile'
  runner 'sudo swapon -s'
  runner "sudo echo '#{swap_fstab}' >> /etc/fstab"

  verify do
    file_contains '/etc/fstab', swap_fstab
    has_file '/swapfile'
    has_swap_memory
  end
end
