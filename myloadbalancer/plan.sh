# myloadbalancer/plan.sh
pkg_name=myloadbalancer
pkg_origin=chefconf2020
pkg_version="0.1.0"
pkg_maintainer="Graham Weldon <graham@grahamweldon.com>"
pkg_license=("Apache-2.0")
pkg_deps=(core/haproxy)
pkg_build_deps=()
pkg_svc_run="haproxy -f ${pkg_svc_config_path}/haproxy.conf"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_binds=(
  [backend]="port"
)

do_build() {
  return 0
}

do_install() {
  return 0
}
