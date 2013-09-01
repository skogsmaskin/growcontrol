# GrowControl

## Requirements

```
sudo apt-get install sqlite3

sudo apt-get install sendmail

sudo apt-get install linux-libc-dev libswscale-dev libboost-dev libxv-dev v4l-utils

sudo apt-get install imagemagick ghostscript libmagickwand-dev

```

## Installing

```bundle install```

## Starting the webapp

```bundle exec unicorn -c /srv/growcontrol/unicorn.rb -E development -D```

## Links

* http://sleekd.com/general/configuring-nginx-and-unicorn/
* http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn
