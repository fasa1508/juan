# CONTEXTO COMPLETO DEL PROYECTO - API REST de Gestión de Tareas

**Fecha de inicio:** 20 de noviembre de 2025  
**Estado actual:** Configuración de Sanctum en progreso (Paso 10 de 11)

---

## 1. OBJETIVO DEL PROYECTO

Desarrollar una **API REST para gestión de tareas personales** con las siguientes características:

### Requisitos Funcionales:
1. **Autenticación de usuarios** mediante tokens (Laravel Sanctum)
2. **CRUD completo de tareas** (crear, leer, actualizar, eliminar)
3. **Consumo de API externa** (integración pendiente de definir)
4. **Documentación detallada** de cada paso realizado

### Stack Tecnológico Seleccionado:
- **Framework:** Laravel 12.x
- **Base de datos:** PostgreSQL 16
- **Autenticación:** Laravel Sanctum
- **Lenguaje:** PHP 8.3.26
- **Gestor de paquetes:** Composer 2.8.4
- **Entorno local:** Laragon (Windows)

---

## 2. HISTORIAL COMPLETO DE ACCIONES REALIZADAS

### FASE 1: Preparación del Entorno (COMPLETADA ✓)

#### Paso 1.1: Instalación de Laragon
- **Acción:** Usuario instaló Laragon Full
- **Ubicación:** `C:\laragon`
**Estado actual:** Configuración de Sanctum completada; listo para CRUD de tareas
- **Verificación exitosa:** PHP y Composer funcionando

#### Paso 5.4: Configuración del modelo User (COMPLETADA ✓)
```powershell
**Archivo modificado:** `app/Models/User.php`
# Output: PHP 8.3.26 (cli) (built: Nov 19 2024 13:24:56) (ZTS Visual C++ 2019 x64)

**Cambios aplicados:**
```php
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;
}
```
- **Problema:** Permisos de escritura en carpeta `bootstrap/cache` por estar en OneDrive
- **Error:** "The bootstrap/cache directory must be present and writable"
#### Paso 5.5: Configuración de rutas API (COMPLETADA ✓)

**Archivo creado:** `routes/api.php`
```powershell
cd C:\laragon\www
**Contenido:**
```php
use App\Http\Controllers\AuthController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
});
```

Además, se registró el archivo de rutas API en `bootstrap/app.php`:
```php
->withRouting(
    web: __DIR__.'/../routes/web.php',
    api: __DIR__.'/../routes/api.php',
    commands: __DIR__.'/../routes/console.php',
    health: '/up',
)
```
- Dependencias instaladas

#### Paso 5.6: Crear AuthController (COMPLETADA ✓)

**Archivo creado:** `app/Http/Controllers/AuthController.php`

### FASE 3: Configuración de PostgreSQL (COMPLETADA ✓ - Tras múltiples iteraciones)

#### Paso 3.1: Instalación de PostgreSQL
- **Versión instalada:** PostgreSQL 16 (recomendada sobre la 17 por estabilidad)
- **Ubicación:** `C:\Program Files\PostgreSQL\16`
- **Herramientas:** pgAdmin 4 incluido
- **Puerto por defecto:** 5432

#### Paso 3.2: Problema detectado - Dual instalación
**Situación crítica encontrada:**
- Dos versiones de PostgreSQL instaladas simultáneamente:
  - `postgresql-x64-16` (deseada)
  - `postgresql-x64-18` (conflictiva)
- Ambos servicios corriendo y compitiendo por el puerto 5432
- **Solución aplicada:**
  ```powershell
  Stop-Service postgresql-x64-18 -Force
  Set-Service postgresql-x64-18 -StartupType Disabled
  ```

#### Paso 3.3: Habilitación de extensiones PHP para PostgreSQL
**Archivo modificado:** `C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.ini`

**Cambios realizados:**
```ini
# Antes (comentadas):
;extension=pdo_pgsql
;extension=pgsql

# Después (activas):
extension=pdo_pgsql
extension=pgsql
```

**Reinicio requerido:** Servicio Apache en Laragon

#### Paso 3.4: Reinicialización completa del cluster PostgreSQL
**Problema:** Cluster original corrupto/inaccesible tras conflicto de versiones

**Proceso de reinicialización:**

1. **Detención del servicio:**
   ```powershell
   Stop-Service postgresql-x64-16 -Force
   ```

