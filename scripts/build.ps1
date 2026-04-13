# Gera Scanner.java (JFlex), compila e executa cada exemplos/<caso>/entrada.txt
# gravando output/<caso>/saida.txt (UTF-8, chcp 65001 no Windows).
param(
    [switch]$SkipGeneration
)

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot
Set-Location $Root

$Tools = Join-Path $Root "tools"
$ScannerDir = Join-Path $Root "scanner"
$JflexJar = Join-Path $Tools "jflex-1.9.1.jar"
$CupJar = Join-Path $Tools "java-cup-runtime-11b-20160615.jar"
$EcjJar = Join-Path $Tools "ecj-3.19.0.jar"

function Ensure-Tool {
    param([string]$Path, [string]$Url)
    if (-not (Test-Path $Path)) {
        Write-Host "Baixando $(Split-Path $Path -Leaf) ..."
        Invoke-WebRequest -Uri $Url -OutFile $Path -UseBasicParsing
    }
}

New-Item -ItemType Directory -Force -Path $Tools, (Join-Path $Root "output") | Out-Null

if (-not $SkipGeneration) {
    Ensure-Tool $JflexJar "https://repo1.maven.org/maven2/de/jflex/jflex/1.9.1/jflex-1.9.1.jar"
    Ensure-Tool $CupJar "https://repo1.maven.org/maven2/com/github/vbmacher/java-cup-runtime/11b-20160615/java-cup-runtime-11b-20160615.jar"
    Ensure-Tool $EcjJar "https://repo1.maven.org/maven2/org/eclipse/jdt/ecj/3.19.0/ecj-3.19.0.jar"

    Write-Host "JFlex: gerando Scanner.java ..."
    java -cp "$JflexJar;$CupJar" jflex.Main -d $ScannerDir (Join-Path $ScannerDir "Scanner.flex")

    $JavaFile = Join-Path $ScannerDir "Scanner.java"
    if (-not (Test-Path $JavaFile)) { throw "Scanner.java nao foi gerado." }

    Write-Host "Compilando Scanner.java ..."
    $javacExe = $null
    if ($env:JAVA_HOME) {
        $p = Join-Path $env:JAVA_HOME "bin\javac.exe"
        if (Test-Path $p) { $javacExe = $p }
    }
    if (-not $javacExe) {
        $jc = Get-Command javac -ErrorAction SilentlyContinue
        if ($jc) { $javacExe = $jc.Source }
    }
    if ($javacExe) {
        & $javacExe -encoding UTF-8 -d $ScannerDir $JavaFile
        if ($LASTEXITCODE -ne 0) { throw "javac falhou (codigo $LASTEXITCODE)." }
    }
    else {
        Write-Host "(javac nao encontrado; usando ECJ 3.19)"
        java -jar $EcjJar -1.8 -encoding UTF-8 -d $ScannerDir $JavaFile
        if ($LASTEXITCODE -ne 0) { throw "ECJ falhou (codigo $LASTEXITCODE)." }
    }
}
else {
    Write-Host "SkipGeneration: pulando JFlex e compilacao."
    if (-not (Test-Path (Join-Path $ScannerDir "Scanner.class"))) {
        throw "Scanner.class nao encontrado. Execute sem -SkipGeneration primeiro."
    }
}

$exemplosRoot = Join-Path $Root "exemplos"
$cases = Get-ChildItem -Path $exemplosRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name
if (-not $cases -or $cases.Count -eq 0) {
    throw "Nenhuma pasta de teste encontrada em exemplos\"
}

foreach ($case in $cases) {
    $entrada = Join-Path $case.FullName "entrada.txt"
    if (-not (Test-Path $entrada)) {
        Write-Host "AVISO: sem entrada.txt em $($case.Name) - ignorado."
        continue
    }
    $outDir = Join-Path (Join-Path $Root "output") $case.Name
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    $saida = Join-Path $outDir "saida.txt"
    Write-Host "Executando caso [$($case.Name)] -> output\$($case.Name)\saida.txt"
    # cmd.exe: usar & em vez de && (compativel com todas as versoes do PowerShell)
    $cmd = "chcp 65001>nul & set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 & java -cp `"$ScannerDir`" Scanner `"$entrada`" > `"$saida`""
    cmd /c $cmd
}

Write-Host ("Concluido. Casos: {0} pasta(s) em output (espelho de exemplos)." -f $cases.Count)
