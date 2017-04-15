web: bundle exec puma config.ru -p ${APP_PORT:-3000} -e ${RACK_ENV:-development}
actioncable: bundle exec puma cable/config.ru -p ${WS_PORT:-28080} -e ${RACK_ENV:-development}
log: touch log/${RACK_ENV:-development}.log && tail -f log/${RACK_ENV:-development}.log
worker: bundle exec sidekiq
redis: redis-server
