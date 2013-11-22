package :postgres_db do
  description 'Setup PostgreSQL database from package'
  version 9.3
  runner "apt-get install postgresql-#{version} postgresql-contrib-#{version} -y"
  verify do
    has_pg_user 'postgres'
    has_pg_version version
  end
end