<?php

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;

echo "\n╔════════════════════════════════════════════════════════════════╗\n";
echo "║                    👥 USUARIOS REGISTRADOS                     ║\n";
echo "╚════════════════════════════════════════════════════════════════╝\n\n";

$users = User::withCount('tasks')->get();

foreach ($users as $user) {
    echo "  ┌─ Usuario #{$user->id}\n";
    echo "  │\n";
    echo "  │  👤 Nombre:        {$user->name}\n";
    echo "  │  ✉️  Email:         {$user->email}\n";
    echo "  │  📋 Total Tareas:  {$user->tasks_count}\n";
    echo "  │  📅 Registrado:    {$user->created_at->format('d/m/Y H:i')}\n";
    echo "  │\n";
    echo "  └─────────────────────────────────────────────────────────────\n\n";
}

echo "  📊 Total de usuarios: " . $users->count() . "\n\n";

// Mostrar tareas de cada usuario
echo "╔════════════════════════════════════════════════════════════════╗\n";
echo "║                  📋 TAREAS POR USUARIO                         ║\n";
echo "╚════════════════════════════════════════════════════════════════╝\n\n";

foreach ($users as $user) {
    $tasks = $user->tasks;
    if ($tasks->count() > 0) {
        echo "  👤 {$user->name} ({$tasks->count()} tareas):\n";
        foreach ($tasks as $task) {
            $statusIcon = match($task->status) {
                'completed' => '✅',
                'in_progress' => '🔄',
                'pending' => '⏳',
                default => '📋'
            };
            echo "     $statusIcon [{$task->status}] {$task->title}\n";
        }
        echo "\n";
    }
}

echo "\n";