2. **Creación de nuevo directorio de datos (fuera de Program Files):**
   ```powershell
   $newData = "C:\pgdata\16"
   New-Item -ItemType Directory -Path $newData -Force
   ```

3. **Inicialización del cluster limpio:**
   ```powershell
   & "C:\Program Files\PostgreSQL\16\bin\initdb.exe" -D $newData -U postgres -A trust --encoding=UTF8
   ```
   
   **Salida exitosa:**
   ```
   Los archivos de este cluster serán de propiedad del usuario «FernanandresSanchezA».
   Este usuario también debe ser quien ejecute el proceso servidor.
   
   El cluster será inicializado con configuración regional «Spanish_Colombia.1252».
   La configuración de búsqueda de texto ha sido definida a «spanish».
   
   corrigiendo permisos en el directorio existente C:/pgdata/16 ... hecho
   creando subdirectorios ... hecho
   seleccionando implementación de memoria compartida dinámica ... windows
   seleccionando el valor para max_connections ... 100
   seleccionando el valor para shared_buffers ... 128MB
   seleccionando el huso horario por omisión ... America/Bogota
   creando archivos de configuración ... hecho
   ejecutando script de inicio (bootstrap) ... hecho
   realizando inicialización post-bootstrap ... hecho
#### Verificación de rutas (COMPLETADA ✓)
Se ejecutó `php artisan route:list` y se confirmaron las rutas:

```
POST   api/register   AuthController@register
POST   api/login      AuthController@login
POST   api/logout     AuthController@logout
GET    api/user       AuthController@user
```

En el proyecto de Laragon también se registraron (incluyendo la de CSRF de Sanctum):

```
POST api/register, POST api/login, POST api/logout, GET api/user, GET sanctum/csrf-cookie
```
   sincronizando los datos a disco ... hecho
   
### Paso actual: Probar autenticación y continuar con CRUD de tareas
   "C:\Program Files\PostgreSQL\16\bin\pg_ctl" -D "C:\pgdata\16" -l archivo_de_registro start
   ```
**A. Modificar modelo User** (COMPLETADO)
4. **Ajuste de postgresql.conf:**
   ```powershell
**B. Crear AuthController** (COMPLETADO)
     Set-Content "$newData\postgresql.conf"
   ```
**C. Configurar rutas de autenticación** (COMPLETADO)
   **Verificación:**
   ```
**D. Probar autenticación** (EN PROGRESO)
   ```

5. **Configuración de pg_hba.conf (reglas trust temporales para desarrollo):**
   ```powershell
   @"
   # TYPE  DATABASE        USER            ADDRESS         METHOD
   local   all             all                             trust
   host    all             all             127.0.0.1/32    trust
   host    all             all             ::1/128         trust
   "@ | Set-Content "$newData\pg_hba.conf"
   ```

   **Nota de seguridad:** Configuración permisiva solo para desarrollo local. En producción usar `scram-sha-256` o `md5`.

6. **Inicio del servidor con el nuevo cluster:**
   ```powershell
   & "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" -D $newData -l "$newData\server.log" start
   Start-Sleep -Seconds 3
   netstat -an | findstr ":5432"
   ```
   
   **Resultado exitoso:**
   ```
   esperando que el servidor se inicie.... listo
   servidor iniciado
   TCP    0.0.0.0:5432           0.0.0.0:0              LISTENING
   TCP    [::]:5432              [::]:0                 LISTENING
   ```

#### Paso 3.5: Creación de base de datos y usuario definitivos
## 13. CAMBIOS APLICADOS EN ESTA SESIÓN

Fecha: 20 de noviembre de 2025

- Se agregó `HasApiTokens` al modelo `User` (`app/Models/User.php`).
- Se creó `AuthController` con métodos `register`, `login`, `logout`, `user` (`app/Http/Controllers/AuthController.php`).
- Se creó `routes/api.php` con rutas públicas y protegidas por `auth:sanctum`.
- Se registró `routes/api.php` en `bootstrap/app.php` mediante `api: __DIR__.'/../routes/api.php'`.
- Se verificaron rutas con `php artisan route:list` en ambos proyectos.
- Se dejó listo el servidor para pruebas locales usando `php artisan serve`.

---

## 14. VERIFICACIÓN PASO A PASO

