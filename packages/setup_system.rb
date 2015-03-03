package :setup_system do
  defaults deployer_user: 'ubuntu'

  requires :create_deployer_user, deployer_user: opts[:deployer_user]
  requires :system_settings
end

package :system_settings do
  %w[LC_ALL LANG LC_CTYPE].each do |lang|
    runner "sh -c \"echo '#{lang}=en_US.UTF-8' >> /etc/environment\""

    verify do
      @commands << "cat /etc/environment | grep \"#{lang}=en_US.UTF-8\""
    end
  end
end
