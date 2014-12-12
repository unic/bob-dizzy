function Start-TeamcityBuild
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $BuildId,
        [Parameter(Mandatory=$true)]
        [string] $Url,
        [Parameter(Mandatory=$true)]
        [string] $User,
        [Parameter(Mandatory=$true)]
        [string] $Password,
        [Parameter(Mandatory=$true)]
        [string] $Branch,
    )
    Process
    {
        $post = @"
        <build branchName="$Branch">
            <buildType id="$BuildId"/>
        </build>
"@
        $url = "$url/httpAuth/app/rest/buildQueue"
        $authInfo = $user + ":" + $password
        $authInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::Default.GetBytes($authInfo))
        $request = [System.Net.WebRequest]::Create($url)

        $request.Headers["Authorization"] = "Basic " + $authInfo
        $request.Method = "POST"
        $request.ContentType = "application/xml"
        $Body = [byte[]][char[]]$post ;
        $Stream = $Request.GetRequestStream();
        $Stream.Write($Body, 0, $Body.Length);
        $request.GetResponse()
    }
}