### 14.0 Estado reciente de verificación
- PostgreSQL: servidor iniciado y escuchando en `0.0.0.0:5432` y `[::]:5432`.
- Servidor Laravel: corriendo en `http://127.0.0.1:8001`.
- Registro de usuario: EXITOSO. Se obtuvo `access_token` al invocar `POST /api/register`.
- Perfil protegido: EXITOSO. `GET /api/profile` con cabeceras `Authorization: Bearer <token>` y `Accept: application/json` devolvió 200 con el usuario autenticado.

Nota: si `auth:sanctum` rechaza el token y Laravel intenta redirigir, puede aparecer `Route [login] not defined`. Para forzar JSON en APIs, incluir `Accept: application/json` en las cabeceras de las solicitudes protegidas.

### 14.1 Servidor y rutas
```powershell
Set-Location -Path "C:\laragon\www\task-management-api"
php artisan optimize:clear
php artisan route:list
php artisan serve --host=127.0.0.1 --port=8001
```
Resultados esperados:
- Rutas visibles: `api/register`, `api/login`, `api/logout`, `api/profile`, `api/tasks` (index, store, show, update, destroy), `sanctum/csrf-cookie`.
- Mensaje: `Server running on http://127.0.0.1:8001`.

### 14.2 Registro y login
```powershell
# Registro
curl -X POST "http://127.0.0.1:8001/api/register" ^
   -H "Content-Type: application/json" ^
   -d "{ \"name\": \"Usuario Prueba\", \"email\": \"user@example.com\", \"password\": \"secret123\", \"password_confirmation\": \"secret123\" }"

# Login
curl -X POST "http://127.0.0.1:8001/api/login" ^
   -H "Content-Type: application/json" ^
   -d "{ \"email\": \"user@example.com\", \"password\": \"secret123\" }"
```
Resultados esperados:
- 201 (register) y 200 (login) con `access_token`.

Resultado real (20/11/2025):
- `POST /api/register` devolvió 201 con `access_token` y los datos del usuario creado.

### 14.3 Perfil protegido y logout
```powershell
$env:TOKEN = "<TOKEN>"
curl -X GET "http://127.0.0.1:8001/api/profile" -H "Authorization: Bearer $env:TOKEN"
curl -X POST "http://127.0.0.1:8001/api/logout" -H "Authorization: Bearer $env:TOKEN"
```
Resultados esperados:
- Perfil: 200 con datos del usuario. Logout: 200 con mensaje.

### 14.4 CRUD de tareas
```powershell
# Crear
curl -X POST "http://127.0.0.1:8001/api/tasks" -H "Authorization: Bearer $env:TOKEN" -H "Content-Type: application/json" ^
   -d "{ \"title\": \"Primera tarea\", \"description\": \"Detalle\", \"status\": \"pendiente\" }"

# Listar paginado
curl -X GET "http://127.0.0.1:8001/api/tasks?per_page=10" -H "Authorization: Bearer $env:TOKEN"

# Ver
curl -X GET "http://127.0.0.1:8001/api/tasks/1" -H "Authorization: Bearer $env:TOKEN"

# Actualizar
curl -X PUT "http://127.0.0.1:8001/api/tasks/1" -H "Authorization: Bearer $env:TOKEN" -H "Content-Type: application/json" ^
   -d "{ \"status\": \"en_progreso\" }"

# Eliminar
curl -X DELETE "http://127.0.0.1:8001/api/tasks/1" -H "Authorization: Bearer $env:TOKEN"
```
Resultados esperados:
- Crear: 201 con JSON de la tarea. Listar: JSON paginado. Ver: 200. Actualizar: 200 con cambios. Eliminar: 204.

Resultado real (20/11/2025):
- Crear tarea: EXITOSO. `POST /api/tasks` devolvió 201 con la tarea creada para `user_id=1` (ver captura). `due_date` parseado correctamente y `status` en `pendiente`.
- Nota de validación: los valores permitidos para `status` son `pendiente`, `en_progreso`, `completada` (en español). Enviar `pending/in_progress/completed` produce 422.
- Nota de código: fue necesario replicar la relación `tasks()` en `App\Models\User` del proyecto en Laragon para evitar `BadMethodCallException`.
- Listar: EXITOSO. `GET /api/tasks?per_page=10` devolvió paginación con 1 registro.
- Ver: EXITOSO. `GET /api/tasks/1` devolvió la tarea creada.
- Actualizar: EXITOSO. `PUT /api/tasks/1` con `{ "status": "en_progreso" }` reflejó cambio y actualizó `updated_at`.
- Eliminar: EXITOSO. `DELETE /api/tasks/1` respondió 204 (sin contenido) y la tarea dejó de listarse.
```powershell
# Crear rol/usuario
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d postgres -c "CREATE DATABASE task_db OWNER task_user;"

# Otorgar privilegios
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE task_db TO task_user;"
# Output: GRANT
```

