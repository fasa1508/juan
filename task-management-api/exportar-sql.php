<?php

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use App\Models\Task;

echo "\n╔════════════════════════════════════════════════════════════════╗\n";
echo "║              📤 EXPORTAR DATOS PARA POSTGRESQL                 ║\n";
echo "╚════════════════════════════════════════════════════════════════╝\n\n";

$users = User::all();
$tasks = Task::all();

echo "-- SQL para PostgreSQL\n";
echo "-- Ejecuta esto en pgAdmin 4 Query Tool\n\n";

echo "-- Limpiar tablas existentes\n";
echo "TRUNCATE TABLE tasks CASCADE;\n";
echo "TRUNCATE TABLE users RESTART IDENTITY CASCADE;\n";
echo "TRUNCATE TABLE personal_access_tokens CASCADE;\n\n";

echo "-- Insertar usuarios\n";
foreach ($users as $user) {
    $name = addslashes($user->name);
    $email = addslashes($user->email);
    $password = addslashes($user->password);
    $created = $user->created_at->format('Y-m-d H:i:s');
    $updated = $user->updated_at->format('Y-m-d H:i:s');
    
    echo "INSERT INTO users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) VALUES ({$user->id}, '{$name}', '{$email}', NULL, '{$password}', NULL, '{$created}', '{$updated}');\n";
}

echo "\n-- Insertar tareas\n";
foreach ($tasks as $task) {
    $title = addslashes($task->title);
    $description = addslashes($task->description ?? '');
    $status = $task->status;
    $dueDate = $task->due_date ? "'{$task->due_date->format('Y-m-d')}'" : 'NULL';
    $created = $task->created_at->format('Y-m-d H:i:s');
    $updated = $task->updated_at->format('Y-m-d H:i:s');
    
    echo "INSERT INTO tasks (id, user_id, title, description, status, due_date, created_at, updated_at) VALUES ({$task->id}, {$task->user_id}, '{$title}', '{$description}', '{$status}', {$dueDate}, '{$created}', '{$updated}');\n";
}

echo "\n-- Resetear secuencias\n";
echo "SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));\n";
echo "SELECT setval('tasks_id_seq', (SELECT MAX(id) FROM tasks));\n";

echo "\n-- Verificar\n";
echo "SELECT COUNT(*) as total_users FROM users;\n";
echo "SELECT COUNT(*) as total_tasks FROM tasks;\n";

echo "\n\n✅ SQL generado. Copia y pega en pgAdmin 4 Query Tool\n\n";
