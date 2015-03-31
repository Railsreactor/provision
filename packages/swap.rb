package :swap do
  block_size_mb = 128
  block_count = 16 # 2Gb swap

  runner "sudo dd if=/dev/zero of=/swapfile bs=#{block_size_mb}M count=#{block_count}"
  runner 'sudo chmod 600 /swapfile'
  runner 'sudo mkswap /swapfile'
  runner 'sudo swapon /swapfile'
  runner 'sudo swapon -s'

  verify do
    has_file '/swapfile'
  end
end
