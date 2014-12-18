# Dizzy

Dizyy is responsible for the Frontend suff. From package creation to package installation, Dizzy is responsible for the whole lifecycle of the integration of the Frontend assets.

The base idea is that, for each of Version of the Frontend assets, a NuGet package is generated, which is then used in a further build step and locally to develop the application.

## Use in my project

The first step of integrating Dizzy in a project is to create a Teamcity build configuration with the template *frontend-nuget*. Configure the url of the frontend repository and the name of the NuGet package.

Then install the **Unic.Bob.Dizzy **package in your Website project:
<div class="code panel pdl" style="border-width: 1px;"><div class="codeContent panelContent pdl">
<script type="syntaxhighlighter" class="theme: Eclipse; brush: powershell; gutter: false"><![CDATA[Install-Package Unic.Bob.Dizzy]]></script>
</div></div>

After Dizzy is installed you can just execute *Install-Frontend* to install the newest version of the Frontend in the Web-Root
<div class="code panel pdl" style="border-width: 1px;"><div class="codeContent panelContent pdl">
<script type="syntaxhighlighter" class="theme: Eclipse; brush: powershell; gutter: false"><![CDATA[Install-Frontend]]></script>
</div></div>

┬á

Which version will be installed depends on, which branch you sit:

*   develop: Newest with *-develop*
*   release/\* or hotfix/\*: Newest with *-release*
*   feature/\*: Newest with *-develop*

┬á

Optionally a parameter can be added to *Install-Package* which specifies the prerelease tag to use. This is escpecially if you want to install assets from a frontend feature-branch.

	Install-Frontend MySuperFeature


## What Frontender must note?

Hand out the [Frontender cheat sheet](Cheatsheet.md) to them.

## Workflow

![Workflow](assets/Frontend.png)

Raw file: [Frontend.xml](assets/Frontend.xml)
Edit with: [https://www.draw.io/](https://www.draw.io/)

Each build of the Frontend must be pushed back to a build-* branch. On Teamcity there is a build configuration *Frontend* with a build trigger for the build-* branches.

The *Frontend* build configuration creates a NuGet package containing the assets. If the build was pushed to build-develop or build-release the *Build* build configuration will be triggered. The *Build* configuration creates a *.Website NuGet package which contains out code and the Frontend assets.

## Versioning

The versioning of the Frontend package is done with the following scheme.

* build-release
	

	Major.Minor.Patch-release%build.counter.padded%

*  build-develop


	Major.Minor.Patch-beta%build.counter.padded%

* build-feature

	
	Major.Minor.Patch-FeatureBranchName%build.counter.padded%
