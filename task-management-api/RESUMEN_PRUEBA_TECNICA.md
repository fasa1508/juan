# 📋 RESUMEN PRUEBA TÉCNICA - API DE GESTIÓN DE TAREAS

## ✅ CUMPLIMIENTO DE REQUISITOS

### 1. Framework y Tecnologías ✓
- **Laravel 12.x** (último stable, cumple requisito "Laravel 8+")
- **PHP 8.3.26** (cumple requisito "PHP 8.0+")
- **Base de Datos**: SQLite 3 (desarrollo rápido, compatible con PostgreSQL en producción)
- **Autenticación**: Laravel Sanctum 4.2.0 (alternativa válida a JWT según especificación)

### 2. Autenticación ✓
**Endpoints implementados:**
- `POST /api/register` - Registro de nuevos usuarios
- `POST /api/login` - Autenticación y generación de token
- `POST /api/logout` - Cierre de sesión y revocación de token
- `GET /api/user` - Obtener perfil del usuario autenticado

**Características:**
- Tokens Bearer de Sanctum
- Validación estricta de password (debe contener letras Y números)
- Protección de rutas mediante middleware `auth:sanctum`

### 3. CRUD de Tareas ✓
**Endpoints implementados:**
- `GET /api/tasks` - Listar tareas (con paginación)
- `POST /api/tasks` - Crear nueva tarea
- `GET /api/tasks/{id}` - Ver detalle de una tarea
- `PUT/PATCH /api/tasks/{id}` - Actualizar tarea
- `DELETE /api/tasks/{id}` - Eliminar tarea

**Modelo de Tarea:**
```php
- id (integer, auto-increment)
- user_id (foreign key a users)
- title (string, max 200)
- description (text nullable, max 1000)
- status (enum: 'pending', 'in_progress', 'completed')
- due_date (date nullable, debe ser futura)
- created_at, updated_at (timestamps)
```

### 4. Validaciones Implementadas ✓

#### Registro de Usuario:
- `name`: requerido, string, máximo 100 caracteres
- `email`: requerido, email válido, único, máximo 255 caracteres
- `password`: requerido, mínimo 8 caracteres, confirmación requerida, **regex: debe contener letras Y números**

#### Creación/Actualización de Tareas:
- `title`: requerido, string, máximo 200 caracteres
- `description`: opcional, string, máximo 1000 caracteres
- `status`: opcional, enum ('pending', 'in_progress', 'completed')
- `due_date`: opcional, fecha, **debe ser igual o posterior a hoy**

#### Paginación:
- Parámetro `per_page` (1-100, default 15)
- Validación de rango y conversión a entero

### 5. Autorización (Policy) ✓
**Implementación:**
- `TaskPolicy` con métodos: view, update, delete
- Verificación: Usuario solo puede acceder a sus propias tareas
- Retorno automático de 403 Forbidden si intenta acceder a tareas ajenas

**Demostrado en:**
- Script de demo: sección 8 muestra intento de acceso cruzado (denegado)

### 6. Respuestas JSON Estandarizadas ✓

**Formato de Éxito:**
```json
{
  "success": true,
  "data": {
    // contenido de la respuesta
  }
}
```