**Credenciales finales:**
- **Usuario:** `task_user`
- **Contraseña:** `task_pass_2024`
- **Base de datos:** `task_db`
- **Host:** `127.0.0.1`
- **Puerto:** `5432`

---

### FASE 4: Conexión Laravel ↔ PostgreSQL (COMPLETADA ✓)

#### Paso 4.1: Configuración del archivo .env
**Ubicación:** `C:\laragon\www\task-management-api\.env`

**Configuración de base de datos:**
```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=task_db
DB_USERNAME=task_user
DB_PASSWORD=task_pass_2024
DB_SSLMODE=disable
```

**Otras configuraciones importantes:**
```env
APP_NAME="Task Management API"
APP_ENV=local
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost
APP_KEY=base64:...  # Generado con php artisan key:generate
```

#### Paso 4.2: Ejecución de migraciones
```powershell
cd C:\laragon\www\task-management-api
php artisan migrate
```

**Resultado exitoso (Exit Code: 0):**
- Tablas por defecto de Laravel creadas:
  - `migrations`
  - `users`
  - `password_reset_tokens`
  - `sessions`
  - `cache`
  - `cache_locks`
  - `jobs`
  - `job_batches`
  - `failed_jobs`

---

### FASE 5: Instalación y Configuración de Laravel Sanctum (EN PROGRESO ⏳)

#### Paso 5.1: Instalación del paquete (COMPLETADA ✓)
```powershell
composer require laravel/sanctum
```

**Resultado:** Paquete instalado exitosamente (Exit Code: 0)

#### Paso 5.2: Publicación de archivos de configuración (COMPLETADA ✓)
```powershell
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
```

**Archivos publicados:**
- `config/sanctum.php` - Configuración de Sanctum
- `database/migrations/2019_12_14_000001_create_personal_access_tokens_table.php` - Migración para tokens

#### Paso 5.3: Migración de tabla de tokens (COMPLETADA ✓)
```powershell
php artisan migrate
```

**Resultado exitoso:** Tabla `personal_access_tokens` creada en PostgreSQL

#### Paso 5.4: Configuración del modelo User (PENDIENTE ⏸️)
**Siguiente acción requerida:** Agregar trait `HasApiTokens` al modelo `User.php`

**Archivo a modificar:** `app/Models/User.php`

