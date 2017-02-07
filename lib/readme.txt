The lib directory contains files DLLs which cannot be referenced directly with Paket.

# LibGit2Sharp
LibGit2Sharp.NativeBinaries has some MSBuild targets to copy the native libraries to the correct folders. 
Because we don't use MSBuild here, we needed to this manualy.
Therefore we copied this files to the lib\LibGit2Sharp folder:
- all files from .\packages\LibGit2Sharp\lib\net40 
- all files from .\packages\LibGit2Sharp.NativeLibraries\libgit2sharp
- .\packages\LibGit2Sharp.NativeBinaries\runtimes\win7-x64\native\* to lib\LibGit2Sharp\lib\win32\x64
- .\packages\LibGit2Sharp.NativeBinaries\runtimes\win7-x86\native\* to lib\LibGit2Sharp\lib\win32\x86
