# Heroku provides the environment of configs as a set of files under an env dir, where
# the filename is the key and the file contents are the value
# See: https://devcenter.heroku.com/articles/buildpack-api#bin-compile
#
# The below exports the configs and sets the environment

export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-''}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}
  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export "$e=$(cat $env_dir/$e)"
      :
    done
  fi
}
