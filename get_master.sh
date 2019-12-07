git co master
git pull
git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
pip install -r requirements.txt
python manage.py migrate
