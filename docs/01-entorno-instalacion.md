# Paso 1 — Entorno listo (Laragon + PHP + Composer)

Esta guía te deja el entorno funcional para crear el proyecto Laravel en Laragon y evitar problemas con OneDrive/Path.

## 1) Verifica Laragon
- Ruta recomendada: `C:\laragon`
- Abre Laragon y pulsa "Start All" para iniciar servicios
- Opcional: en Laragon → Menu → PHP → Version, selecciona PHP 8.x

## 2) Usa PowerShell con PATH temporal (recomendado desde VS Code)
Cierra y vuelve a abrir la terminal de VS Code si abriste Laragon recientemente. Luego ejecuta, línea por línea:

```powershell
# 2.1 Detectar la última versión de PHP de Laragon y añadirla al PATH de esta sesión
$phpDir = (Get-ChildItem -Path 'C:\laragon\bin\php' -Directory | Sort-Object Name -Descending | Select-Object -First 1).FullName
$env:Path = "$phpDir;$env:Path"

# 2.2 Añadir Composer de Laragon al PATH de esta sesión
$env:Path = "C:\laragon\bin\composer;$env:Path"

# 2.3 Verificar versiones
php -v
composer --version
```

Si ambos comandos muestran versión, estás listo para crear el proyecto.

Alternativa: desde Laragon → Menu → Tools → Terminal (o "Laragon Console"). Ahí ya viene el PATH configurado.

## 3) Crea el proyecto Laravel fuera de OneDrive
Para evitar problemas de sincronización, crea el proyecto en `C:\laragon\www` (directorio por defecto de Laragon):

```powershell
# 3.1 Asegurar carpeta www y moverte allí
New-Item -ItemType Directory -Path 'C:\laragon\www' -ErrorAction SilentlyContinue | Out-Null
Set-Location 'C:\laragon\www'

# 3.2 Crear el proyecto Laravel
composer create-project laravel/laravel task-management-api

# 3.3 Entrar al proyecto y verificar Artisan
Set-Location .\task-management-api
php artisan --version
```

Si esto funciona, el proyecto quedó listo en `C:\laragon\www\task-management-api`.

## 4) Próximo paso (lo haremos después)
- Configurar PostgreSQL (crear BD y usuario)
- Ajustar `.env` y correr migraciones
- Instalar y configurar Sanctum
- CRUD de Tareas + documentación

Guarda la salida de `php -v`, `composer --version` y `php artisan --version` para el registro.
