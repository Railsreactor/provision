# see https://help.ubuntu.com/lts/serverguide/automatic-updates.html
package :security_upgrades do
  description 'Automatic security upgrades'

  requires :unattended_upgrades

  %w{10periodic 50unattended-upgrades}.each do |config_file|
    config_file_path = "/etc/apt/apt.conf.d/#{config_file}"
    config_template = File.join(File.dirname(__FILE__), 'configs', config_file)

    file(
      config_file_path,
      contents: File.read(config_template),
      sudo: true,
      owner: 'root:root',
      mode: '644')
  end
end

package :unattended_upgrades do
  apt 'unattended-upgrades' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'unattended-upgrades'
  end
end
