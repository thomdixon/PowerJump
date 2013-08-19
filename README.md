PowerJump
=========

PowerJump is a simple module to help with navigating your filesystem in
PowerShell, inspired by [Jeroen Janssens' blog
post](http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html)
which provides details on obtaining the same
functionality in zsh and bash.

Installation
------------

In order to install, simply clone the repository into a directory listed as
part of the `PSModulePath` environment variable, and then import the module in
your profile. For example, to install as your user,

    > cd "C:\Users\$env:username\Documents\WindowsPowerShell\Modules\"
    > git clone https://github.com/thomdixon/PowerJump.git

then add

    import-module powerjump

to your PowerShell profile. If you're unfamiliar with PowerShell profiles,
check out:

    > help about_profile

How It Works
------------

A `thomdixon\PowerJump` folder is created in the current user's AppData
directory. Shortcuts are stored here when marked, and their targets are
resolved upon jump. That's all there is to it.

Usage
-----
Usage is fairly straightforward.

    PS C:\Users\thom> mark home
    PS C:\Users\thom> cd Documents\Foo
    PS C:\Users\thom\Documents\Foo> jump home
    PS C:\Users\thom> marks

    Mark                                                     Target
    ----                                                     ------
    home                                                     C:\Users\thom

    PS C:\Users\thom>unmark home
    Confirm
    Are you sure you want to perform this action?
    Performing operation "Remove File" on Target "C:\Users\thom\AppData\Roaming\thomdixon\PowerJump\home.lnk".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
    PS C:\Users\thom>
