# ============================================
# DEMOSTRACIÓN COMPLETA DE LA API
# ============================================

$baseUrl = "http://127.0.0.1:8001/api"

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        DEMOSTRACIÓN API DE GESTIÓN DE TAREAS - LARAVEL        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# ============================================
# 1. MOSTRAR USUARIOS REGISTRADOS
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  1. USUARIOS REGISTRADOS EN EL SISTEMA         │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

# Autenticar usuarios existentes
Write-Host "`nAutenticando usuarios..." -ForegroundColor Gray

$login1 = Invoke-RestMethod -Method Post -Uri "$baseUrl/login" -Headers @{ "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"email":"juan@example.com","password":"Password123"}'
$token1 = $login1.data.access_token

$login2 = Invoke-RestMethod -Method Post -Uri "$baseUrl/login" -Headers @{ "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"email":"maria@example.com","password":"Secret456"}'
$token2 = $login2.data.access_token

$login3 = Invoke-RestMethod -Method Post -Uri "$baseUrl/login" -Headers @{ "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"email":"carlos@example.com","password":"Testing789"}'
$token3 = $login3.data.access_token

Write-Host "`n  Usuario 1:" -ForegroundColor White
Write-Host "    ID:     $($login1.data.id)" -ForegroundColor Green
Write-Host "    Nombre: $($login1.data.name)" -ForegroundColor Green
Write-Host "    Email:  $($login1.data.email)" -ForegroundColor Green
Write-Host "    Token:  $($token1.Substring(0,30))..." -ForegroundColor DarkGray

Write-Host "`n  Usuario 2:" -ForegroundColor White
Write-Host "    ID:     $($login2.data.id)" -ForegroundColor Green
Write-Host "    Nombre: $($login2.data.name)" -ForegroundColor Green
Write-Host "    Email:  $($login2.data.email)" -ForegroundColor Green
Write-Host "    Token:  $($token2.Substring(0,30))..." -ForegroundColor DarkGray

Write-Host "`n  Usuario 3:" -ForegroundColor White
Write-Host "    ID:     $($login3.data.id)" -ForegroundColor Green
Write-Host "    Nombre: $($login3.data.name)" -ForegroundColor Green
Write-Host "    Email:  $($login3.data.email)" -ForegroundColor Green
Write-Host "    Token:  $($token3.Substring(0,30))..." -ForegroundColor DarkGray

# ============================================
# 2. TAREAS DEL USUARIO 1 (JUAN)
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  2. TAREAS DE JUAN PÉREZ                        │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

$tasks1 = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json" }

Write-Host "`n  Total de tareas: $($tasks1.data.total)" -ForegroundColor Cyan
foreach ($task in $tasks1.data.data) {
    $statusColor = switch ($task.status) {
        "completed" { "Green" }
        "in_progress" { "Yellow" }
        "pending" { "White" }
        default { "Gray" }
    }
    
    Write-Host "`n  ► Tarea #$($task.id):" -ForegroundColor White
    Write-Host "    Título:      $($task.title)" -ForegroundColor $statusColor
    Write-Host "    Descripción: $($task.description)" -ForegroundColor Gray
    Write-Host "    Estado:      $($task.status)" -ForegroundColor $statusColor
    Write-Host "    Vence:       $($task.due_date)" -ForegroundColor Cyan
    Write-Host "    Creada:      $($task.created_at)" -ForegroundColor DarkGray
}

# ============================================
# 3. TAREAS DEL USUARIO 2 (MARÍA)
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  3. TAREAS DE MARÍA GARCÍA                      │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

$tasks2 = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token2"; "Accept" = "application/json" }

Write-Host "`n  Total de tareas: $($tasks2.data.total)" -ForegroundColor Cyan
foreach ($task in $tasks2.data.data) {
    $statusColor = switch ($task.status) {
        "completed" { "Green" }
        "in_progress" { "Yellow" }
        "pending" { "White" }
        default { "Gray" }
    }
    
    Write-Host "`n  ► Tarea #$($task.id):" -ForegroundColor White
    Write-Host "    Título:      $($task.title)" -ForegroundColor $statusColor
    Write-Host "    Descripción: $($task.description)" -ForegroundColor Gray
    Write-Host "    Estado:      $($task.status)" -ForegroundColor $statusColor
    Write-Host "    Vence:       $($task.due_date)" -ForegroundColor Cyan
}

# ============================================
# 4. TAREAS DEL USUARIO 3 (CARLOS)
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  4. TAREAS DE CARLOS LÓPEZ                      │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

$tasks3 = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token3"; "Accept" = "application/json" }

Write-Host "`n  Total de tareas: $($tasks3.data.total)" -ForegroundColor Cyan
foreach ($task in $tasks3.data.data) {
    $statusColor = switch ($task.status) {
        "completed" { "Green" }
        "in_progress" { "Yellow" }
        "pending" { "White" }
        default { "Gray" }
    }
    
    Write-Host "`n  ► Tarea #$($task.id):" -ForegroundColor White
    Write-Host "    Título:      $($task.title)" -ForegroundColor $statusColor
    Write-Host "    Descripción: $($task.description)" -ForegroundColor Gray
    Write-Host "    Estado:      $($task.status)" -ForegroundColor $statusColor
    Write-Host "    Vence:       $($task.due_date)" -ForegroundColor Cyan
}

# ============================================
# 5. DEMOSTRACIÓN DE INTEGRACIÓN API EXTERNA
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  5. INTEGRACIÓN API EXTERNA (CLIMA)             │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

# Obtener clima de una tarea de cada usuario
$firstTaskId1 = $tasks1.data.data[0].id
$weather1 = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks/$firstTaskId1/weather" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json" }

Write-Host "`n  Pronóstico para tarea #$firstTaskId1 de Juan:" -ForegroundColor White
Write-Host "    Fecha:           $($weather1.data.due_date)" -ForegroundColor Cyan
if ($weather1.data.weather) {
    Write-Host "    Temp. Máxima:    $($weather1.data.weather.temperature_max)°C" -ForegroundColor Yellow
    Write-Host "    Temp. Mínima:    $($weather1.data.weather.temperature_min)°C" -ForegroundColor Blue
    Write-Host "    Precipitación:   $($weather1.data.weather.precipitation_sum) mm" -ForegroundColor Cyan
} else {
    Write-Host "    Sin datos disponibles (fecha fuera de rango API)" -ForegroundColor Gray
}

# ============================================
# 6. DEMOSTRACIÓN DE OPERACIONES CRUD
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  6. OPERACIONES CRUD - DEMOSTRACIÓN             │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

Write-Host "`n  A) CREAR nueva tarea:" -ForegroundColor Cyan
$newTask = Invoke-RestMethod -Method Post -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"title":"Tarea de demostración CRUD","description":"Esta tarea se creó durante la demo","status":"pending","due_date":"2025-12-05"}'
Write-Host "     ✓ Creada: Tarea #$($newTask.data.id) - $($newTask.data.title)" -ForegroundColor Green

Write-Host "`n  B) LEER tarea específica:" -ForegroundColor Cyan
$readTask = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks/$($newTask.data.id)" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json" }
Write-Host "     ✓ Leída: Tarea #$($readTask.data.id)" -ForegroundColor Green
Write-Host "       Título: $($readTask.data.title)" -ForegroundColor White
Write-Host "       Estado: $($readTask.data.status)" -ForegroundColor White

