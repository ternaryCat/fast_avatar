# Fast Avatar
Simple Telegram Bot for avatars generating without any frameworks

## Example
send `/generate` and you should get avatar like this

![example](https://github.com/ternaryCat/fast_avatar/blob/master/example.png?raw=true)

## Dependencies
### Libs
`build-essential libpq-dev librsvg2-bin`

### ENV Variables
```
RACK_ENV=production

POSTGRES_DB=fast_avatar
POSTGRES_HOST=postgresql
POSTGRES_PORT=5432
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

TELEGRAM_TOKEN=1835305562:AAEPOhbAMn8wRn17zrv7rrSbqXXXXXXXXXX
```

## Launching

use `bin/long_polling` or `docker-compose up`
