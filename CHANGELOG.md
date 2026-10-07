# 📝 Registro de Cambios — WoWPeru_Graphics

Todas las modificaciones notables a este proyecto se documentan en este archivo.  
El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/) y sigue [SemVer](https://semver.org/).

---

## [1.0.2] — 2026-10-07

### 🐛 Corregido (Alineación de UI & Anclaje de Menú Nativo)
- **Corrección de Cadena de Anclaje en `GameMenuFrame`:** Reanclado quirúrgico del botón `GameMenuButtonSoundOptions` ("Sonido") inmediatamente debajo de `GameMenuButton_WoWPeruGraphics` ("Gráficos HD"), y `GameMenuButtonUIOptions` ("Interfaz") debajo de Sonido. Elimina la superposición visual donde Gráficos HD se dibujaba sobre Sonido.
- **Incremento Determinista de Altura de Menú:** Asegurada expansión de 22 px en `GameMenuFrame` con cerrojo de ejecución única para alojar el nuevo botón sin recortar el marco inferior ni colisionar con ACP / Accesorios.
- **Saneamiento de Glifos Unicode (Eliminación de `?`):** Erradicados emojis incompatibles con la tipografía oficial `FRIZQT__.TTF` de 3.3.5a (`✨`, `💎`, `⚔️`, `🔄`, `⚡`) en botones de GameMenuFrame, VideoOptionsFrame y perfiles rápidos, asegurando renderizado tipográfico nativo libre de caracteres corruptos.

## [1.0.1] — 2026-10-07

### 🐛 Corregido (Diagnóstico Forense Error #132)
- **Eliminación de `componentTextureLevel`:** Se erradicó la CVar experimental que provocaba desbordamiento de buffer en el blitter de texturas de personajes (`0x00411EB7`, vector SSE2 `movdqa [edi], xmm0`).
- **Saneamiento Estricto de CVars en `Core.lua` y `UI.lua`:** Reemplazadas variables inexistentes del motor (`shadowTextureSize`, `M2ForceBilinear`, `rippleDetail`, `horizonfarclip`) por sus equivalentes nativos certificados del binario `Wow.exe` 12340 (`mapShadows`, `waterRipples`, `M2Faster`, `environmentDetail`).
- **Estabilidad de GPU AMD Radeon 780M:** Configurado `gxApi "D3D9"` y niveles de sombras nativos como estándar de máxima robustez para controladores modernos en Windows 11.
- **Suite de Pruebas:** Ampliada la suite `test_graphics_sanity.py` con lista negra y verificación de lista blanca de CVars.

## [1.0.0] — 2026-10-07

### ✨ Añadido
- **Suite Gráfica In-Game:** Creación del módulo oficial `WoWPeru_Graphics` con panel visual interactivo de 3 columnas estilo *Flat Dark Glassmorphism*.
- **Presets Rápidos de 1 Clic:**
  - `💎 Ultra HD Nativo`: Nitidez absoluta, sombras proyectadas 2K, vegetación cuádruple (256) y audio 128 canales.
  - `⚔️ Raid 25 Competitivo`: Claridad táctica y optimización para 120 FPS estables en combate masivo.
  - `🔄 Original Blizzard`: Restablecimiento de los valores predeterminados de 2008.
- **Controles de Post-procesado:**
  - Checkbox interactivo para supresión de `ffxGlow` (eliminación del bloom lechoso borroso).
  - Checkbox para claridad en estado fantasma (`ffxDeath`).
  - Checkbox para forzar filtrado anisótropo 16x en modelos 3D `M2` (`M2ForceBilinear 0`).
  - Controles para ondas dinámicas en el agua (`rippleDetail`), texturas proyectadas y brillo especular.
- **Controles de Entorno y Vegetación:**
  - Deslizador de densidad de césped (`groundEffectDensity`) con rango ampliado de 16 a 256 en pasos limpios de 16.
  - Deslizadores de distancia de vegetación (`groundEffectDist`), visión máxima (`farclip`) y horizonte (`horizonfarclip`).
  - Deslizador de tasa de refresco (`maxFPS`) de 0 a 240, reconociendo el valor 0 como FPS Ilimitado.
- **Controles de Sombras, Motor y Audio:**
  - Selector táctil de 4 niveles de sombra dinámica (Desactivada, Básica, Dinámica 1024, Ultra 2048px) con resaltado visual del estado activo.
  - Selector de API gráfica DirectX (`D3D9Ex` vs `D3D9`).
  - Selector de canales de mezcla acústica (32, 64, 128 canales).
  - Botón de reinicio inmediato de subsistema gráfico (`RestartGx`).
- **Integraciones Nativas:**
  - Inyección del botón `|cFFFFD700✨ Gráficos HD|r` en el menú de escape (`GameMenuFrame`) mediante `HookScript("OnShow")` con cerrojo idempotente anti-desincronización de altura.
  - Botón `✨ Opciones HD` en la cabecera superior derecha de `VideoOptionsFrame`.
  - Registro de categoría en el panel de Blizzard (`InterfaceOptions_AddCategory`).
  - Comandos slash `/graficos`, `/graphics`, `/hd` y `/wpg`.
- **Telemetría en Vivo:**
  - Monitor en tiempo real de FPS y uso de memoria Lua en el pie de página de la ventana con tasa de refresco desacoplada a 0.5s.
