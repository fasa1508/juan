# Respuestas para la empresa

## Objetivo de la prueba
- Construir una API REST de tareas que demuestre backend, autenticación y consumo de API externa.

## Elecciones tecnológicas y por qué
- PHP (8.3): versión estable, mejoras de rendimiento y tipado; cumple “7.4+”.
- Laravel (12.x): productividad alta, ecosistema maduro, rutas/validación/policies integradas; cumple “Laravel 8+”.
- PostgreSQL (16): consistencia ACID, JSONB, buenas migraciones e índices; cumple “MySQL o PostgreSQL”.
- Laravel Sanctum (4.x): tokens personales simples, integración nativa, menor complejidad operativa que JWT para SPA/API first-party; cumple “JWT o Sanctum”.
- Open‑Meteo API: pública, sin clave, confiable para demostrar consumo de API externa.

## Enfoque de implementación
- Controladores REST + Policies: separación clara y autorización por recurso.
- Form Requests: validaciones consistentes y mensajes uniformes.
- Respuestas JSON estandarizadas: éxito/error con estructura estable.
- Migraciones + Seeders: reproducibilidad del esquema y datos demo.
- Paginación y filtros básicos: uso realista y desempeño predecible.

## Documentación y despliegue
- README con instalación, variables .env, migraciones, seeders, y comandos.
- Instrucciones para PostgreSQL (puerto 5433) y verificación en pgAdmin4.

## Beneficio para la prueba
- Entrega alineada al stack requerido.
- Código mantenible, validado y fácilmente verificable por el evaluador.

## Endpoints implementados
- Autenticación:
	- POST /api/register: registro con validaciones; retorna token.
	- POST /api/login: autenticación; retorna token.
	- POST /api/logout: revoca el token activo.
	- GET /api/profile: datos del usuario autenticado.
- Tareas (requiere token Sanctum):
	- GET /api/tasks: listado paginado del usuario (page, per_page).
	- POST /api/tasks: crea tarea (title, description, status, due_date futuro).
	- GET /api/tasks/{id}: obtiene una tarea propia.
	- PUT /api/tasks/{id}: actualiza campos validados (autorizado).
	- DELETE /api/tasks/{id}: elimina tarea propia.

## Integración con API externa
- Opción elegida: A — Clima.
- Servicio: Open‑Meteo (público, sin API key).
- Por qué: simplicidad, cero fricción y confiable; cumple “API externa”.
- Endpoint: GET /api/tasks/{id}/weather.
- Qué devuelve: clima estimado para la due_date (temp máx/mín, precipitación, estado).
- Cómo se usa: toma due_date, consulta pronóstico diario y normaliza JSON.
- Alternativa OWM: intercambiable agregando `OPENWEATHER_API_KEY` en `.env` y cliente OWM.
- Opción B (email): no elegida para evitar dependencia SMTP/clave y mantener foco.

## Formato de respuestas JSON
- Estructura estándar: `success` (bool) y `data` (objeto recurso). En errores: `success=false` y `errors` (detalle validación/mensaje).
- Usuario (data): `id`, `name`, `email`, `created_at` (ISO 8601, UTC).
- Tarea (data): `id`, `title`, `description`, `status`, `due_date` (YYYY-MM-DD), `user_id`, `created_at`, `updated_at`.
- Estados válidos `status`: `pending`, `in_progress`, `completed`.

## Reglas de negocio y validaciones
- Usuarios:
	- Email único en BD.
	- Contraseña: mínimo 8, letras y números.
	- Nombre: obligatorio, máx. 100 caracteres.
- Tareas:
	- Título: obligatorio, máx. 200 caracteres.
	- Descripción: opcional, máx. 1000 caracteres.
	- Fecha de vencimiento: no anterior a hoy.
	- Status: uno de `pending|in_progress|completed`.
	- Autorización: cada usuario solo ve/modifica sus propias tareas.
- Autenticación:
	- Laravel Sanctum.
	- Header: `Authorization: Bearer {token}`.
	- Expiración: configurable vía `config/sanctum.php` (recomendada en producción).