**Formato de Error:**
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {
    "field": ["error message"]
  }
}
```

**Implementación:**
- `ApiResponse` trait con métodos `successResponse()` y `errorResponse()`
- `ApiFormRequest` base class que intercepta validaciones fallidas
- Todos los controllers usan el trait
- Todas las Form Requests extienden la clase base

### 7. Integración con API Externa ✓
**Servicio elegido:** Open-Meteo (Pronóstico meteorológico)

**Endpoint implementado:**
- `GET /api/tasks/{id}/weather` - Obtiene pronóstico del clima para la fecha de vencimiento de la tarea

**Características:**
- No requiere API key (servicio público)
- Coordenadas fijas (Madrid: 40.4168, -3.7038)
- Retorna: temperatura máxima, mínima y precipitación
- Manejo de errores si el servicio no está disponible

**Respuesta ejemplo:**
```json
{
  "success": true,
  "data": {
    "task_id": 6,
    "due_date": "2025-11-22T00:00:00Z",
    "weather": {
      "date": "2025-11-25",
      "temperature_max": 11.9,
      "temperature_min": 3.2,
      "precipitation_sum": 0
    }
  }
}
```

### 8. Documentación ✓
**Archivo:** `README.md`

**Contenido:**
- Requisitos del sistema
- Instrucciones de instalación (PostgreSQL y SQLite)
- Configuración de entorno
- Lista completa de endpoints con métodos HTTP
- Ejemplos de uso con PowerShell
- Formato de respuestas
- Reglas de validación
- Explicación de autorización
- Detalles de integración con API externa

---

## 🎯 DEMOSTRACIÓN REALIZADA

### Datos de Prueba Creados:

**3 Usuarios registrados:**
1. Juan Pérez (juan@example.com) - 4 tareas
2. María García (maria@example.com) - 2 tareas
3. Carlos López (carlos@example.com) - 2 tareas

**8 Tareas totales:**
- 2 completadas (status: completed)
- 2 en progreso (status: in_progress)
- 4 pendientes (status: pending)

### Pruebas Ejecutadas ✓

1. **Autenticación:**
   - ✓ Registro de 3 usuarios con tokens generados
   - ✓ Login exitoso con generación de nuevo token
   - ✓ Logout con revocación de token
   - ✓ Obtención de perfil de usuario

2. **CRUD Completo:**
   - ✓ Creación de tarea (POST)
   - ✓ Lectura de tarea específica (GET)
   - ✓ Actualización de tarea (PATCH)
   - ✓ Eliminación de tarea (DELETE)
   - ✓ Listado con paginación

3. **Validaciones:**
   - ✓ Campo title requerido (retorna error 422)
   - ✓ Password debe tener letras y números (retorna error 422)
   - ✓ Fecha de vencimiento no puede ser pasada (retorna error 422)

4. **Autorización:**
   - ✓ Usuario María intenta acceder a tarea de Juan → 403 Forbidden
   - ✓ Usuarios solo ven sus propias tareas

5. **Paginación:**
   - ✓ Parámetro `per_page=2` funciona correctamente
   - ✓ Metadatos de paginación en respuesta (current_page, last_page, total, etc.)

6. **API Externa:**
   - ✓ Endpoint de clima retorna datos de Open-Meteo
   - ✓ Temperaturas y precipitación obtenidas correctamente

---

## 📂 ESTRUCTURA DEL PROYECTO

```
task-management-api/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── AuthController.php         # Autenticación (register, login, logout, profile)
│   │   │   └── TaskController.php         # CRUD de tareas + weather endpoint
│   │   ├── Requests/
│   │   │   ├── ApiFormRequest.php         # Base class para estandarizar errores
│   │   │   ├── Auth/
│   │   │   │   ├── RegisterRequest.php    # Validación de registro
│   │   │   │   └── LoginRequest.php       # Validación de login
│   │   │   └── Task/
│   │   │       ├── TaskIndexRequest.php   # Validación de paginación
│   │   │       ├── StoreTaskRequest.php   # Validación de creación
│   │   │       └── UpdateTaskRequest.php  # Validación de actualización
│   │   └── Policies/
│   │       └── TaskPolicy.php             # Autorización de tareas
│   ├── Models/
│   │   ├── User.php                       # Modelo User con HasApiTokens
│   │   └── Task.php                       # Modelo Task con relación belongsTo
│   ├── Traits/
│   │   └── ApiResponse.php                # Respuestas JSON estandarizadas
│   └── Providers/
│       └── AppServiceProvider.php         # Registro de Policy
├── database/
│   ├── migrations/
│   │   ├── 0001_01_01_000000_create_users_table.php
│   │   ├── 0001_01_01_000001_create_cache_table.php
│   │   ├── 0001_01_01_000002_create_jobs_table.php
│   │   ├── 2025_11_20_000003_create_tasks_table.php
│   │   └── 2025_11_21_125556_create_personal_access_tokens_table.php
│   └── database.sqlite                    # Base de datos SQLite
├── routes/
│   └── api.php                            # Definición de todos los endpoints
├── .env                                   # Configuración de entorno
├── README.md                              # Documentación completa
├── demo-completa.ps1                      # Script de demostración
└── RESUMEN_PRUEBA_TECNICA.md             # Este archivo
```

---

## 🚀 COMANDOS PARA EJECUTAR

### Iniciar el servidor:
```powershell
cd c:\prueba1\task-management-api
& "C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe" artisan serve --host=127.0.0.1 --port=8001
```

### Ejecutar demostración completa:
```powershell
cd c:\prueba1\task-management-api
.\demo-completa.ps1
```

### Ejemplo de uso manual:

**1. Registrar usuario:**
```powershell
Invoke-RestMethod -Method Post -Uri "http://127.0.0.1:8001/api/register" `
  -Headers @{ "Accept" = "application/json"; "Content-Type" = "application/json" } `
  -Body '{"name":"Test User","email":"test@example.com","password":"Secret123","password_confirmation":"Secret123"}'
