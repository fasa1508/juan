# PROMPT PARA COPILOT EN NUEVO CHAT

Hola, estoy trabajando en un proyecto de API REST de gestión de tareas con Laravel y PostgreSQL.

**INSTRUCCIÓN CRÍTICA: ANTES DE RESPONDER, LEE COMPLETAMENTE EL ARCHIVO `CONTEXTO_COMPLETO_PROYECTO.md` QUE ESTÁ EN ESTE MISMO DIRECTORIO. ESE ARCHIVO CONTIENE TODO EL HISTORIAL DEL PROYECTO, PROBLEMAS RESUELTOS, CONFIGURACIONES ACTUALES Y EL ESTADO EXACTO EN EL QUE NOS QUEDAMOS.**

## Contexto rápido:

- **Proyecto Laravel 12** ubicado en: `C:\laragon\www\task-management-api`
- **PostgreSQL 16** corriendo en `C:\pgdata\16` (puerto 5432)
- **Base de datos:** `task_db` con usuario `task_user` / password `task_pass_2024`
- **Migraciones:** Todas las tablas base de Laravel + `personal_access_tokens` (Sanctum) ya creadas
- **Laravel Sanctum:** Instalado y configurado parcialmente

## Estado actual:

Acabamos de completar la instalación de Sanctum (paquete instalado, configuración publicada, migración ejecutada). 

**Próximo paso inmediato:** Configurar el modelo User con el trait `HasApiTokens` y crear el AuthController para manejar registro/login.

## Lo que necesito:

Continuar con la configuración de Sanctum paso a paso:
1. Modificar `app/Models/User.php` para agregar `HasApiTokens`
2. Crear `AuthController` con métodos de registro, login, logout
3. Configurar rutas API de autenticación
4. Probar que funcione

**Después de eso:** Implementar el CRUD completo de tareas (modelo Task, controlador, rutas, policies).

## Importante:

- Estoy moviendo el proyecto fuera de OneDrive para evitar conflictos
- El workspace correcto a abrir en VS Code es: `C:\laragon\www\task-management-api`
- PostgreSQL tuvo que reinicializarse en un cluster limpio por conflictos previos
- Todo está funcionando correctamente ahora (base de datos conectada, migraciones exitosas)

**Por favor, lee el archivo `CONTEXTO_COMPLETO_PROYECTO.md` para entender todo el historial y continúa desde donde quedamos. Trabaja paso a paso, esperando mi confirmación antes de avanzar al siguiente paso.**

¿Estás listo para continuar? Primero confirma que leíste el archivo de contexto y dime cuál es el siguiente paso específico que vamos a realizar.
