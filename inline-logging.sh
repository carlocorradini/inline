#!/usr/bin/env bash
## As noted: A complete and blatant RIP-OFF  from https://github.com/carlocorradini/inline/blob/main/inline.sh
#
## Perpetrated by rick.landon@panasonic.aero.
## Prefix ISO8601 Local timestamp + ms to each log message.
## Allow external setting of logging level
## Add capabilities necessary to setup logging blocks.
##
#
## Perpetrated by rick.landon@panasonic.aero.

# ================
# LOGGER
# ================
# Fatal log level. Cause exit failure
LOG_LEVEL_FATAL=100
# Warning log level
LOG_LEVEL_WARN=200
# Informational log level
LOG_LEVEL_INFO=300
# Debug log level
LOG_LEVEL_DEBUG=400
# Silent log level
LOG_LEVEL_SILENT=500
# Log level
LOG_LEVEL=$LOG_LEVEL_WARN
# Log color flag
LOG_COLOR_ENABLE=true

set_logging_level() {
  local logging_level=$1
  INFO "Set logging level:[$logging_level]"
  LOG_LEVEL=${logging_level}
}
is_logging_level() {
  logging_level=$1
  if [[ $LOG_LEVEL -ge  $logging_level ]]; then
    true
  else
    false
  fi
}
is_FATAL() { 
  is_logging_level $LOG_LEVEL_FATAL 
}
is_WARN() { 
  is_logging_level $LOG_LEVEL_WARN 
}
is_INFO() { 
  is_logging_level $LOG_LEVEL_INFO 
}
is_DEBUG() { 
  is_logging_level $LOG_LEVEL_DEBUG 
}


# Convert log level to equivalent name
# @param $1 Log level
to_log_level_name() {
  _log_level=${1:-LOG_LEVEL}
  _log_level_name=

  case $_log_level in
    "$LOG_LEVEL_FATAL") _log_level_name=fatal ;;
    "$LOG_LEVEL_WARN") _log_level_name=warn ;;
    "$LOG_LEVEL_INFO") _log_level_name=info ;;
    "$LOG_LEVEL_DEBUG") _log_level_name=debug ;;
    "$LOG_LEVEL_SILENT") _log_level_name=silent ;;
    *) FATAL "Unknown log level '$_log_level'" ;;
  esac

  printf "%s\n" "$_log_level_name"
}

# Print log message
# @param $1 Log level
# @param $2 Message
_log_print_message() {
  _log_level=${1:-LOG_LEVEL_FATAL}
  shift
  _log_level_name=
  _log_message=${*:-}
  _log_prefix=
  _log_suffix="\033[0m"

  # Check log level
  if [ "$LOG_LEVEL" -eq "$LOG_LEVEL_SILENT" ] || [ "$_log_level" -gt "$LOG_LEVEL" ]; then
    return 0
  fi

  case $_log_level in
    "$LOG_LEVEL_FATAL")
      _log_level_name=FATAL
      _log_prefix="\033[41;37m"
      ;;
    "$LOG_LEVEL_WARN")
      _log_level_name=WARN
      _log_prefix="\033[1;33m"
      ;;
    "$LOG_LEVEL_INFO")
      _log_level_name=INFO
      _log_prefix="\033[37m"
      ;;
    "$LOG_LEVEL_DEBUG")
      _log_level_name=DEBUG
      _log_prefix="\033[1;34m"
      ;;
  esac

  # Check color flag
  if [ "$LOG_COLOR_ENABLE" = false ]; then
    _log_prefix=
    _log_suffix=
  fi

  # Log
  # Includes ISO8601 time stamp (local with ms; add --utc flag if you're into UTC)
  printf '%b[{%s}:%b[%-5s] %b%b\n' "$_log_prefix" "$(date +%FT%T.%3NZ)" "$_log_prefix" "$_log_level_name" "$_log_message" "$_log_suffix"
}

# Fatal log message
# @param $1 Message
FATAL() {
  _log_print_message "$LOG_LEVEL_FATAL" "$1" >&2
  exit 1
}
# Warning log message
# @param $1 Message
WARN() { _log_print_message "$LOG_LEVEL_WARN" "$1" >&2; }
# Informational log message
# @param $1 Message
INFO() { _log_print_message "$LOG_LEVEL_INFO" "$1" >&2; }
# Debug log message
# @param $1 Message
DEBUG() { _log_print_message "$LOG_LEVEL_DEBUG" "$1" >&2; }

## Main
## This script is a complete RIP-OFF  from somewhere ELSE
## Starting to add some basic testing, but it needs to be commented/uncommented for now.

#LOG_LEVEL=$LOG_LEVEL_INFO
# INFO  "Complete and blatant RIP-OFF from [https://github.com/carlocorradini/inline/blob/main/inline.sh]"
# WARN  "Complete and blatant RIP-OFF from [https://github.com/carlocorradini/inline/blob/main/inline.sh]"
# DEBUG "Complete and blatant RIP-OFF from [https://github.com/carlocorradini/inline/blob/main/inline.sh]"
# FATAL "Complete and blatant RIP-OFF from [https://github.com/carlocorradini/inline/blob/main/inline.sh]"

## is_logging_level $LOG_LEVEL; logging=$?
## INFO  "Logging level:[$LOG_LEVEL] is [$logging]"

## if  is_INFO; then 
##    INFO "Logging INFO"
## fi   
## if is_WARN; then 
##    WARN "Logging WARN"
## fi   
## if is_DEBUG; then 
##    DEBUG "Logging DEBUG"
## fi   
