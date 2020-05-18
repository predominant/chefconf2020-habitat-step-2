# ChefConf 2020 Chef Habitat Demonstration

## Habitat Studio Testing

### Enter the Habitat Studio

```
# Open up the loadbalancer ports only
export HAB_DOCKER_OPTS="-p 8090:8090 -p 8091:8091"
hab studio enter
```

### Build and run the packages

Use one only, Multiline, or:

```
build mywebserver
source results/last_build.env
hab svc load ${pkg_ident}
build myloadbalancer
source results/last_build.env
hab svc load ${pkg_ident} --bind backend:mywebserver.default
```

Single line

```
build mywebserver; source results/last_build.env; hab svc load ${pkg_ident}; build myloadbalancer; source results/last_build.env; hab svc load ${pkg_ident} --bind backend:mywebserver.default
```

## Virtualbox cluster



