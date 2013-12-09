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

#package :postgres_user do
#  runner %{echo "CREATE ROLE #{DEPLOY_USER} WITH LOGIN ENCRYPTED PASSWORD '#{DEPLOY_POSTGRES_PASSWORD}';" | sudo -u postgres psql}
#
#  verify do
#    @commands << "echo 'SELECT ROLNAME FROM PG_ROLES' | sudo -u postgres psql | grep #{DEPLOY_USER}"
#  end
#end