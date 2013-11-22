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