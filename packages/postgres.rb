package :postgres do
  requires :postgres_db, :postgres_encoding_utf8, :update_pg_hba
end

package :postgres_add_repo do
  file '/etc/apt/sources.list.d/pgdg.list',
    contents: 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main',
    sudo: true

  runner 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -'
  runner 'apt-get update'

  verify do
    has_file '/etc/apt/sources.list.d/pgdg.list'
    @commands << "apt-key list | grep 'ACCC4CF8'"
  end
end

package :postgres_db do
  description 'Setup PostgreSQL database from package'
  version 9.3
  runner "apt-get install postgresql-#{version} postgresql-contrib-#{version} -y" do
    pre :install, ['aptitude update']
  end

  verify do
    has_pg_user 'postgres'
    has_pg_version version
  end

  requires :postgres_add_repo
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

package :update_pg_hba do
  description "PostgreSQL: Config"

  config_file_path = '/etc/postgresql/9.3/main/pg_hba.conf'
  config_template = File.join(File.dirname(__FILE__), 'pg_hba.conf')

  file config_file_path, contents: File.read(config_template), sudo: true

  runner "chown postgres:postgres #{config_file_path}"

  verify do
    has_file config_file_path
    @commands << "cat #{config_file_path} | grep local | grep all | grep postgres | grep trust"
    @commands << 'ls -la /etc/postgresql/9.3/main/ | grep pg_hba | grep "postgres postgres"'
  end
end
