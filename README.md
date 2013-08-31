# GrowControl


## Requirements
```
sudo apt-get install sqlite3
sudo apt-get install sendmail
sudo apt-get install linux-libc-dev libswscale-dev libboost-dev libxv-dev
sudo apt-get install imagemagick ghostscript libmagickwand-dev
```

## Starting the webapp
```bundle exec unicorn -c /srv/growcontrol/unicorn.rb -E production -D```
