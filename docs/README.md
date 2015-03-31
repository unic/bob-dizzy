<div class="chapterlogo">![Dizzy](Dizzy.jpg)</div>
# Dizzy

Dizzy is responsible for the frontend suff. From package creation to package installation, Dizzy is responsible for the whole lifecycle of the integration of the frontend assets.

The base idea is that, for each version of the frontend assets, a NuGet package is generated, which is then used in a further build step and locally to develop the application.


## How To Use Dizzy in a Sitecore Solution

The first step of integrating Dizzy in a project is to create a Teamcity build configuration with the template *frontend-nuget*. Configure the url of the frontend repository and the name of the NuGet package.

Then install the **Unic.Bob.Dizzy** package in your Website project:

    PM>Install-Package Unic.Bob.Dizzy

After Dizzy is installed you can simply execute `Install-Frontend` to install the newest version of the frontend in the Web-Root

    PM>Install-Frontend

Which frontend version will be installed depends on, which branch you're currenty working on:

* develop: Newest with *-develop*
* release/\* or hotfix/\*: Newest with *-release*
* feature/\*: Newest with *-develop*

Optionally a parameter can be added to *Install-Package* which specifies the prerelease tag to use. This is escpecially useful if you want to install assets from a frontend feature-branch.

	Install-Frontend MySuperFeature


## Guidelines for Frontend Engineers

Hand out the [Frontender cheat sheet](Cheatsheet.md) to frondend engineers on your project.

## Workflow

![Workflow](assets/Frontend.png)<br>
Raw file: [Frontend.xml](assets/Frontend.xml),
Edit with: [https://www.draw.io/](https://www.draw.io/)

Each build of the frontend must be pushed back to a build-\* branch. On Teamcity there is a build configuration *Frontend* with a build trigger for the build-\* branches.

The *Frontend* build configuration creates a NuGet package containing the assets. If the build was pushed to build-develop or build-release the *Build* build configuration will be triggered. The *Build* configuration creates a \*.Website NuGet package which contains our code and the frontend assets.

## Versioning

The versioning of the frontend package is done with the following scheme.
* build-release
```
    Major.Minor.Patch-release%build.counter.padded%
```
*  build-develop
```
    Major.Minor.Patch-beta%build.counter.padded%
```
* build-feature
```
    Major.Minor.Patch-FeatureBranchName%build.counter.padded%
```
