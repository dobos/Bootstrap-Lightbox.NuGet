echo "Downloading packages..."

$version = "v5.1.1"
$package = "bootstrap-lightbox-$version"

if (-not (Test-Path "nuget.exe")) {
	wget -OutFile "nuget.exe" "https://dist.nuget.org/win-x86-commandline/v3.3.0/nuget.exe"
}
if (-not (Test-Path "$package.zip")) {
	wget -OutFile "$package.zip" "https://github.com/ashleydw/lightbox/archive/$version.zip"
}

echo Uncompressing package

& 'C:\Program Files\7-Zip\7z.exe' x -y "$package.zip"

echo Building NuGet package...

if (-not (Test-Path pkg)) {
	mkdir pkg\lib
	mkdir pkg\tools
	mkdir pkg\content
	mkdir pkg\content\Scripts
	mkdir pkg\content\Scripts\Bootstrap-Lightbox
}

cp -Recurse -Force "lightbox-5.1.1\dist\*" "pkg\content\Scripts\Bootstrap-Lightbox"

.\nuget.exe pack pkg\Bootstrap-Lightbox.NuGet.nuspec

