# deploy.ps1 - OldShop WAR 배포 스크립트 (Tomcat 8.5 외부)
$ErrorActionPreference = "Stop"

# ====== 사용자 환경에 맞춘 경로 ======
$projectRoot = "C:\Joo_old\Joo_BookShop"
$buildScript = Join-Path $projectRoot "build.ps1"

$tomcatHome  = "C:\Program Files\apache-tomcat-8.5.95"
$webapps     = Join-Path $tomcatHome "webapps"
$bin         = Join-Path $tomcatHome "bin"

# 배포할 컨텍스트: ROOT로 고정 (http://localhost:8080/)
$destWar      = Join-Path $webapps "ROOT.war"
$destExploded = Join-Path $webapps "ROOT"

# ====== 사전 체크 ======
if (!(Test-Path $buildScript)) { throw "build.ps1 not found: $buildScript" }
if (!(Test-Path $tomcatHome))  { throw "Tomcat not found: $tomcatHome" }
if (!(Test-Path (Join-Path $bin "startup.bat")))  { throw "startup.bat not found in: $bin" }
if (!(Test-Path (Join-Path $bin "shutdown.bat"))) { throw "shutdown.bat not found in: $bin" }

Write-Host "== 1) Build WAR =="
Push-Location $projectRoot
& $buildScript
Pop-Location

# ====== WAR 자동 탐지: target 폴더에서 가장 최신 war 선택 ======
$targetDir = Join-Path $projectRoot "target"
$targetWar = Get-ChildItem -Path $targetDir -Filter "*.war" |
             Sort-Object LastWriteTime -Descending |
             Select-Object -First 1

if ($null -eq $targetWar) { throw "WAR not found in: $targetDir" }

Write-Host "WAR selected: $($targetWar.FullName)"

Write-Host "== 2) Stop Tomcat (best-effort) =="
# 이미 안 떠있어도 괜찮게 처리
try {
  & (Join-Path $bin "shutdown.bat") | Out-Null
  Start-Sleep -Seconds 2
} catch {}

Write-Host "== 3) Clean old ROOT (optional) =="
# exploded ROOT 폴더가 남아있으면 리소스 꼬일 수 있어 삭제
if (Test-Path $destExploded) {
  Remove-Item $destExploded -Recurse -Force
}

Write-Host "== 4) Copy WAR to Tomcat webapps as ROOT.war =="
Copy-Item $targetWar.FullName $destWar -Force

Write-Host "== 5) Start Tomcat =="
& (Join-Path $bin "startup.bat") | Out-Null

Write-Host ""
Write-Host "✅ Deploy done!"
Write-Host " - WAR: $destWar"
Write-Host " - URL: http://localhost:8080/"
