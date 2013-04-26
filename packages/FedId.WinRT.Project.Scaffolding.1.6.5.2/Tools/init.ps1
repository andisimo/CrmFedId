param($installPath, $toolsPath, $package, $project) 

# debug and test script using set-executionpolicy -executionpolicy remotesigned -scope process & .\init.ps1 . . package.nupkg project
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

    $vsVersions = @("11.0", "10.0")
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
    }
}
