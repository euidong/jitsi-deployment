participants=3
duration=1000
jitsiUrl=https://localhost

docker-compose -f 'jitsi-meet-torture/docker-compose.yml' down

docker-compose -f 'jitsi-meet-torture/docker-compose.yml' up --build --scale chrome="$participants" -d

mvn -f 'jitsi-meet-torture/pom.xml' \
      -Dthreadcount=1 \
      -Dorg.jitsi.malleus.conferences=1 \
      -Dorg.jitsi.malleus.participants="$participants" \
      -Dorg.jitsi.malleus.senders="$participants" \
      -Dorg.jitsi.malleus.audio_senders="$participants" \
      -Dorg.jitsi.malleus.duration="$duration" \
      -Dorg.jitsi.malleus.join_delay=100 \
      -Dorg.jitsi.malleus.max_disrupted_bridges_pct=0 \
      -Dorg.jitsi.malleus.room_name_prefix=loadtest \
      -Dremote.address="http://localhost:4444/wd/hub" \
      -Djitsi-meet.tests.toRun=MalleusJitsificus \
      -Dwdm.gitHubTokenName=jitsi-jenkins \
      -Dremote.resource.path='/usr/share/jitsi-meet-torture' \
      -Djitsi-meet.instance.url="$jitsiUrl" \
      -Djitsi-meet.isRemote=true \
      -Dchrome.disable.nosanbox=true \
      -DallowInsecureCerts=true \
      --debug \
      test
