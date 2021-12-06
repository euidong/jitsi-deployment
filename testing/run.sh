participants="3"
duration="1000"
conferences="1"
jitsiUrl="meet.jit.si"

docker-compose up --build --scale chrome="$participants" -d

mvn -f 'jitsi-meet-torture/pom.xml' \
      -Dthreadcount=1 \
      -Dorg.jitsi.malleus.conferences="$conferences" \
      -Dorg.jitsi.malleus.participants="$participants" \
      -Dorg.jitsi.malleus.senders="$participants" \
      -Dorg.jitsi.malleus.audio_senders="$participants" \
      -Dorg.jitsi.malleus.duration="$duration" \
      -Dorg.jitsi.malleus.room_name_prefix=testtest \
      -Dorg.jitsi.malleus.regions="" \
      -Dremote.address="http://localhost:4444/wd/hub" \
      -Djitsi-meet.tests.toRun=MalleusJitsificus \
      -Dwdm.gitHubTokenName=jitsi-jenkins \
      -Dremote.resource.path='/usr/share/jitsi-meet-torture' \
      -Djitsi-meet.instance.url="https://meet.jit.si" \
      -Djitsi-meet.isRemote=true \
      -Dchrome.disable.nosanbox=true \
      test