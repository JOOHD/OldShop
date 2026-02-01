# build.ps1 - OldShop 전용 빌드 스크립트 (Java 8 강제)
$ErrorActionPreference = "Stop"

$jdk8 = "C:\Program Files\Java\jdk-1.8"
$mvn  = "C:\Users\user\apache-maven-3.9.12\bin\mvn.cmd"

if (!(Test-Path $jdk8)) { throw "JDK8 not found: $jdk8" }
if (!(Test-Path $mvn))  { throw "Maven not found: $mvn" }

$env:JAVA_HOME = $jdk8
$env:Path = "$env:JAVA_HOME\bin;$env:Path"

Write-Host "JAVA_HOME=$env:JAVA_HOME"
java -version
& $mvn -v

# 레거시 이관 단계: 테스트는 일단 스킵
& $mvn -DskipTests clean package
