# 💎 WoWPeru_Graphics — Suite Gráfica HD & Control de Renderizado Nativo

[![Entorno](https://img.shields.io/badge/WoW-3.3.5a%20(Build%2012340)-blue.svg)](https://wow-peru.lat/)
[![Servidor](https://img.shields.io/badge/Servidor-WoW%20Per%C3%BA%20--%20Reino%20Andino-gold.svg)](https://wow-peru.lat/)
[![Licencia](https://img.shields.io/badge/Licencia-MIT-green.svg)](LICENSE)
[![Arquitectura](https://img.shields.io/badge/UI-Flat%20Dark%20Glassmorphism-cyan.svg)](UI.lua)

Suite visual y módulo de ingeniería gráfica nativa para el cliente oficial de **World of Warcraft 3.3.5a (Wrath of the Lich King)** de **WoW Perú - Reino Andino**. 

Permite desbloquear la fidelidad visual cristalina del motor sin necesidad de inyectores DLL externos, wrappers ni software de post-procesamiento (cero ReShade / SweetFX), ofreciendo una interfaz gráfica integrada directamente en el menú del juego.

---

## 🌟 Características Principales

### 1. Nitidez Nativa Pura (Erradicación del Bloom Lechoso)
- **Desactivación de `ffxGlow`:** Elimina el filtro de desenfoque de baja resolución nativo de 2008 que provocaba una capa lechosa en toda la pantalla, devolviendo nitidez píxel a píxel a texturas HD, armaduras y terreno.
- **Claridad de Muerte (`ffxDeath 0`):** Elimina la distorsión borrosa en escala de grises al entrar en estado fantasma.
- **Filtrado Anisótropo en Modelos 3D (`M2ForceBilinear 0`):** En 3.3.5a, los personajes y criaturas usan filtrado bilinear borroso por omisión. Este parámetro fuerza el filtrado anisótropo 16x en todas las mallas `M2`.

### 2. Vegetación y Distancia Extrema
- **Densidad Cuádruple de Césped (`groundEffectDensity 256`):** Multiplica por cuatro la cantidad de vegetación, flores y densidad de suelo respecto al límite clásico de Blizzard (64).
- **Distancia de Vegetación (`groundEffectDist 140`):** Mantiene el follaje visible a gran distancia.
- **Distancia de Visión y Horizonte (`farclip 1277`, `horizonfarclip 3000`):** Elimina la niebla cercana y permite divisar montañas y cielo lejanos con fidelidad panorámica.

### 3. Sombras Dinámicas Reales y Reflejos
- **Sombras Proyectadas 2K (`shadowLevel 2`, `shadowTextureSize 2048`):** Sustituye las sombras circulares planas por sombras proyectadas en tiempo real de personajes, monturas y árboles sobre la geometría del terreno.
- **Ondas Dinámicas en el Agua (`rippleDetail 1`):** Activa perturbaciones físicas en la superficie acuática al nadar o caminar.
- **Reflejos Especulares (`specular 1`) y Texturas Proyectadas (`projectedTextures 1`):** Visibilidad garantizada de áreas de combate y brillo en metales.

### 4. Rendimiento Moderno y Audio
- **Direct3D 9Ex (`gxApi "D3D9Ex"`):** Hace uso del modelo WDDM moderno en Windows 10 y 11, optimizando el intercambio de memoria de vídeo (VRAM) y eliminando micro-tirones y congelamientos al hacer Alt+Tab.
- **Audio Multicanal (`Sound_NumChannels 128`):** Duplica los canales de mezcla acústica para evitar la pérdida de efectos de sonido o música en bandas de 25 jugadores.

---

## 🖥️ Interfaz Visual y Métodos de Acceso

La suite se integra de forma transparente mediante 4 puntos de entrada nativos:

1. **Menú de Escape (`GameMenuFrame`):** Botón directo **`|cFFFFD700✨ Gráficos HD|r`** posicionado junto a *Opciones de vídeo*.
2. **Ventana de Opciones de Vídeo (`VideoOptionsFrame`):** Botón **`✨ Opciones HD`** en la esquina superior derecha.
3. **Opciones de Interfaz de Blizzard:** Categoría en `Escape -> Opciones de Interfaz -> AddOns -> WoW Perú Gráficos HD`.
4. **Comandos de Chat (Slash):**
   - `/graficos`
   - `/graphics`
   - `/hd`
   - `/wpg`

---

## ⚡ Perfiles Rápidos (1 solo clic)

| Perfil | Destinatario | Configuración Clave |
|---|---|---|
| **💎 Ultra HD Nativo** | PCs de escritorio potentes / Máxima fidelidad | Nitidez pura (`ffxGlow 0`), sombras 2K proyectadas, césped 256, horizonte 3000, anisótropo 16x en modelos y audio 128 canales. |
| **⚔️ Raid 25 Competitivo** | Encuentros de banda masivos / 120 FPS fijos | Nitidez pura, césped moderado (64), sombras básicas de bajo coste, áreas de hechizos proyectadas garantizadas y audio 128 canales. |
| **🔄 Original Blizzard** | Modo nostálgico / Hardware de muy bajos recursos | Valores clásicos por defecto del cliente WotLK 3.3.5a original. |

---

## 🏛️ Gobernanza y Estilo de Diseño

- **Arquitectura Visual:** Sistema de diseño plano oscuro *Flat Dark Glassmorphism* acorde a los estándares institucionales de WoW Perú (`#0A0B0E`, bordes `#2C2F38`, acentos oro `#E8B54D` y cian `#00FFCC`).
- **Inmunidad a Taint:** El botón del menú de escape utiliza `HookScript("OnShow")` con cerrojos booleanos idempotentes, evitando alterar la cadena de scripts de Blizzard o colisionar con otros gestores de interfaz como `ACP`.
- **Rendimiento:** Cero saturación de memoria Lua (< 85 KB) y cálculo de telemetría de FPS / memoria pasivo con refresco escalonado a 0.5s.

---

## 👥 Créditos y Autoría

- **Desarrollo & Arquitectura:** DarckRovert (`Elnazzareno`) & Claude Mythos 5 (L9 Staff Engineer).
- **Comunidad & Servidor:** [WoW Perú - Reino Andino](https://wow-peru.lat/)
- **Licencia:** MIT (Código Abierto para la comunidad).
