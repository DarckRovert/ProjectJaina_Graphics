# 🤖 Reglas de Contexto y Memoria para Agentes de IA — Wanos_Graphics

> **Documento Maestro de Arquitectura y Memoria Operativa**  
> **Ámbito:** `Client\Interface\AddOns\Jaina_Graphics\`  
> **Líder del Proyecto:** DarckRovert (Ingame: `Elnazzareno`)  
> **Servidor Destino:** [Project Jaina](https://worldofwanos.com/) — Project Jaina  
> **Entorno de Ejecución:** World of Warcraft 3.3.5a (Build 12340) | Lua 5.1 puro  
> **Versión de Reglas:** 1.0.0 (Octubre 2026)

---

## 1. Principios de Convivencia con el Motor 3.3.5a

1. **Restricción de CVars Protegidas:**
   En 3.3.5a, `SetCVar` para variables de vídeo (`ffxGlow`, `groundEffectDensity`, etc.) puede invocarse en cualquier momento fuera de combate. En combate, algunas CVars están protegidas contra taint de interfaz. Siempre encapsular en `pcall`.

2. **D3D9Ex y Reinicio del Motor:**
   La CVar `gxApi "D3D9Ex"` solo toma efecto al iniciar el ejecutable `Wow.exe` o al llamar a la función de la API de Blizzard `RestartGx()`. La UI debe advertir de esto mediante tooltips explicativos.

3. **Inmunidad de GameMenuFrame:**
   No alterar los `Anchors` de `GameMenuFrame` destructivamente. Utilizar siempre `HookScript("OnShow")` y verificar que la altura no se incremente múltiples veces en un mismo ciclo de visualización.

4. **Persistencia en Config.wtf:**
   El cliente de World of Warcraft 3.3.5a solo persiste variables a disco al cerrarse de manera normal o invocar `ConsoleExec`. Los valores modificados por este addon persisten naturalmente a través del ciclo de vida del juego.
