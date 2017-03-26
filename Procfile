web: bundle exec puma config.ru ${APP_PORT:-5000} -e ${RACK_ENV:-development}
actioncable: bundle exec puma cable/config.ru -p ${WS_PORT:-28080} -e ${RACK_ENV:-development}
log: tail -f log/${RACK_ENV:-development}.log
worker: bundle exec sidekiq
redis: redis-server
