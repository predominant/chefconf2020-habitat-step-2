# mywebserver/plan.sh
pkg_name=mywebserver
pkg_origin=chefconf2020
pkg_version="0.1.0"
pkg_maintainer="Graham Weldon <graham@grahamweldon.com>"
pkg_license=("Apache-2.0")
pkg_deps=(core/caddy)
pkg_build_deps=()
pkg_svc_run="caddy -conf ${pkg_svc_config_path}/Caddyfile"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_build() {
  return 0
}

do_install() {
  cp -r public "${pkg_prefix}/"
}
