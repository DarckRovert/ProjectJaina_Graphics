# 🌐 Registro de Ecosistema — WoWPeru_Graphics

Ficha técnica oficial de registro en la infraestructura multi-addon de **WoW Perú - Reino Andino**.

---

## 1. Identidad del Addon en el Ecosistema

| Campo | Valor |
|---|---|
| **Nombre Técnico** | `WoWPeru_Graphics` |
| **Carpeta Local** | `WoWPeru_Graphics` |
| **Versión Actual** | `1.0.0` |
| **Clasificación** | Cliente / Motor Gráfico & Renderizado Nativo |
| **Licencia Formal** | MIT |
| **Repositorio GitHub** | [WoWPeru_Graphics](https://github.com/DarckRovert/WoWPeru_Graphics) |
| **Entorno de Juego** | World of Warcraft 3.3.5a (Build 12340) / WotLK |
| **Persistencia** | `WoWPeruGraphics_DB` (por cuenta / `SavedVariables`) |

---

## 2. Garantías de Rendimiento y Arquitectura

- **Tiempo de Cuadro:** < 0.005 ms por frame.
- **Memoria en Tiempo de Ejecución:** < 85 KB de memoria Lua.
- **Inmunidad a Taint:** El addon utiliza `HookScript` en lugar de sobrescribir `SetScript` y no toca tablas de acciones protegidas en combate.
- **Compatibilidad con Cabinas de Internet:** Los perfiles se sincronizan directamente con las variables de consola del motor (`SetCVar`), permitiendo que las configuraciones persistan en `Config.wtf` al cerrar el cliente.

---

## 3. Matriz de Integración del Ecosistema

| Módulo Coexistente | Modo de Interacción | Flujo de Datos |
|---|---|---|
| **`Config.wtf`** | Sincronización Bidireccional | Lee y escribe variables de renderizado nativo en el archivo de configuración del juego. |
| **`cDF` (DragonflightUI)** | Coexistencia Armónica | Provee nitidez máxima a las texturas 2x de la interfaz sin interferir con la barra de acción o micromenús. |
| **`ACP` (Addon Control Panel)** | Inmunidad de Anclaje | Convive de forma limpia en `GameMenuFrame` sin colisión de alturas ni rotura de botones de Desconectar. |
| **`WoWPeru_Companion`** | Telemetría | Provee un entorno con alta tasa de cuadros para el renderizado de badges e interfaces sociales. |
