<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Task;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        $password = Hash::make('Password123!');

        $users = [
            ['name' => 'Juan Pérez', 'email' => 'juan.perez@example.com', 'password' => $password],
            ['name' => 'María García', 'email' => 'maria.garcia@example.com', 'password' => $password],
            ['name' => 'Carlos López', 'email' => 'carlos.lopez@example.com', 'password' => $password],
        ];

        $createdUsers = [];
        foreach ($users as $data) {
            $createdUsers[$data['email']] = User::query()->create($data);
        }

        $tasks = [
            ['email' => 'juan.perez@example.com', 'title' => 'Configurar entorno inicial', 'description' => 'Preparar variables de entorno y dependencias', 'status' => 'pending', 'days' => 1],
            ['email' => 'maria.garcia@example.com', 'title' => 'Diseñar esquema base datos', 'description' => 'Tablas, claves y relaciones principales', 'status' => 'in_progress', 'days' => 3],
            ['email' => 'carlos.lopez@example.com', 'title' => 'Implementar registro usuarios', 'description' => 'Endpoint de creación con validaciones', 'status' => 'completed', 'days' => 2],
            ['email' => 'juan.perez@example.com', 'title' => 'Crear endpoints tareas', 'description' => 'CRUD completo con políticas', 'status' => 'pending', 'days' => 5],
            ['email' => 'maria.garcia@example.com', 'title' => 'Agregar validaciones', 'description' => 'Reglas estrictas para inputs', 'status' => 'in_progress', 'days' => 4],
            ['email' => 'carlos.lopez@example.com', 'title' => 'Integrar API clima', 'description' => 'Consulta a Open-Meteo', 'status' => 'pending', 'days' => 7],
            ['email' => 'juan.perez@example.com', 'title' => 'Refinar respuestas JSON', 'description' => 'Formato consistente éxito/error', 'status' => 'completed', 'days' => 2],
            ['email' => 'maria.garcia@example.com', 'title' => 'Preparar documentación', 'description' => 'README y evidencias de prueba', 'status' => 'pending', 'days' => 6],
        ];

        foreach ($tasks as $t) {
            $user = $createdUsers[$t['email']];
            Task::query()->create([
                'user_id' => $user->id,
                'title' => $t['title'],
                'description' => $t['description'],
                'status' => $t['status'],
                'due_date' => now()->addDays($t['days'])->toDateString(),
            ]);
        }
    }
}
