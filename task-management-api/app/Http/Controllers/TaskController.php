<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Http\Requests\Task\TaskIndexRequest;
use App\Http\Requests\Task\StoreTaskRequest;
use App\Http\Requests\Task\UpdateTaskRequest;
use App\Traits\ApiResponse;

class TaskController extends Controller
{
    use ApiResponse;
    public function index(TaskIndexRequest $request)
    {
        $validated = $request->validated();
        $perPage = (int) ($validated['per_page'] ?? 15);
        $perPage = $perPage > 0 && $perPage <= 100 ? $perPage : 15;

        $tasks = $request->user()->tasks()->latest()->paginate($perPage);
        
        return $this->successResponse($tasks);
    }

    public function store(StoreTaskRequest $request)
    {
        $validated = $request->validated();

        $task = $request->user()->tasks()->create($validated);

        return $this->successResponse($task, 201);
    }

    public function show(Task $task)
    {
        $this->authorize('view', $task);
        return $this->successResponse($task);
    }

    public function update(UpdateTaskRequest $request, Task $task)
    {
        $this->authorize('update', $task);
        $validated = $request->validated();

        $task->update($validated);

        return $this->successResponse($task);
    }

    public function destroy(Task $task)
    {
        $this->authorize('delete', $task);
        $task->delete();
        return $this->successResponse(['message' => 'Task deleted'], 200);
    }

    public function weather(Task $task)
    {
        $this->authorize('view', $task);

        // Ejemplo simple usando Open-Meteo (sin API key). Coordenadas fijas o podrían venir del usuario.
        $latitude = 40.4168; // Madrid
        $longitude = -3.7038;
        $date = $task->due_date ? $task->due_date->format('Y-m-d') : now()->toDateString();

        // Para simplificar: pedimos forecast diario y filtramos por fecha si coincide.
        $url = sprintf('https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=UTC', $latitude, $longitude);

        try {
            $response = file_get_contents($url);
            $payload = json_decode($response, true);
        } catch (\Throwable $e) {
            return $this->errorResponse('Weather service unavailable', 503);
        }

        $daily = $payload['daily'] ?? [];
        $result = null;
        if (!empty($daily['time'])) {
            foreach ($daily['time'] as $idx => $day) {
                if ($day === $date) {
                    $result = [
                        'date' => $day,
                        'temperature_max' => $daily['temperature_2m_max'][$idx] ?? null,
                        'temperature_min' => $daily['temperature_2m_min'][$idx] ?? null,
                        'precipitation_sum' => $daily['precipitation_sum'][$idx] ?? null,
                    ];
                    break;
                }
            }
        }

        return $this->successResponse([
            'task_id' => $task->id,
            'due_date' => $task->due_date,
            'weather' => $result,
        ]);
    }
}
