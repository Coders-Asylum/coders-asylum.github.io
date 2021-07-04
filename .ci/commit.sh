#!bin/sh

echo "Checking for changes"
git remote set-url origin https://$DEPLOY_TOKEN@github.com/Coders-Asylum/coders-asylum.github.io.git
git fetch --all
git config --global user.email $EMAIL
git config --global user.name $USERNAME
git pull origin
# check if changes are present in the current working branch
if ! git --git-dir="./.git" diff --quiet
then
  git add --all
  git commit --all -m "Formatting Changes done on $(date)"
  git push origin
  echo "Changes have been committed and pushed to origin"
fi