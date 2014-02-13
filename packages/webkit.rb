package :webkit do
  xvfb_path = '/etc/init.d/xvfb'
  xvfb_content = <<TEXT
export DISPLAY=localhost:1.0
XVFB=/usr/bin/Xvfb
XVFBARGS=":1 -screen 0 1024x768x24 -ac +extension GLX +render -noreset"
PIDFILE=/var/run/xvfb.pid
case "$1" in
  start)
    echo -n "Starting virtual X frame buffer: Xvfb"
    start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS
    echo "."
    ;;
  stop)
    echo -n "Stopping virtual X frame buffer: Xvfb"
    start-stop-daemon --stop --quiet --pidfile $PIDFILE
    echo "."
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
        echo "Usage: /etc/init.d/xvfb {start|stop|restart}"
        exit 1
esac

exit 0
TEXT

  apt 'libqt4-dev'
  apt 'libicu48'
  apt 'xvfb'

  push_text xvfb_content, xvfb_path, sudo: true do
    post :install, 'sudo chmod +x /etc/init.d/xvfb'
  end

  verify do
    has_apt 'libqt4-dev'
    has_apt 'libicu48'
    has_apt 'xvfb'
    file_contains xvfb_path, 'XVFB=/usr/bin/Xvfb'
  end
end
