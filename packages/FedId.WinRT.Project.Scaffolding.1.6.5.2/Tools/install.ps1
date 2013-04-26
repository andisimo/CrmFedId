param($installPath, $toolsPath, $package, $project) 

# debug and test script using set-executionpolicy -executionpolicy remotesigned -scope process & .\install.ps1 . . package.nupkg project
# debug and test project dte object model calls from pm console using $project = get-project <project name>

if ($host.Version.Major -eq 2 -and $host.Version.Minor -lt 0) 
{
	"NOTICE: This package only works with NuGet 2.0 or above. Please update your NuGet install at http://nuget.codeplex.com. Sorry, but you're now in a weird state. Please 'uninstall-package FedIdWinRTProjectScaffolding' now."
}
else
{    
    # TODO: add assembly references that are not part of framework or project build output
	
    # this is no good cause VisualStudioDir environment variable doesn't exist with current generation installs
    # $vsCodeSnippets = ([System.Environment]::ExpandEnvironmentVariables("%VisualStudioDir%\Code Snippets\Visual C#\My Code Snippets"))
    # $vsCodeSnippets = "$env:visualstudiodir\Code Snippets\Visual C#\My Code Snippets"

    <# $vsVersions = @("11.0", "10.0")
    foreach ($vsVersion in $vsVersions)
    {
        $hkcuSwMsftVsVer = "HKCU:\Software\Microsoft\VisualStudio\" + $vsVersion
        if (test-path $hkcuSwMsftVsVer)
        {
            # get-childitem $hkcuSwMsftVsVer | foreach-object { get-itemproperty $_.pspath }

            $vsRegKey = get-itemproperty $hkcuSwMsftVsVer VisualStudioLocation -erroraction silentlycontinue -errorvariable e
            if ($e) { 
				$e[0].Exception.Message + "..no copying of code snippets will be carried out for vstudio version " + $vsVersion
				# break
			} else { 
				$vsCodeSnippets = $vsRegKey.VisualStudioLocation + "\Code Snippets\Visual C#\My Code Snippets"
				$vsCodeSnippetsJs = $vsRegKey.VisualStudioLocation + "\Code Snippets\JavaScript\My Code Snippets"
				if (test-path $vsCodeSnippets) { write-host "copying code snippets to " $vsCodeSnippets; copy-item $toolsPath\FwrtpsNupkg.snippet -destination $vsCodeSnippets -force }
				if (test-path $vsCodeSnippetsJs) { write-host "copying code snippets to " $vsCodeSnippetsJs; copy-item $toolsPath\FwrtpsNupkgJs.snippet -destination $vsCodeSnippetsJs -force }
			}
        }
    } #>

# nuget22 added netcore45[/windows8/win8]-javascript and netcore45-managed project type targeting support doing away with need for following
# updates, for more info see http://nuget.codeplex.com/discussions/398222 and http://nuget.codeplex.com/discussions/401319
    switch ($project.Type) {
        "C#" {
            $securityFolderProjectItem = $project.ProjectItems.Item("security")
            $securityFolderProjectItem.ProjectItems.Item("idpCredentialsFlyout.css").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpCredentialsFlyout.html").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpCredentialsFlyout.js").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpSelectionFlyout.css").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpSelectionFlyout.html").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpSelectionFlyout.js").Delete()
            # $project.Object.References.Add("path to dll")   
            # $someReference = $project.Object.References.Item("SomeAssembly");  if ($someReference) $someReference.Delete()
            install-package callisto -source https://nuget.org/api/v2/ -version 1.2.6 -projectname $project.Name
        }
        "JavaScript" {
            # $jsFolderProjectItem = $project.ProjectItems.Item("js")
            # $jsFolderProjectItem.ProjectItems.AddFromFileCopy("path to js file")
            $securityFolderProjectItem = $project.ProjectItems.Item("security")
            $securityFolderProjectItem.ProjectItems.Item("idpCredentialsFlyout.xaml").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpCredentialsFlyout.xaml.cs").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpSelectionFlyout.xaml").Delete()
            $securityFolderProjectItem.ProjectItems.Item("idpSelectionFlyout.xaml.cs").Delete()
            # $project.Object.References.Add("path to dll")   
            # $someReference = $project.Object.References.Item("SomeAssembly");  if ($someReference) $someReference.Delete()
            install-package linq.js -source https://nuget.org/api/v2/ -version 2.2.0.2 -projectname $project.Name
        }
    }

    <# $moniker = $project.Properties.Item("TargetFrameworkMoniker").Value
    $framework = New-Object System.Runtime.Versioning.FrameworkName -ArgumentList $moniker
    switch ($framework.Identifier)
    {
        ".NETCore" {
        }
        ".NETFramework" {
        }
    } #>
    
	# $path = [System.IO.Path] 
	# $readme = $path::Combine($path::GetDirectoryName($project.FileName), "..\packages\FedId.WinRT.Project.Scaffolding.1.5.0.#\ReadMe.html")
	$readme = "https://mysawestus.blob.core.windows.net/public/FedId.WinRT.Project.Scaffolding.html"
	$DTE.ItemOperations.Navigate($readme, [EnvDTE.vsNavigateOptions]::vsNavigateOptionsNewWindow) 
}
