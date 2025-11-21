## Task Management API

API REST construida con Laravel y Sanctum para gestión de tareas de usuarios autenticados.

### Requisitos
- PHP 8.3+
- Composer
- PostgreSQL 16 (o compatible) / SQLite 3+

### Instalación
```bash
composer install
cp .env.example .env
php artisan key:generate
```

**Opción A: PostgreSQL**  
Configura en `.env` la conexión PostgreSQL:
```
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=task_management
DB_USERNAME=postgres
DB_PASSWORD=secret
```

**Opción B: SQLite (desarrollo rápido)**  
En `.env`:
```
DB_CONNECTION=sqlite
# DB_DATABASE se configura automáticamente a database/database.sqlite
```
Crea el archivo:
```bash
touch database/database.sqlite  # Linux/Mac
# o
New-Item database/database.sqlite  # Windows PowerShell
```

Luego:
```bash
php artisan migrate
php artisan serve --host=127.0.0.1 --port=8001
```

### Autenticación
Se utiliza Laravel Sanctum mediante tokens personales. En `/api/login` se obtiene `access_token` que se envía como:
```
Authorization: Bearer <token>
```

### Endpoints Principales
| Método | Ruta | Descripción |
|--------|------|-------------|
| POST | /api/register | Registro de usuario |
| POST | /api/login | Login y emisión de token |
| POST | /api/logout | Logout (revoca token) |
| GET | /api/user | Perfil usuario |
| GET | /api/tasks | Listar tareas (paginado) |
| POST | /api/tasks | Crear tarea |
| GET | /api/tasks/{id} | Ver tarea |
| PUT/PATCH | /api/tasks/{id} | Actualizar tarea |
| DELETE | /api/tasks/{id} | Eliminar tarea |
| GET | /api/tasks/{id}/weather | Clima aproximado para fecha de vencimiento |

### Formato de Respuesta
Éxito:
```json
{
  "success": true,
  "data": { ... }
}
```
Error:
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": { "campo": ["mensaje"] }
}
```

### Validaciones Clave
- Nombre: max 100
- Password: mínimo 8, al menos letras y números
- Tarea: título max 200, descripción max 1000, `due_date` no anterior a hoy, `status` en `pending|in_progress|completed`.

### Política de Acceso
Las tareas pertenecen al usuario autenticado; se aplica Policy para ver/editar/borrar sólo propias.

### Integración Externa (Weather)
Se consulta Open-Meteo (sin API key) para mostrar datos básicos diarios según fecha `due_date`.

### Ejemplo Creación de Tarea (PowerShell)
```powershell
$token = "<TOKEN>"
$task = @{ title = "Primera"; description = "Desc"; status = "pending"; due_date = (Get-Date).AddDays(2).ToString("yyyy-MM-dd") } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri "http://127.0.0.1:8001/api/tasks" -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } -Body $task
```

### Próximos Pasos
- Tests automatizados Feature & Unit
- Mejora de manejo de errores global
<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework. You can also check out [Laravel Learn](https://laravel.com/learn), where you will be guided through building a modern Laravel application.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Redberry](https://redberry.international/laravel-development)**
- **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