**Cambio requerido:**
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;  // ← AGREGAR ESTA LÍNEA

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;  // ← AGREGAR HasApiTokens
    
    // ... resto del código sin cambios
}
```

#### Paso 5.5: Configuración de rutas API (PENDIENTE ⏸️)
**Archivo a crear/modificar:** `routes/api.php`

**Rutas de autenticación a agregar:**
```php
use App\Http\Controllers\AuthController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
});
```

#### Paso 5.6: Crear AuthController (PENDIENTE ⏸️)
**Archivo a crear:** `app/Http/Controllers/AuthController.php`

**Contenido requerido:**
```php
<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['Las credenciales proporcionadas son incorrectas.'],
            ]);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Sesión cerrada exitosamente']);
    }

    public function user(Request $request)
    {
        return response()->json($request->user());
    }
}
```

---

### FASE 6: CRUD de Tareas (PENDIENTE 🔜)
### FASE 6: CRUD de Tareas (EN PROGRESO ⏳)

#### Paso 6.1: Crear modelo y migración de Task (COMPLETADO ✓)
**Archivos creados:**
- `app/Models/Task.php`
- `database/migrations/2025_11_20_000003_create_tasks_table.php`

**Tabla `tasks`:** id, user_id (FK, cascade), title, description, status (enum), due_date (date), timestamps.

**Relaciones:**
- `Task::user()` → belongsTo(User)
- `User::tasks()` → hasMany(Task)

#### Paso 6.2: Crear TaskController (COMPLETADO ✓)
- `app/Http/Controllers/TaskController.php` con `index` (paginado con `per_page`), `store`, `show`, `update`, `destroy` y `authorize` por policy.

#### Paso 6.2.1: Limpieza con Form Requests (COMPLETADO ✓)
- Se crearon y usan Form Requests para validaciones en controladores:
   - `app/Http/Requests/Auth/RegisterRequest.php`
   - `app/Http/Requests/Auth/LoginRequest.php`
   - `app/Http/Requests/Task/TaskIndexRequest.php` (valida `per_page` 1..100)
   - `app/Http/Requests/Task/StoreTaskRequest.php`
   - `app/Http/Requests/Task/UpdateTaskRequest.php`
- Se migraron `AuthController` y `TaskController` para usar `$request->validated()`.
- Se actualizó `app/Http/Controllers/Controller.php` para incluir los traits `AuthorizesRequests`, `DispatchesJobs`, `ValidatesRequests`.

#### Paso 6.3: Crear TaskPolicy para autorización (COMPLETADO ✓)
- `app/Policies/TaskPolicy.php` con `view`, `update`, `delete` restringiendo al dueño (`user_id`).
- Se usa auto-discovery de policies de Laravel 12 (no requiere registro manual).

#### Paso 6.4: Definir rutas API para tareas (COMPLETADO ✓)
- En `routes/api.php` se añadió `Route::apiResource('tasks', TaskController::class);` dentro del grupo `auth:sanctum`.

#### Paso 6.5: Endpoint de perfil (COMPLETADO ✓)
- Se agregó `GET /api/profile` apuntando a `AuthController@user`.

#### Paso 6.6: Migración aplicada (COMPLETADO ✓)
- `php artisan migrate` ejecutado en el proyecto de Laragon. Tabla `tasks` creada.

---

## 3. ESTRUCTURA ACTUAL DEL PROYECTO

```
C:\laragon\www\task-management-api/
├── app/
│   ├── Http/
│   │   └── Controllers/
│   │       ├── AuthController.php (PENDIENTE)
│   │       └── TaskController.php (PENDIENTE)
│   ├── Models/
│   │   ├── User.php (REQUIERE MODIFICACIÓN - agregar HasApiTokens)
│   │   └── Task.php (PENDIENTE)
│   └── Policies/
│       └── TaskPolicy.php (PENDIENTE)
├── config/
│   └── sanctum.php (✓ CREADO)
├── database/
│   └── migrations/
│       ├── 0001_01_01_000000_create_users_table.php (✓ MIGRADA)
│       ├── 0001_01_01_000001_create_cache_table.php (✓ MIGRADA)
│       ├── 0001_01_01_000002_create_jobs_table.php (✓ MIGRADA)
│       ├── 2019_12_14_000001_create_personal_access_tokens_table.php (✓ MIGRADA)
│       └── XXXX_XX_XX_create_tasks_table.php (PENDIENTE)
├── routes/
│   ├── api.php (REQUIERE RUTAS DE AUTH Y TASKS)
│   └── web.php
├── .env (✓ CONFIGURADO CON POSTGRESQL)
├── composer.json
└── README.md (PENDIENTE ACTUALIZAR)
```

---

## 4. ESTADO DE LA BASE DE DATOS POSTGRESQL

### Servidor PostgreSQL:
- **Estado:** ✓ Corriendo activamente
- **Data directory:** `C:\pgdata\16`
- **Puerto:** `5432` (LISTENING en 0.0.0.0 y ::)
- **Usuario superadmin:** `postgres`
- **Método de autenticación:** `trust` (solo local)

### Base de datos del proyecto:
- **Nombre:** `task_db`
- **Owner:** `task_user`
- **Credenciales:**
  - Usuario: `task_user`
  - Password: `task_pass_2024`

### Tablas existentes:
1. `migrations` - Control de migraciones
2. `users` - Usuarios del sistema
3. `password_reset_tokens` - Tokens de reset de contraseña
4. `sessions` - Sesiones de usuario
5. `cache` - Sistema de caché
6. `cache_locks` - Locks de caché
7. `jobs` - Cola de trabajos
8. `job_batches` - Lotes de trabajos
9. `failed_jobs` - Trabajos fallidos
10. `personal_access_tokens` - Tokens de Sanctum ✓

**Tabla pendiente de crear:**
- `tasks` - Tareas del usuario

---

## 5. DOCUMENTACIÓN GENERADA

Se crearon dos archivos de documentación en la carpeta antigua (OneDrive):

1. **`docs/01-entorno-instalacion.md`**
   - Guía de instalación del entorno
   - Comandos para agregar PHP/Composer al PATH
   - Verificaciones de versiones

2. **`docs/02-postgresql-config.md`**
   - Configuración inicial de PostgreSQL
   - Creación de base de datos y usuario
   - Pasos en pgAdmin 4

**Nota:** Estos archivos están en la carpeta antigua de OneDrive. Se recomienda copiarlos a `C:\laragon\www\task-management-api/docs/` después del cambio de workspace.

---

## 6. PROBLEMAS RESUELTOS Y LECCIONES APRENDIDAS

### Problema 1: Bootstrap/cache no escribible
- **Causa:** Proyecto en carpeta OneDrive con permisos restrictivos
- **Solución:** Recrear proyecto en `C:\laragon\www`
- **Lección:** Evitar carpetas sincronizadas para proyectos de desarrollo

### Problema 2: Dual instalación de PostgreSQL
- **Causa:** Instalación de versión 18 sin desinstalar versión 16
- **Síntoma:** Conflictos en puerto 5432, conexiones rechazadas
- **Solución:** Deshabilitar servicio postgresql-x64-18
- **Lección:** Verificar servicios activos antes de instalar nuevas versiones

### Problema 3: Cluster PostgreSQL corrupto
- **Causa:** Conflicto entre versiones y permisos en Program Files
- **Síntoma:** "server closed connection unexpectedly"
- **Solución:** Reinicializar cluster en directorio limpio fuera de Program Files
- **Lección:** Data directories de PostgreSQL deben estar en ubicaciones con permisos completos

### Problema 4: Conexión Laravel ↔ PostgreSQL fallida
- **Causa:** Multiple: SSL mode, pg_hba.conf restrictivo, servidor no escuchando
- **Soluciones aplicadas:**
  - `DB_SSLMODE=disable` en .env
  - Reglas trust en pg_hba.conf (temporal)
  - listen_addresses = '*' en postgresql.conf
  - Reinicio completo con cluster limpio
- **Lección:** Verificar cada capa (red, autenticación, SSL) sistemáticamente

---

## 7. COMANDOS ÚTILES PARA CONTINUIDAD

### Gestión del servidor PostgreSQL:
```powershell
# Ver estado del servicio
Get-Service postgresql-x64-16

