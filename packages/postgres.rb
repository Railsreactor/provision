package :postgres_db do
  description 'Install Postgres'
  defaults postgres_version: '9.6'

  requires :postgres_apt
  requires :postgresql_server, postgres_version: opts[:postgres_version]
  requires :update_pg_hba, postgres_version: opts[:postgres_version]
  requires :update_postgresql_conf, postgres_version: opts[:postgres_version]
  requires :postgres_encoding_utf8
end

package :postgres_apt do
  apt_list    = '/etc/apt/sources.list.d/pgdg.list'
  apt_source  = "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -c -s`-pgdg main\n"

  runner "echo \"#{apt_source}\" | sudo tee #{apt_list}" do
    pre :install, 'true && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -'
    post :install, 'sudo apt-get update'
  end

  verify do
    file_contains apt_list, 'pgdg'
  end
end

package :postgresql_server do
  requires :postgres_apt

  apt "postgresql-#{opts[:postgres_version]} postgresql-contrib-#{opts[:postgres_version]}"

  verify do
    has_apt "postgresql-#{opts[:postgres_version]}"
    has_apt "postgresql-contrib-#{opts[:postgres_version]}"
  end
end

package :update_pg_hba do
  config_file_path = "/etc/postgresql/#{opts[:postgres_version]}/main/pg_hba.conf"
  config_template = File.join(File.dirname(__FILE__), 'configs', 'pg_hba.conf')

  file config_file_path, contents: File.read(config_template), sudo: true

  runner "chown postgres:postgres #{config_file_path}"
  runner "chmod 755 #{config_file_path}"
  runner 'service postgresql restart'

  verify do
    has_file config_file_path
    has_permission config_file_path, '755'
    belongs_to_user config_file_path, 'postgres'
    belongs_to_group config_file_path, 'postgres'
  end
end

package :postgres_encoding_utf8 do
  runner %{echo "
  update pg_database set datistemplate=false where datname='template1';
  drop database Template1;
  create database template1 with owner=postgres encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
  update pg_database set datistemplate=true where datname='template1';" | sudo -u postgres psql}

  verify do
    @commands << "echo \"select datcollate from pg_database where datname='template1'\" | sudo -u postgres psql | grep en_US.utf8"
  end
end

package :update_postgresql_conf do
  runner "sed -i 's/max_connections = 100/max_connections = 300/g' /etc/postgresql/#{opts[:postgres_version]}/main/postgresql.conf"

  verify do
    file_contains "/etc/postgresql/#{opts[:postgres_version]}/main/postgresql.conf", 'max_connections = 300'
  end
end

# TODO: auto restart after reboot, https://github.com/grimen/sprinkle-stack/blob/master/packages/database/postgresql.rb
