package :grunt do
  requires :nodejs

  runner 'sudo npm install -g grunt-cli'

  verify do
    @commands << 'grunt -v | grep "The grunt command line interface"'
  end
end
