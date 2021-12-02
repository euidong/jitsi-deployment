kubectl patch deployment shard-0-jicofo --type='json' -p='[{"op":"replace", "path":  "/spec/template/spec/containers/0/image", value: "justicedong/jvb:0.0.1"}]' -n jitsi

sleep 1000

kubectl exec -it shard-0-web echo "JVB_NOW_UPDATING=true" >> /default/config.js -n jitsi

sleep 10000

