#!/bin/bash
secretsfile="$1"
instance="$2"

get-secret () {
    printf '%q' $(grep -e "$1" "$secretsfile" | cut -d "=" -f2)
}

encrypt-secret () {
    get-secret "$1" | base64
}

# mac must need change sed => gsed
gsed -i 's/JICOFO_COMPONENT_SECRET: .*/JICOFO_COMPONENT_SECRET: '$(encrypt-secret "JICOFO_COMPONENT_SECRET")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/JICOFO_AUTH_PASSWORD: .*/JICOFO_AUTH_PASSWORD: '$(encrypt-secret "JICOFO_AUTH_PASSWORD")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/JVB_AUTH_PASSWORD: .*/JVB_AUTH_PASSWORD: '$(encrypt-secret "JVB_AUTH_PASSWORD")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/JVB_STUN_SERVERS: .*/JVB_STUN_SERVERS: '$(encrypt-secret "JVB_STUN_SERVERS")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/TURNCREDENTIALS_SECRET: .*/TURNCREDENTIALS_SECRET: '$(encrypt-secret "TURNCREDENTIALS_SECRET")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/TURN_HOST: .*/TURN_HOST: '$(encrypt-secret "TURN_HOST")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/STUN_PORT: .*/STUN_PORT: '$(encrypt-secret "STUN_PORT")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/TURN_PORT: .*/TURN_PORT: '$(encrypt-secret "TURN_PORT")'/g' base/jitsi/jitsi-secret.yaml
gsed -i 's/TURNS_PORT: .*/TURNS_PORT: '$(encrypt-secret "TURNS_PORT")'/g' base/jitsi/jitsi-secret.yaml

gsed -i 's/stunServers: \[.*/stunServers: \['$(get-secret "stunServers")'/g' base/jitsi/web-configmap.yaml


gsed -i 's/esadmin:.*/esadmin:'$(encrypt-secret "esadmin.password")'/g' base/ops/logging/es-realm-secret.yaml

gsed -i 's/email: .*/email: '$(get-secret "spec.acme.email")'/g' overlays/${instance}-loadbalancer/cluster-issuer.yaml
gsed -i 's/username: .*/username: '$(encrypt-secret "username")'/g' overlays/${instance}-monitoring/bbb-basic-auth-secret.yaml
gsed -i 's/password: .*/password: '$(encrypt-secret "password")'/g' overlays/${instance}-monitoring/bbb-basic-auth-secret.yaml
