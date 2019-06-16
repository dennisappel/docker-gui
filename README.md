# USAGE

## Prerequisites

Place a JRE and the JAR File that is supposed to be used with the docker image in the client directory.  
Either store the required user information and information on the JRE in your environmental variables,
or create files to store them.

## BUILD

### Required Variables

- `JAVA_DIR` = path to jre installation in container
- `JRE` = full jre name
- `JRE_FILE` = tarball of jre
- `JAR` = java program to run

Builds the image using the variables defined in the file passed with `-f`.  
`./build -f variables.sh`

## RUN

### Required Variables

- `BIN` = path to binary in docker container
- `CONN`
- `CLNT`
- `USER`
- `PASS`
- `LANG`

Starts the container using the credientials defined in the file passed by `-f`. Create screenshots every second by passing `-m`  
`./run.sh -m -f credentials.sh`
