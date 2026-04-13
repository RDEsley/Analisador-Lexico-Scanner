# Apenas executa o scanner em todos os exemplos (exige scanner/Scanner.class).
$here = Split-Path $PSScriptRoot
& (Join-Path $here "scripts\build.ps1") -SkipGeneration
