TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  [ "$(hab svc status | grep "myloadbalancer\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 8090" {
  result="$(netstat -peanut | grep haproxy | head -1 | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 8090 ]
}
