# 🛡️ Política de Seguridad — Wanos_Graphics

La seguridad y la integridad del cliente de juego son prioritarias en el ecosistema de **Project Jaina**.

---

## 🔒 Garantías de Seguridad del Módulo

1. **Cero Inyección Binaria:**
   Este addon no inyecta bibliotecas dinámicas (`.dll`), no altera la memoria del proceso `Wow.exe` ni utiliza ganchos del sistema operativo. Toda su lógica opera exclusivamente dentro del entorno aislado de Lua 5.1 del cliente oficial.

2. **Cero Telemetría Externa:**
   El addon no realiza peticiones HTTP/Sockets fuera del juego ni almacena credenciales de usuario.

3. **Inmunidad a Taint de Combate:**
   Las funciones críticas de combate (marcos de banda, botones de acción) no son interceptadas, previniendo errores de *"Interface action failed because of an AddOn"*.

---

## 📢 Reporte de Vulnerabilidades

Si detectas un comportamiento anómalo o posible vector de fallo, repórtalo directamente al equipo de desarrollo en [GitHub](https://github.com/DarckRovert/Wanos_Graphics/issues) o vía Discord del servidor.