# Iniciar servidor manualmente con pg_ctl (si servicio falla)
& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" -D "C:\pgdata\16" -l "C:\pgdata\16\server.log" start

# Detener servidor
& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" -D "C:\pgdata\16" stop

# Verificar puerto escuchando
netstat -an | findstr ":5432"

# Conectar con psql
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U task_user -d task_db
```

### Comandos Laravel frecuentes:
```powershell
cd C:\laragon\www\task-management-api

# Migraciones
php artisan migrate
php artisan migrate:fresh  # Resetear base de datos
php artisan migrate:status

# Crear modelos/controladores
php artisan make:model NombreModelo -m  # Con migración
php artisan make:controller NombreController --resource --api

# Limpiar cachés
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# Iniciar servidor de desarrollo
php artisan serve  # http://localhost:8000
```

### Verificación de conexión PostgreSQL desde Laravel:
```powershell
php artisan tinker
# Dentro de tinker:
DB::connection()->getPdo();  # Debe retornar objeto PDO sin errores
DB::select('SELECT version()');  # Muestra versión de PostgreSQL
```

---

## 8. PRÓXIMOS PASOS INMEDIATOS (ORDEN DE EJECUCIÓN)

### Paso actual: Finalizar configuración de Sanctum

**A. Modificar modelo User** (5 minutos)
- Archivo: `app/Models/User.php`
- Agregar `use Laravel\Sanctum\HasApiTokens;`
- Agregar `HasApiTokens` al trait de la clase

**B. Crear AuthController** (10 minutos)
- Crear archivo `app/Http/Controllers/AuthController.php`
- Implementar métodos: register, login, logout, user
- Incluir validaciones y manejo de errores

**C. Configurar rutas de autenticación** (5 minutos)
- Editar `routes/api.php`
- Agregar rutas públicas (register, login)
- Agregar rutas protegidas con middleware `auth:sanctum`

**D. Probar autenticación** (10 minutos)
- Usar Postman o curl
- Registrar usuario de prueba
- Login y obtener token
- Probar ruta protegida con token

### Siguiente fase: Implementar CRUD de tareas

**E. Crear migración y modelo Task** (10 minutos)
```powershell
php artisan make:model Task -m
```

**F. Definir estructura de tabla tasks** (5 minutos)
- Campos: id, user_id, title, description, status, due_date, timestamps
- Foreign key a users con cascade delete

**G. Ejecutar migración**
```powershell
php artisan migrate
```

**H. Crear TaskController con lógica CRUD** (20 minutos)

**I. Crear TaskPolicy para autorización** (10 minutos)

**J. Definir rutas API para tasks** (5 minutos)

**K. Probar CRUD completo** (15 minutos)

### Fase final: Integración de API externa y documentación

**L. Elegir API externa a integrar** (pendiente definir)
- Opciones sugeridas:
  - API de clima (OpenWeather)
  - API de noticias (NewsAPI)
  - API de tareas públicas (JSONPlaceholder)

**M. Crear servicio para consumir API externa** (30 minutos)

**N. Integrar consumo en endpoints relevantes** (20 minutos)

**O. Actualizar README.md con documentación completa** (30 minutos)
- Instalación
- Configuración
- Endpoints disponibles
- Ejemplos de uso
- Variables de entorno

**P. Pruebas finales** (30 minutos)

---

## 9. CONFIGURACIÓN DE ENTORNO (.env COMPLETO)

```env
APP_NAME="Task Management API"
APP_ENV=local
APP_KEY=base64:... # Tu key generada
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost

