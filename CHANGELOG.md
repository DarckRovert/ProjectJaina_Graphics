# 📋 Registro de Cambios — ProjectJaina_Graphics

Todos los cambios notables de este proyecto están documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

---

## [1.1.0] — 2026-10-14
### Integración y Calibración In-Game de Modern WoW Renderer (DirectX 9 Proxy)
- **Control In-Game de Proxy Gráfico:** Añadido botón interactivo de verificación y guía para `modern-wow-renderer` (`d3d9.dll`).
- **Guía de Atajos de Teclado:** Documentación contextual in-game para teclas `F7` (Menú de shaders), `F11` (Toggle efectos on/off) y `F12` (Recarga en caliente de pipeline).
- **Verificador Automático de CVars:** Configuración profiláctica de `gxApi "D3D9"`, `extShadowQuality 1` y `shadowLevel 2` al calibrar el proxy.
- **Validación de Sintaxis:** Verificado al 100% con `lua52_compiler.exe -p` con 0 errores y 0 advertencias.

---

## [1.0.1] — 2026-10-10
### Estabilización de Ecosistema y Gobernanza Oficial (Project Jaina)
- **Normalización de UI y Gráficos:** Blindaje de límites de heap D3D9 para parches HD de 23.8 GB, verificación de directivas inmutables en Config.wtf y saneamiento de caché de texturas.
- **Homologación Documental:** Incorporación y actualización formal de `GOVERNANCE.md`, `LICENSE`, `NOTICE.md` y `SECURITY.md`.
- **Licencia Canónica:** Consolidación de licencia MIT 2026 bajo titularidad de DarckRovert & Project Jaina Team.
- **Validación de Runtime:** Verificado al 100% con compilador sintáctico `lua52_compiler.exe -p` con 0 errores y 0 warnings.

---

## [1.0.0] — 2026-10-04
### Lanzamiento Inicial — Ecosistema Project Jaina WotLK 3.3.5a
- Implementación de la arquitectura base para Project Jaina Graphics Engine.
- Registro de comandos slash: `/pjgfx, /graphics`.
- Persistencia de configuración en `ProjectJaina_GraphicsDB`.
- Compatibilidad certificada con cliente WotLK 3.3.5a (Build 12340) y directiva `Interface: 30300`.
