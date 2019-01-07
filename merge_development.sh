git fetch

new_requirements=false
for filename in `git diff --name-only origin/development`; do [[ $filename =~ requirements/.*.txt ]] && new_requirements=true ; done

git merge origin/development

if $new_requirements ; then
    pip install -r requirements.txt
fi

python manage.py migrate