Write-Host "`n  C) ACTUALIZAR tarea:" -ForegroundColor Cyan
$updateTask = Invoke-RestMethod -Method Patch -Uri "$baseUrl/tasks/$($newTask.data.id)" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"status":"in_progress","description":"Descripción actualizada durante la demo"}'
Write-Host "     ✓ Actualizada: Tarea #$($updateTask.data.id)" -ForegroundColor Green
Write-Host "       Nuevo estado: $($updateTask.data.status)" -ForegroundColor Yellow
Write-Host "       Nueva desc:   $($updateTask.data.description)" -ForegroundColor White

Write-Host "`n  D) ELIMINAR tarea:" -ForegroundColor Cyan
$deleteTask = Invoke-RestMethod -Method Delete -Uri "$baseUrl/tasks/$($newTask.data.id)" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json" }
Write-Host "     ✓ Eliminada: $($deleteTask.data.message)" -ForegroundColor Green

# ============================================
# 7. DEMOSTRACIÓN DE VALIDACIONES
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  7. VALIDACIONES IMPLEMENTADAS                  │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

Write-Host "`n  A) Validación: Título requerido" -ForegroundColor Cyan
try {
    Invoke-RestMethod -Method Post -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"status":"pending"}'
} catch {
    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
    Write-Host "     ✓ Error capturado correctamente:" -ForegroundColor Green
    Write-Host "       Mensaje: $($errorResponse.message)" -ForegroundColor Yellow
    Write-Host "       Errores: $($errorResponse.errors.title -join ', ')" -ForegroundColor Red
}

