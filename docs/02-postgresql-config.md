# Paso 2 — Configuración de PostgreSQL

Este paso prepara la base de datos que usará Laravel.

## 1) Verificar si PostgreSQL ya está en Laragon
- Revisa si existe carpeta: `C:\laragon\bin\postgresql`
- En Laragon: Menu → PostgreSQL (si aparece el submenú, está instalado)

Si NO está:
1. Descarga instalador: https://www.postgresql.org/download/windows/
2. Instala con valores por defecto (puerto 5432).
3. Anota contraseña del usuario `postgres` (administrador).

## 2) Abrir consola psql
Opción Laragon (si lo trae): Menu → PostgreSQL → psql

Manual (ajusta XX a la versión instalada):
```powershell
"C:\laragon\bin\postgresql\postgresql-XX\bin\psql.exe" -U postgres
```
Te pedirá contraseña de postgres.

## 3) Crear base de datos y usuario para la API
Dentro de psql ejecuta (copia y pega una línea a la vez):
```sql
CREATE DATABASE task_db;
CREATE USER task_user WITH PASSWORD 'TuPasswordSegura123';
GRANT ALL PRIVILEGES ON DATABASE task_db TO task_user;
```
Luego salir:
```sql
\q
```

Puedes cambiar la contraseña por otra segura. Anótala.

## 4) Datos que guardaremos para .env
```
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=task_db
DB_USERNAME=task_user
DB_PASSWORD=TuPasswordSegura123
```

## 5) Próximo paso (después de confirmar esto)
- Actualizar `.env` en el proyecto Laravel.
- Ejecutar `php artisan migrate` para validar conexión.

## 6) Qué debes enviarme ahora
- ¿Existe ya PostgreSQL en Laragon? (Sí/No)
- ¿Se crearon correctamente la base `task_db` y el usuario `task_user`? (Sí/No)
- Si hubo error, copia el mensaje.

Responde con esos tres puntos para avanzar al ajuste del `.env`.
