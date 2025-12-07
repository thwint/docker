#!/bin/sh

# logging
log() {
  severity="${1}"
  shift
  printf '%s %s %s: %s\n' "$(date '+%a %d %T')" "${severity}" "${0}" "$*"
}

log_info() {
  log INFO "${@}"
}

log_warn() {
  log WARN "${@}" >&2
}

log_error() {
  log ERROR "${@}" >&2
  exit 1
}

# Translate PDNS_ environment variables into config options usable by powerdns.
#
# Variables beginning with PDNS_ and not ending with _FILE are converted into
# lower case configuration options.
#
load_env_vars() {
  env | while IFS='=' read -r envvar_key envvar_value; do
    # We only add environment variables beginning with PDNS and not ending with
    # _FILE
    if [ "${envvar_key}" != "${envvar_key#PDNS_}" ] && [ "${envvar_key}" = "${envvar_key%_FILE}" ]; then
      config_key=$(expr "${envvar_key}" : 'PDNS_\([A-Za-z_=]\+\)' | tr '[:upper:]_' '[:lower:]-')
      write_to_pdns_conf "${config_key}" "${envvar_value}"
    fi
  done
}

# Write given config options to /etc/pdns/pdns.comf
#
write_to_pdns_conf() {
  var_name=${1}
  value=${2}
  echo "${var_name}"="${value}" >>/etc/pdns/pdns.conf
}

# Read the content of the file defined in given variable and convert it into a
# config option for powerdns.
#
secret_file() {
  env_var="$1"
  env_var_val=$(eval echo "\$${env_var}")
  file_var="${env_var}_FILE"
  file_var_val=$(eval echo "\$${file_var}")
  if [ -n "${file_var_val}" ] && [ -n "${env_var_val}" ]; then
    log_error "${env_var} and ${file_var} must not be set simultaneously"
  fi

  if [ -n "$file_var_val" ]; then
    config_key=$(expr "${file_var}" : 'PDNS_\([A-Za-z_=]\+\)_FILE' | tr '[:upper:]_' '[:lower:]-')
    write_to_pdns_conf "${config_key}" "$(cat "${file_var_val}")"
  fi
}

# SQL file to initialize DB schema
DB_INIT_SCHEMA=/etc/pdns/sql/init_${PDNS_LAUNCH}.sql

waitAndInitMySql() {
  if [ -n "${PDNS_GMYSQL_PASSWORD_FILE}" ]; then
    MYSQL_PASSWORD=$(cat "${PDNS_GMYSQL_PASSWORD_FILE}")
  else
    MYSQL_PASSWORD=${PDNS_GMYSQL_PASSWORD}
  fi
  while ! mysqladmin ping --host="${PDNS_GMYSQL_HOST}" --user="${PDNS_GMYSQL_USER}" --port="${PDNS_GMYSQL_PORT}" --password="${MYSQL_PASSWORD}" --silent; do
    log_info "Waiting for MySQL/MariaDB to be ready"
    sleep 1
  done

  log_info "Database is ready continue starup"

  DB_CMD="mysql --host=${PDNS_GMYSQL_HOST} --user=${PDNS_GMYSQL_USER} --port=${PDNS_GMYSQL_PORT} --password=${MYSQL_PASSWORD} --silent"

  if [ "$(echo "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = \"${PDNS_GMYSQL_DBNAME}\";" | ${DB_CMD})" -le 1 ]; then
    log_info "Database is empty. Initializing database ..."
    ${DB_CMD} -r -N -w "${PDNS_GMYSQL_DBNAME}" <"${DB_INIT_SCHEMA}"
  fi
}

waitAndInitPSql() {
  log_error not yet implemented
}

initSqlite3() {
  log_error not yet implemented
}

# Write secrets into pdns.conf
secret_file 'PDNS_WEBSERVER_PASSWORD'
secret_file 'PDNS_GMYSQL_PASSWORD'
secret_file 'PDNS_API_KEY'
# Load environment variables into pdns.conf
load_env_vars

case ${PDNS_LAUNCH} in
"gmysql")
  waitAndInitMySql
  ;;
"gpgsql")
  waitAndInitPSql
  ;;
"gsqlite3")
  initSqlite3
  ;;
*)
  log_warn "Unknown DB type (${PDNS_LAUNCH}) used! Skipping autoconfig"
  ;;
esac

# traps to properly shutdown powerdns
trap "pdns_control quit" HUP INT TERM

# start pdns server
/usr/sbin/pdns_server
