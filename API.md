# 🔌 Documentación de API — WoWPeru_Graphics

Interfaz pública y funciones de control del módulo `WoWPeru_Graphics`.

---

## 1. Espacio de Nombres Global

Toda la funcionalidad pública se exporta bajo la tabla global:

```lua
WoWPeru_Graphics = WoWPeru_Graphics or {}
```

---

## 2. Métodos Públicos

### `WPG:ToggleUI()`
Abre o cierra la ventana principal de la suite gráfica. Si la ventana no ha sido creada aún, ejecuta `CreateMainUI()` de forma perezosa (*lazy initialization*).

```lua
WoWPeru_Graphics:ToggleUI()
```

---

### `WPG:ApplyPreset(presetKey)`
Aplica en caliente un perfil de renderizado completo, ejecutando las llamadas `SetCVar` pertinentes y refrescando los controles visuales.

- **Parámetros:**
  - `presetKey` *(string)*: `"ultra"`, `"raid"`, o `"classic"`.

```lua
-- Ejemplo: Forzar modo ultra fidelidad desde un macro u otro addon
WoWPeru_Graphics:ApplyPreset("ultra")
```

---

### `WPG:SetCVar(cvar, value)`
Aplica de forma segura un valor a una CVar del cliente, utilizando `pcall` y cayendo a `ConsoleExec` si el entorno restringe la llamada nativa.

- **Parámetros:**
  - `cvar` *(string)*: Nombre de la variable de consola (ej. `"ffxGlow"`, `"groundEffectDensity"`).
  - `value` *(string|number)*: Valor a establecer.

---

### `WPG:GetCVar(cvar, default)`
Consulta el valor actual de una CVar como cadena de texto, retornando `default` si el valor es nulo o vacío.

---

### `WPG:GetCVarNum(cvar, default)`
Consulta y convierte numéricamente una CVar, retornando el número o el valor predeterminado si no es convertible.

---

### `WPG:GetCVarBool(cvar, default)`
Evalúa una CVar como booleano (`"1"` o `1` -> `true`).
