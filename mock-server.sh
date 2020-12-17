#!/bin/bash -e

export SWAGGER_DIR=${SWAGGER_DIR:-/tmp/swagger}

function printHelp() {
  echo "Usage: "
  echo "  $0 [commands]"
  echo "     [commands]"
  echo "        start: Start Mock Server"
  echo "         stop: Stop Mock Server"
  echo "      restart: Restart Mock Server"
  echo "       reload: Same restart"
  echo "         help: Print help"
}

function is_running() {
  [ "$(docker-compose ps -q)" ]
  return
}

function start() {
  if is_running; then
    echo "Already Running."
    return
  fi

  if [ ! -d "$SWAGGER_DIR" ]; then
    echo -e "${SWAGGER_DIR} directory is not found.\nCreating ${SWAGGER_DIR}...\n"
    mkdir -p $SWAGGER_DIR
    cp ./swagger/*.yaml $SWAGGER_DIR
  fi

  docker-compose up -d
}

function stop() {
  if ! is_running; then
    echo "Not Running."
    return
  fi

  docker-compose down
}

if ! command -v docker-compose &> /dev/null; then
  echo "Error: docker-compose could not be found!"
  exit =1
fi

[ "$1" ] || (printHelp && exit 0)

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    start)
      start
      shift
      ;;
    stop)
      stop
      shift
      ;;
    restart | reload)
      stop
      start
      shift
      ;;
    help)
      printHelp
      exit 0
      ;;
    *)
      printHelp
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done
set -- "${POSITIONAL[@]}"
