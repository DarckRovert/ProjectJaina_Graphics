# 📦 Guía de Instalación — Wanos_Graphics

Instrucciones oficiales para instalar y verificar **Wanos_Graphics** en el cliente **World of Warcraft 3.3.5a (Build 12340)** de **Project Jaina - Project Jaina**.

---

## 🚀 Proceso de Instalación

### Método 1: Clonado vía Git (Recomendado)

Abre una terminal PowerShell en el directorio de addons del cliente:

```powershell
cd "E:\ProjectJaina_FHD\Client\Interface\AddOns\"
git clone https://github.com/DarckRovert/Wanos_Graphics.git
```

### Método 2: Instalación Manual

1. Copia la carpeta `Wanos_Graphics` dentro del directorio:
   ```
   Client/Interface/AddOns/Wanos_Graphics/
   ```
2. Asegúrate de que los archivos principales se ubiquen directamente en la raíz de esa carpeta:
   - `Wanos_Graphics.toc`
   - `Core.lua`
   - `UI.lua`

---

## ✅ Verificación In-Game

1. Inicia el juego mediante [Iniciar_Juego_Oficial.bat](file:///E:/ProjectJaina_FHD/Iniciar_Juego_Oficial.bat) o [Iniciar_Juego_Local.bat](file:///E:/ProjectJaina_FHD/Iniciar_Juego_Local.bat).
2. En la pantalla de selección de personajes, haz clic en el botón inferior izquierdo **Accesorios** (*AddOns*) y confirma que **Project Jaina - Gráficos HD** se encuentre marcado.
3. Dentro del mundo, presiona `Escape` y confirma que aparece el botón **✨ Gráficos HD**, o escribe en el chat `/graficos`.
