<?php

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use App\Models\Task;
use Illuminate\Support\Facades\DB;

echo "\n╔════════════════════════════════════════════════════════════════╗\n";
echo "║           VERIFICACIÓN BASE DE DATOS - VISTA TÉCNICA          ║\n";
echo "╚════════════════════════════════════════════════════════════════╝\n";

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  ESTADÍSTICAS GENERALES                         │\n";
echo "└─────────────────────────────────────────────────┘\n\n";

$totalUsers = User::count();
$totalTasks = Task::count();
$totalTokens = DB::table('personal_access_tokens')->count();

echo "  📊 Total Usuarios:        $totalUsers\n";
echo "  📋 Total Tareas:          $totalTasks\n";
echo "  🔑 Tokens Activos:        $totalTokens\n";

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  USUARIOS REGISTRADOS                           │\n";
echo "└─────────────────────────────────────────────────┘\n";

$users = User::withCount('tasks')->get();
foreach ($users as $user) {
    echo "\n  ┌─ Usuario #{$user->id}\n";
    echo "  │  Nombre:         {$user->name}\n";
    echo "  │  Email:          {$user->email}\n";
    echo "  │  Total Tareas:   {$user->tasks_count}\n";
    echo "  │  Registrado:     {$user->created_at->format('d/m/Y H:i')}\n";
    echo "  └───────────────────────────────────────────\n";
}

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  TAREAS POR ESTADO                              │\n";
echo "└─────────────────────────────────────────────────┘\n\n";

$pending = Task::where('status', 'pending')->count();
$inProgress = Task::where('status', 'in_progress')->count();
$completed = Task::where('status', 'completed')->count();

echo "  ⏳ Pendientes (pending):      $pending\n";
echo "  🔄 En Progreso (in_progress): $inProgress\n";
echo "  ✅ Completadas (completed):   $completed\n";

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  TODAS LAS TAREAS                               │\n";
echo "└─────────────────────────────────────────────────┘\n";

$tasks = Task::with('user')->orderBy('id')->get();
foreach ($tasks as $task) {
    $statusIcon = match($task->status) {
        'completed' => '✅',
        'in_progress' => '🔄',
        'pending' => '⏳',
        default => '📋'
    };
    
    echo "\n  $statusIcon Tarea #{$task->id}\n";
    echo "     Título:       {$task->title}\n";
    echo "     Usuario:      {$task->user->name}\n";
    echo "     Estado:       {$task->status}\n";
    echo "     Vencimiento:  " . ($task->due_date ? $task->due_date->format('d/m/Y') : 'Sin fecha') . "\n";
    echo "     Descripción:  " . substr($task->description, 0, 60) . (strlen($task->description) > 60 ? '...' : '') . "\n";
}

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  TOKENS DE AUTENTICACIÓN (ÚLTIMOS 5)           │\n";
echo "└─────────────────────────────────────────────────┘\n";

$tokens = DB::table('personal_access_tokens')
    ->orderBy('id', 'desc')
    ->limit(5)
    ->get();

foreach ($tokens as $token) {
    $user = User::find($token->tokenable_id);
    $tokenPreview = substr($token->token, 0, 30) . '...';
    
    echo "\n  🔑 Token #{$token->id}\n";
    echo "     Usuario:     {$user->name} (ID: {$user->id})\n";
    echo "     Nombre:      {$token->name}\n";
    echo "     Token:       {$tokenPreview}\n";
    echo "     Creado:      {$token->created_at}\n";
}

echo "\n┌─────────────────────────────────────────────────┐\n";
echo "│  RELACIONES Y CONSISTENCIA                      │\n";
echo "└─────────────────────────────────────────────────┘\n\n";

// Verificar que todas las tareas tienen usuario válido
$tasksWithoutUser = Task::whereNotIn('user_id', User::pluck('id'))->count();
echo "  ✓ Tareas huérfanas:              $tasksWithoutUser\n";

// Verificar que todos los tokens tienen usuario válido
$tokensWithoutUser = DB::table('personal_access_tokens')
    ->whereNotIn('tokenable_id', User::pluck('id'))
    ->count();
echo "  ✓ Tokens sin usuario:            $tokensWithoutUser\n";

// Tareas por usuario
echo "\n  📊 Distribución de tareas por usuario:\n";
foreach ($users as $user) {
    $userTasks = Task::where('user_id', $user->id)->count();
    echo "     • {$user->name}: $userTasks tareas\n";
}

echo "\n╔════════════════════════════════════════════════════════════════╗\n";
echo "║              ✅ VERIFICACIÓN COMPLETADA EXITOSAMENTE           ║\n";
echo "╚════════════════════════════════════════════════════════════════╝\n\n";