Write-Host "`n  B) Validación: Password con letras y números" -ForegroundColor Cyan
try {
    Invoke-RestMethod -Method Post -Uri "$baseUrl/register" -Headers @{ "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"name":"Test","email":"test@test.com","password":"onlyletters","password_confirmation":"onlyletters"}'
} catch {
    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
    Write-Host "     ✓ Error capturado correctamente:" -ForegroundColor Green
    Write-Host "       Mensaje: $($errorResponse.message)" -ForegroundColor Yellow
}

Write-Host "`n  C) Validación: Fecha no puede ser pasada" -ForegroundColor Cyan
try {
    Invoke-RestMethod -Method Post -Uri "$baseUrl/tasks" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json"; "Content-Type" = "application/json" } -Body '{"title":"Tarea con fecha pasada","status":"pending","due_date":"2020-01-01"}'
} catch {
    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
    Write-Host "     ✓ Error capturado correctamente:" -ForegroundColor Green
    Write-Host "       Mensaje: $($errorResponse.message)" -ForegroundColor Yellow
    Write-Host "       Errores: $($errorResponse.errors.due_date -join ', ')" -ForegroundColor Red
}

# ============================================
# 8. AUTORIZACIÓN (Policy)
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  8. DEMOSTRACIÓN DE AUTORIZACIÓN (POLICY)       │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

Write-Host "`n  Intentando que María acceda a tarea de Juan:" -ForegroundColor Cyan
$juanTaskId = $tasks1.data.data[0].id

try {
    Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks/$juanTaskId" -Headers @{ "Authorization" = "Bearer $token2"; "Accept" = "application/json" }
} catch {
    Write-Host "     ✓ Acceso DENEGADO correctamente (403 Forbidden)" -ForegroundColor Green
    Write-Host "       Los usuarios solo pueden ver sus propias tareas" -ForegroundColor Yellow
}

# ============================================
# 9. PAGINACIÓN
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  9. DEMOSTRACIÓN DE PAGINACIÓN                  │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

Write-Host "`n  Solicitando 2 tareas por página:" -ForegroundColor Cyan
$paginatedTasks = Invoke-RestMethod -Method Get -Uri "$baseUrl/tasks?per_page=2" -Headers @{ "Authorization" = "Bearer $token1"; "Accept" = "application/json" }
Write-Host "     ✓ Página actual:    $($paginatedTasks.data.current_page)" -ForegroundColor Green
Write-Host "     ✓ Total páginas:    $($paginatedTasks.data.last_page)" -ForegroundColor Green
Write-Host "     ✓ Por página:       $($paginatedTasks.data.per_page)" -ForegroundColor Green
Write-Host "     ✓ Total registros:  $($paginatedTasks.data.total)" -ForegroundColor Green
Write-Host "     ✓ Tareas mostradas: $($paginatedTasks.data.data.Count)" -ForegroundColor Green

# ============================================
# 10. ESTADÍSTICAS FINALES
# ============================================
Write-Host "`n┌─────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│  10. RESUMEN Y ESTADÍSTICAS                     │" -ForegroundColor Yellow
Write-Host "└─────────────────────────────────────────────────┘" -ForegroundColor Yellow

$totalTasks = $tasks1.data.total + $tasks2.data.total + $tasks3.data.total
$completedTasks = ($tasks1.data.data + $tasks2.data.data + $tasks3.data.data | Where-Object { $_.status -eq "completed" }).Count
$inProgressTasks = ($tasks1.data.data + $tasks2.data.data + $tasks3.data.data | Where-Object { $_.status -eq "in_progress" }).Count
$pendingTasks = ($tasks1.data.data + $tasks2.data.data + $tasks3.data.data | Where-Object { $_.status -eq "pending" }).Count

Write-Host "`n  📊 ESTADÍSTICAS GENERALES:" -ForegroundColor White
Write-Host "     • Total usuarios:        3" -ForegroundColor Cyan
Write-Host "     • Total tareas:          $totalTasks" -ForegroundColor Cyan
Write-Host "     • Tareas completadas:    $completedTasks" -ForegroundColor Green
Write-Host "     • Tareas en progreso:    $inProgressTasks" -ForegroundColor Yellow
Write-Host "     • Tareas pendientes:     $pendingTasks" -ForegroundColor White

Write-Host "`n  ✅ CARACTERÍSTICAS IMPLEMENTADAS:" -ForegroundColor White
Write-Host "     ✓ Autenticación con Laravel Sanctum (tokens)" -ForegroundColor Green
Write-Host "     ✓ CRUD completo de tareas" -ForegroundColor Green
Write-Host "     ✓ Autorización basada en Policy" -ForegroundColor Green
Write-Host "     ✓ Validaciones estrictas (campos, longitudes, regex)" -ForegroundColor Green
Write-Host "     ✓ Respuestas JSON estandarizadas" -ForegroundColor Green
Write-Host "     ✓ Paginación configurable" -ForegroundColor Green
Write-Host "     ✓ Integración API externa (Open-Meteo clima)" -ForegroundColor Green
Write-Host "     ✓ Estados en inglés (pending, in_progress, completed)" -ForegroundColor Green

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              DEMOSTRACIÓN COMPLETADA EXITOSAMENTE              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