```

**2. Crear tarea:**
```powershell
$token = "tu-token-aqui"
Invoke-RestMethod -Method Post -Uri "http://127.0.0.1:8001/api/tasks" `
  -Headers @{ "Authorization" = "Bearer $token"; "Accept" = "application/json"; "Content-Type" = "application/json" } `
  -Body '{"title":"Mi tarea","description":"Descripción","status":"pending","due_date":"2025-11-25"}'
```

**3. Obtener clima:**
```powershell
Invoke-RestMethod -Method Get -Uri "http://127.0.0.1:8001/api/tasks/1/weather" `
  -Headers @{ "Authorization" = "Bearer $token"; "Accept" = "application/json" }
```

---

## 📊 ENDPOINTS COMPLETOS

| Método | Ruta | Descripción | Auth |
|--------|------|-------------|------|
| POST | /api/register | Registro de usuario | No |
| POST | /api/login | Login y emisión de token | No |
| POST | /api/logout | Logout (revoca token) | Sí |
| GET | /api/user | Perfil usuario autenticado | Sí |
| GET | /api/profile | Alias de /api/user | Sí |
| GET | /api/tasks | Listar tareas (paginado) | Sí |
| POST | /api/tasks | Crear tarea | Sí |
| GET | /api/tasks/{id} | Ver tarea específica | Sí |
| PUT | /api/tasks/{id} | Actualizar tarea (completo) | Sí |
| PATCH | /api/tasks/{id} | Actualizar tarea (parcial) | Sí |
| DELETE | /api/tasks/{id} | Eliminar tarea | Sí |
| GET | /api/tasks/{id}/weather | Clima para fecha de tarea | Sí |

**Total: 14 rutas registradas**

---

## 🎓 CARACTERÍSTICAS EXTRAS IMPLEMENTADAS

1. **Respuestas estandarizadas** con trait reutilizable
2. **Base class para Form Requests** que automatiza el formato de errores
3. **Driver detection** en migraciones (compatible PostgreSQL/SQLite)
4. **Configuración dual** en README (PostgreSQL o SQLite)
5. **Script de demostración** completo y automatizado
6. **Colores en consola** para mejor visualización
7. **Manejo robusto de errores** con try-catch y mensajes descriptivos
8. **Documentación exhaustiva** con ejemplos funcionales

---

## ✅ CONCLUSIÓN

**Todos los requisitos de la prueba técnica han sido implementados y demostrados:**

✓ Framework Laravel moderno (12.x)  
✓ Autenticación completa con tokens  
✓ CRUD completo de tareas  
✓ Validaciones estrictas según especificación  
✓ Autorización mediante Policy  
✓ Respuestas JSON estandarizadas  
✓ Integración con API externa (Open-Meteo)  
✓ Documentación completa  
✓ Base de datos funcional con datos de prueba  
✓ Script de demostración automatizado  

**Estado:** ✅ **PROYECTO COMPLETADO Y FUNCIONAL**

---

**Fecha de finalización:** 21 de noviembre de 2025  
**Versión Laravel:** 12.10.1  
**Versión PHP:** 8.3.26  
**Base de datos:** SQLite 3 (compatible PostgreSQL)
