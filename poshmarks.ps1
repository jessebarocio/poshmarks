$marks = @{};
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$marksPath = "$scriptDir\poshmarks.csv"

if(test-path $marksPath){
    import-csv $marksPath | %{$marks[$_.key]=$_.value}
}

function s($number){
    $marks["$number"] = (pwd).path
    $marks.getenumerator() | export-csv $marksPath -notype
}

function g($number){
    cd $marks["$number"]
}

function p($number){
    $marks["$number"]
}

function d($number){
    $marks.remove("$number")
    $marks.getenumerator() | export-csv $marksPath -notype
}

function mdump{
    $marks.getenumerator() | export-csv $marksPath -notype
}

function l{
    $marks
}

function gpush($number) {
    pushd $marks["$number"]
}

function sln($number){
    g($number);
    gci *.sln | select -f 1 | ii
}
