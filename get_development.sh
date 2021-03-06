git checkout development
git fetch

new_requirements=false
for filename in `git diff --name-only origin/development`; do [[ $filename =~ requirements/.*.txt ]] && new_requirements=true ; done

git pull
if $new_requirements ; then
    pip install -r requirements.txt
fi
git branch --merged | egrep -v "(^\*|master|development)" | xargs git branch -d
python manage.py migrate
