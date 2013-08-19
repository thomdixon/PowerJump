$env:markpath = (join-path $env:appdata "thomdixon\PowerJump")
$ErrorActionPreference = "Stop"

function Create-Shortcut([string]$source, [string]$dest) {
    $wsh = new-object -comObject WScript.Shell
    $sc = $wsh.CreateShortcut($dest)
    $sc.TargetPath = $source
    $sc.Save()
}

function Get-ShortcutTarget([string]$source) {
    $wsh = new-object -comObject WScript.Shell
    return $wsh.CreateShortcut($source).TargetPath
}

function Mark([string]$name) {
    if ([string]::IsNullOrEmpty($name.Trim())) {
        throw "Invalid mark name"
    }
    
    mkdir -p $env:markpath -force | out-null
    create-shortcut $(get-location) (join-path $env:markpath ($name + ".lnk"))
}

function Jump([string]$name) {
    $path = join-path $env:markpath ($name + ".lnk")
    if (!(test-path $path)) {
        throw "No such mark: $name"
    }

    pushd get-shortcuttarget $path
}

function Unmark([string]$name) {
    rm -confirm (join-path $env:markpath ($name + ".lnk"))
}

function Marks {
    get-childitem $env:markpath | foreach-object {
        return new-object psobject -property @{ 
            Mark = $_.BaseName
            Target = get-shortcuttarget($_.FullName)
        }
    } | format-table -property Mark,Target
}

@("Mark", "Unmark", "Marks", "Jump") | foreach-object {
    export-modulemember -function $_
}