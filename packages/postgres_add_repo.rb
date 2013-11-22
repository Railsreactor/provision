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