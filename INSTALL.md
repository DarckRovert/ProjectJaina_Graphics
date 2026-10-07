# 📦 Guía de Instalación — WoWPeru_Graphics

Instrucciones oficiales para instalar y verificar **WoWPeru_Graphics** en el cliente **World of Warcraft 3.3.5a (Build 12340)** de **WoW Perú - Reino Andino**.

---

## 🚀 Proceso de Instalación

### Método 1: Clonado vía Git (Recomendado)

Abre una terminal PowerShell en el directorio de addons del cliente:

```powershell
cd "E:\WoW_Peru_FHD\Client\Interface\AddOns\"
git clone https://github.com/DarckRovert/WoWPeru_Graphics.git
```

### Método 2: Instalación Manual

1. Copia la carpeta `WoWPeru_Graphics` dentro del directorio:
   ```
   Client/Interface/AddOns/WoWPeru_Graphics/
   ```
2. Asegúrate de que los archivos principales se ubiquen directamente en la raíz de esa carpeta:
   - `WoWPeru_Graphics.toc`
   - `Core.lua`
   - `UI.lua`

---

## ✅ Verificación In-Game

1. Inicia el juego mediante [Iniciar_Juego_Oficial.bat](file:///E:/WoW_Peru_FHD/Iniciar_Juego_Oficial.bat) o [Iniciar_Juego_Local.bat](file:///E:/WoW_Peru_FHD/Iniciar_Juego_Local.bat).
2. En la pantalla de selección de personajes, haz clic en el botón inferior izquierdo **Accesorios** (*AddOns*) y confirma que **WoW Perú - Gráficos HD** se encuentre marcado.
3. Dentro del mundo, presiona `Escape` y confirma que aparece el botón **✨ Gráficos HD**, o escribe en el chat `/graficos`.
