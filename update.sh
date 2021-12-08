echo "run update"
kubectl patch statefulset shard-0-jvb --type='json' -p='[{"op":"replace", "path":  "/spec/template/spec/containers/0/image", value: "justicedong/jvb:0.0.1"}]' -n jitsi
echo "update config"
# kubectl exec -it pod/shard-0-web-57dd4cb8c8-vnb4h -n jitsi -- echo "JVB_NOW_UPDATING=true" >> /config/config.js -n jitsi

sleep 1

echo "update finish"
# kubectl exec -it pod/shard-0-web-57dd4cb8c8-vnb4h -n jitsi -- echo "JVB_NOW_UPDATING=false" >> /config/config.js -n jitsi

echo "change config"
echo "done..."