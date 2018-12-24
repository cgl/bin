git co dev
git pull
git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
python manage.py migrate