APP_LOCALE=es
APP_FALLBACK_LOCALE=es
APP_FAKER_LOCALE=es_ES

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=task_db
DB_USERNAME=task_user
DB_PASSWORD=task_pass_2024
DB_SSLMODE=disable

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=

MEMCACHED_HOST=127.0.0.1

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

VITE_APP_NAME="${APP_NAME}"
```

---

## 10. CHECKLIST COMPLETO DEL PROYECTO

### Infraestructura y Entorno
- [x] Laragon instalado y funcionando
- [x] PHP 8.3.26 en PATH
- [x] Composer 2.8.4 en PATH
- [x] PostgreSQL 16 instalado
- [x] pgAdmin 4 configurado
- [x] Extensiones PHP pgsql habilitadas
- [x] Servicio PostgreSQL corriendo en puerto 5432

### Proyecto Laravel
- [x] Proyecto creado en `C:\laragon\www\task-management-api`
- [x] APP_KEY generado
- [x] Dependencias instaladas
- [x] .env configurado con PostgreSQL
- [x] Conexión a base de datos funcionando
- [x] Migraciones por defecto ejecutadas

### Autenticación (Sanctum)
- [x] Paquete laravel/sanctum instalado
- [x] Configuración publicada
- [x] Migración de personal_access_tokens ejecutada
- [ ] Trait HasApiTokens agregado a User model
- [ ] AuthController creado
- [ ] Rutas de autenticación definidas
- [ ] Pruebas de registro y login exitosas

### CRUD de Tareas
- [ ] Modelo Task creado
- [ ] Migración de tasks ejecutada
- [ ] TaskController implementado
- [ ] TaskPolicy creada y registrada
- [ ] Rutas API de tasks definidas
- [ ] Relaciones User ↔ Task configuradas
- [ ] Pruebas de CRUD completas

### Integración API Externa
- [ ] API externa seleccionada
- [ ] Servicio de consumo implementado
- [ ] Integración en endpoints
- [ ] Manejo de errores de API externa
- [ ] Pruebas de integración

### Documentación
- [x] Documentación de instalación de entorno
- [x] Documentación de configuración PostgreSQL
- [ ] README.md con guía completa
- [ ] Colección Postman/Thunder Client
- [ ] Comentarios en código crítico

---

## 11. RECURSOS Y REFERENCIAS

### Documentación oficial:
- Laravel 12: https://laravel.com/docs/12.x
- Laravel Sanctum: https://laravel.com/docs/12.x/sanctum
- PostgreSQL 16: https://www.postgresql.org/docs/16/
- PHP 8.3: https://www.php.net/manual/es/

### Comandos de diagnóstico:
```powershell
# Verificar versiones
php -v
composer --version
psql --version

# Ver extensiones PHP cargadas
php -m | findstr pgsql

# Verificar servicios PostgreSQL
Get-Service | findstr postgres

# Ver logs de PostgreSQL
Get-Content "C:\pgdata\16\server.log" -Tail 50

