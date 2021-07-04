#!bin/sh

echo "Deployment Started"

git config --global user.email $EMAIL
git config --global user.name $USERNAME
git remote set-url origin https://$DEPLOY_TOKEN@github.com/Coders-Asylum/coders-asylum.github.io.git
git fetch --all

# Get the current branch
BRANCH=$(git symbolic-ref --short -q HEAD)
echo "$BRANCH"
# no of times the loop has to run in case of error
CHECK=3
# loop

while [ "$CHECK" -gt 0 ]
do
    if [ "$BRANCH" = "production" ]
    then
        # check if changes are present in the current working branch
        if ! git --git-dir="./.git" diff --quiet
        then
            #  ADD AND COMMIT AS
            git add --all
            git commit --all -m "Committed during   $(date) build"
        fi

        # switch to the live branch
        git switch live
        # copy the latest build
        git checkout production build/web

        # store the current branch to check if branch changed to live
        BRANCH=$(git symbolic-ref --short -q HEAD)

        if [ "$BRANCH" = "live" ]
        then
            # doing a commit
            git add --all
            git commit --all -m 'New build transfered from prodction branch'


            # deletes all the file expect ./buid/web/ and .git/ folder files.
            # this deletes all the previous build files
            find . -mindepth 1 ! -regex '^./.git\(/.*\)?\|^./build\(/.*\)?' -delete
            # copies the new build from ./build/web to current folder
            cp -a ./build/web/. .

            # deletes the build folder
            rm -r ./build/

            # check if changes are present in the current working branch
            if ! git --git-dir="./.git" diff --quiet
            then
                git add --all
                git commit --all -m "New Build: Built on-$(date)"
            fi

            CHECK=0

            echo  "Deployed to Live"
        else
            echo "Branch not changed" 1>&2
            exit 1
        fi

    else
        git switch production
        git pull origin
    fi
    CHECK=`expr $CHECK - 1`
done