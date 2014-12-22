Dear Frontender,

My name is Dizzy and I am part of the Bob the builder crew. I am responsible for integrating your frontend assets into Sitecore solutions. In order to work smoothly together, we have to agree on some rules:

0. Name the release and hotfix branches exactly after this scheme: release/Major.Minor.Patch or hotfix/Major.Minor.Patch. Do not prefix the version number with something like _v_ or _release_:
```
    Good:
    release/0.3
    release/0.7.0
    hotfix/0.5.1

    Bad:
    release/v0.3
    hotfix/hotfix-0.5.1
```
0. Make sure the frontend build pushes also assets from feature branches to build-feature
0. Make sure build.sh adds the branch name to the generated metadata.json, like in the [Gulp-Boilderplate](https://git.unic.com/projects/BUDC/repos/copfe---gulp-boilerplate/browse/jenkins/build.sh?until=de447cc3540503a83f7eae369ffe67294dc12e2e#149)
0. Make sure build.sh pushes the `metadata.json` to all `build-*` branches

Regards,<br>
Dizzy
