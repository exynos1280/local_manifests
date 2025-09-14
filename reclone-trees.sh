#!/bin/bash
set -e

DEVICES=(
  "a25x" "a53x" "m33x" "m34x"
  "s5e8825-common"
)
XML="$(pwd)/.repo/local_manifests/s5e8825.xml"
URL="https://github.com/exynos1280"
[ "$(whoami)" = "ksawlii" ] && URL="git@github.com-ksawlii:exynos1280"
[ -z "$BRANCH" ] && BRANCH="lineage-22.2"

if [ ! -f "$XML" ]; then
  echo "s5e8825.xml not found. Please execute from root dir."
  exit 1
fi

for m in "${DEVICES[@]}"; do
  sed -i "/$m/d" "$XML"
  [ -d "$(pwd)/device/samsung/$m" ] && rm -rf "$(pwd)/device/samsung/$m"
  git clone -j"$(nproc --all)" "$URL/android_device_samsung_$m" "$(pwd)/device/samsung/$m"
  [ -d "$(pwd)/vendor/samsung/$m" ] && rm -rf "$(pwd)/vendor/samsung/$m"
  git clone -j"$(nproc --all)" "$URL/proprietary_vendor_samsung_$m" "$(pwd)/vendor/samsung/$m"
done
