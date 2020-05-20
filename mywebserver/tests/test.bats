TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} caddy -help
  [ $status -eq 2 ]
}

@test "Basic config validation" {
  run hab pkg exec ${TEST_PKG_IDENT} caddy -validate
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "mywebserver\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 8080" {
  result="$(netstat -peanut | grep caddy | head -1 | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 8080 ]
}