# Estado de Laravel
php artisan about
```

---

## 12. NOTAS IMPORTANTES PARA CONTINUIDAD

1. **El proyecto funcional está en:** `C:\laragon\www\task-management-api`
   - NO usar la carpeta de OneDrive
   - Los archivos `.env` de OneDrive están desactualizados

2. **PostgreSQL está corriendo desde:** `C:\pgdata\16`
   - NO desde el directorio por defecto de Program Files
   - El servicio puede estar configurado para apuntar al directorio antiguo
   - Si hay problemas, reiniciar manualmente con pg_ctl

3. **Credenciales críticas:**
   - DB: `task_db`
   - User: `task_user`
   - Pass: `task_pass_2024`
   - Host: `127.0.0.1:5432`

4. **Antes de empezar en nuevo chat:**
   - Verificar que PostgreSQL esté corriendo: `Get-Service postgresql-x64-16`
   - Si no está, iniciar: `& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" -D "C:\pgdata\16" -l "C:\pgdata\16\server.log" start`
   - Verificar puerto: `netstat -an | findstr ":5432"`
   - Confirmar workspace abierto: `C:\laragon\www\task-management-api`

5. **Archivos que necesitan modificación inmediata:**
   - `app/Models/User.php` - Agregar HasApiTokens
   - `routes/api.php` - Definir rutas de autenticación
   - Crear `app/Http/Controllers/AuthController.php`

6. **Próximo hito concreto:**
   - Completar autenticación con Sanctum
   - Probar registro y login funcionales
   - Obtener token válido
   - Luego proceder con CRUD de tareas

---

## 15. VERIFICACIÓN COMPLETA EN pgAdmin 4 (20/11/2025)

### 15.1 Conexión a PostgreSQL
- Servidor: PostgreSQL 16 en `127.0.0.1:5432`
- Usuario: `postgres`
- Base de datos del proyecto: `task_db`

### 15.2 Tablas verificadas en `task_db`
Se confirmaron 10 tablas en el esquema `public`:
- `cache`, `cache_locks`
- `failed_jobs`, `job_batches`, `jobs`
- `migrations`
- `password_reset_tokens`
- `personal_access_tokens` ✅
- `tasks` ✅
- `users` ✅

### 15.3 Datos verificados

**Usuarios registrados:**
```sql
SELECT id, name, email, created_at FROM users ORDER BY id DESC;
```
Resultado: 1 usuario
- id=1, name="Usuario Prueba", email="user@example.com", created_at="2025-11-20 18:12:07"

**Tokens de autenticación:**
```sql
SELECT id, tokenable_id, name, last_used_at, created_at FROM personal_access_tokens ORDER BY id DESC;
```
Resultado: 2 tokens generados
- Token id=2: usado el 2025-11-20 18:47:59 (login)
- Token id=1: usado el 2025-11-20 18:12:08 (registro inicial)

**Tareas:**
```sql
SELECT id, user_id, title, status FROM tasks ORDER BY id DESC;
```
Resultado: 0 tareas (se creó y eliminó una tarea de prueba exitosamente durante las validaciones)

### 15.4 Endpoints implementados y verificados

**Autenticación (públicos):**
- `POST /api/register` ✅ - Registro exitoso, retorna token
- `POST /api/login` ✅ - Login exitoso, retorna token

**Autenticación (protegidos con Bearer token):**
- `GET /api/profile` ✅ - Retorna datos del usuario autenticado
- `POST /api/logout` ✅ - Invalida el token actual

**CRUD de Tareas (protegidos con Bearer token):**
- `GET /api/tasks?per_page=10` ✅ - Lista tareas paginadas del usuario
- `POST /api/tasks` ✅ - Crea tarea (campos: title, description, status, due_date)
- `GET /api/tasks/{id}` ✅ - Obtiene tarea específica (verifica ownership con Policy)
- `PUT /api/tasks/{id}` ✅ - Actualiza tarea (verifica ownership con Policy)
- `DELETE /api/tasks/{id}` ✅ - Elimina tarea (verifica ownership con Policy)

**Validaciones implementadas:**
- Status válidos: `pendiente`, `en_progreso`, `completada` (en español)
- Paginación: parámetro `per_page` (1-100, default 15)
- Authorization: Policies verifican que el usuario solo acceda a sus propias tareas
- Form Requests: validaciones centralizadas en RegisterRequest, LoginRequest, StoreTaskRequest, UpdateTaskRequest, TaskIndexRequest

---

**Fecha de última actualización:** 20 de noviembre de 2025  
**Estado del proyecto:** 75% completado (infraestructura lista, falta lógica de negocio)  
**Tiempo estimado para completar:** 2-3 horas de trabajo efectivo  
**Bloqueadores actuales:** Ninguno - servidor PostgreSQL funcionando correctamente
