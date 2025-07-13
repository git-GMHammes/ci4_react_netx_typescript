<#
.SYNOPSIS
    Script para testar tudo relacionado à instalação do PowerShell.

.DESCRIPTION
    Este script executa uma série de verificações para validar a instalação do PowerShell no sistema.
    Ele verifica a versão instalada, módulos essenciais, variáveis de ambiente, permissões de execução,
    integridade dos executáveis e conectividade de update.

.NOTAS
    Execute este script como administrador para melhores resultados.

.EXEMPLO
    .\Test-PowerShell-Installation.ps1
#>

Write-Host "===== Teste Completo da Instalação do PowerShell =====" -ForegroundColor Cyan

# 1. Verificar versão do PowerShell
Write-Host "`n1. Versão do PowerShell:"
$psVer = $PSVersionTable.PSVersion
if ($psVer) {
    Write-Host "Versão: $psVer" -ForegroundColor Green
} else {
    Write-Host "Não foi possível determinar a versão do PowerShell!" -ForegroundColor Red
}

# 2. Checar o local do executável
Write-Host "`n2. Caminho do executável:"
$pwshPath = (Get-Command pwsh -ErrorAction SilentlyContinue).Source
if ($pwshPath) {
    Write-Host "pwsh.exe localizado em: $pwshPath" -ForegroundColor Green
} else {
    Write-Host "pwsh.exe não encontrado no PATH!" -ForegroundColor Red
}

# 3. Verificar módulos essenciais
Write-Host "`n3. Módulos principais instalados:"
$modules = @('Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Security')
foreach ($module in $modules) {
    if (Get-Module -ListAvailable -Name $module) {
        Write-Host "${module}: OK" -ForegroundColor Green
    } else {
        Write-Host "${module}: NÃO INSTALADO" -ForegroundColor Red
    }
}

# 4. Testar execução de scripts (ExecutionPolicy)
Write-Host "`n4. Política de execução:"
$policy = Get-ExecutionPolicy
Write-Host "ExecutionPolicy: $policy"
if ($policy -eq 'Restricted') {
    Write-Host "Você não poderá executar scripts. Considere mudar para RemoteSigned ou Bypass." -ForegroundColor Yellow
}

# 5. Variável de ambiente PATH contendo PowerShell
Write-Host "`n5. PATH contém PowerShell:"
if ($env:PATH -match "PowerShell") {
    Write-Host "PowerShell está presente no PATH." -ForegroundColor Green
} else {
    Write-Host "PowerShell NÃO está no PATH!" -ForegroundColor Red
}

# 6. Testar integridade do executável
Write-Host "`n6. Integridade do executável (hash SHA256):"
if ($pwshPath) {
    $hash = Get-FileHash $pwshPath -Algorithm SHA256
    Write-Host "SHA256: $($hash.Hash)"
} else {
    Write-Host "Não foi possível calcular hash: Executável não encontrado." -ForegroundColor Red
}

# 7. Testar atualização do PowerShellGet (opcional)
Write-Host "`n7. Testando atualização do PowerShellGet:"
try {
    Install-Module -Name PowerShellGet -Force -Scope CurrentUser -ErrorAction Stop
    Write-Host "PowerShellGet atualizado com sucesso." -ForegroundColor Green
} catch {
    Write-Host "Erro ao atualizar PowerShellGet: $_" -ForegroundColor Yellow
}

# 8. Testar execução de comando básico
Write-Host "`n8. Testando execução de comando simples:"
try {
    $output = Get-Process | Select-Object -First 1
    Write-Host "Execução de comando: OK" -ForegroundColor Green
} catch {
    Write-Host "Erro na execução de comando básico!" -ForegroundColor Red
}

# 9. Verificar perfil do usuário
Write-Host "`n9. Verificando perfil do usuário:"
if (Test-Path $PROFILE) {
    Write-Host "Perfil existe em: $PROFILE" -ForegroundColor Green
} else {
    Write-Host "Perfil não encontrado: $PROFILE" -ForegroundColor Yellow
}

Write-Host "`n===== Teste Concluído =====" -ForegroundColor Cyan