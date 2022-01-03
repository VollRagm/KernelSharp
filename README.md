# KernelSharp
This is an example of how to use [NativeAOT](https://github.com/dotnet/runtimelab/tree/feature/NativeAOT) to compile C# code to a Windows Kernel Mode driver.
This repository contains parts of https://github.com/ZeroLP/ZeroKernel.

If you want to see an example of a full memory R/W Driver using this, check out my repo https://github.com/VollRagm/KernelBypassSharp. 

# Compiling
Open the build.bat and fix the file paths.
ILCPATH is located at `C:\Users\username\.nuget\packages\runtime.win-x64.microsoft.dotnet.ilcompiler\7.0.0-alpha.1.21430.2\tools`, ntoskrnl.lib is located in the WDK install path.
Run `x64 Native Tools Command Prompt for VS 2019`, cd into the project directory and run build.bat.
You can load the driver or map it with kdmapper.

# Creating a project
Follow the [Quick start guide](https://github.com/dotnet/runtimelab/blob/feature/NativeAOT/docs/using-nativeaot/compiling.md) to create a new native project. After that simply edit the project file itself and add all properties from the project in this repository.
After including WDK.cs and the Runtime folder in your project you will be able to compile it.

##  Features

 - Call any kernel export
 - Convert C# strings to multibyte characters
 - Reading cr3

## Limitations

 - No support for variadic arguments
 - No managed multibyte character string type, conversion is required
 - The native compiler misplaces globally declared strings wrongly, causing a bluescreen when referenced
