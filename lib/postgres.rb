module Sprinkle
  module Verifiers
    # PG verifiers
    module Postgres
      Sprinkle::Verify.register(Sprinkle::Verifiers::Postgres)

      # checks if user exist in postgres db
      def pg_user?(user)
        @commands << "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_roles WHERE rolname='#{user}'\" | egrep -q 1"
      end

      # checks if database exist in postgres db
      def pg_db?(db_name)
        @commands << "sudo -u postgres psql -l | egrep #{db_name}"
      end

      def pg_version?(version)
        @commands << "sudo -u postgres psql -tAc \"SELECT 1 FROM version() WHERE version LIKE '%#{version}%';\" | egrep -q 1"
      end
    end
  end
end
