# 📱 Lector NFC - Proyecto Android v2.0

## 🎯 OBTENER LA APK - 3 OPCIONES

### ⭐ OPCIÓN 1: GitHub Actions (Recomendado - MÁS FÁCIL)
**Compilación automática en la nube - GRATIS - Sin instalar nada**

```
1. Sube este proyecto a GitHub
2. GitHub Actions compila automáticamente
3. Descarga la APK de "Artifacts"
4. Instala en Android

⏱️ Tiempo: 10 minutos
💰 Costo: GRATIS
🛠️ Instalación: NADA
```

**📖 Guía completa:** `COMO-OBTENER-APK.md` (Método 1)

---

### ⭐⭐ OPCIÓN 2: APK Builder Online (MÁS RÁPIDO)
**Servicios web que compilan por ti**

```
1. Ve a AppsGeyser.com o similar
2. Sube tus archivos
3. Descarga APK
4. Instala

⏱️ Tiempo: 5 minutos
💰 Costo: GRATIS (con anuncios)
🛠️ Instalación: NADA
```

**📖 Guía completa:** `COMO-OBTENER-APK.md` (Método 2)

---

### ⭐⭐⭐ OPCIÓN 3: Compilación Local
**Si tienes Android Studio instalado**

**Windows:**
```cmd
generar-apk.bat
```

**Linux/Mac:**
```bash
chmod +x generar-apk.sh
./generar-apk.sh
```

**Manual:**
```bash
npm install
npx cap add android
npm run copy
npx cap sync
cd android
./gradlew assembleDebug
```

**📖 Guía completa:** `COMO-OBTENER-APK.md` (Método 3)

---

## 📁 ESTRUCTURA DEL PROYECTO

```
android-project/
├── 📄 README.md                    ← Estás aquí
├── 📖 COMO-OBTENER-APK.md          ← Guía detallada (LEE ESTO)
│
├── 🔧 Configuración:
│   ├── package.json                ← Dependencias npm
│   ├── capacitor.config.json       ← Config Capacitor
│   ├── generar-apk.bat             ← Script Windows
│   └── generar-apk.sh              ← Script Linux/Mac
│
├── 🌐 Archivos Web (www/):
│   ├── index.html                  ← Menú principal
│   ├── lector-estandar.html
│   ├── lector-identificacion.html
│   ├── lector-debug.html
│   ├── lector-avanzado.html
│   ├── guia-visual-nfc.html
│   ├── manifest.json
│   └── sw.js
│
├── 🤖 Proyecto Android (android/):
│   ├── app/
│   │   └── build/
│   │       └── outputs/
│   │           └── apk/
│   │               ├── debug/      ← app-debug.apk (aquí)
│   │               └── release/    ← app-release.apk (aquí)
│   └── ...
│
└── ⚙️ GitHub Actions (.github/):
    └── workflows/
        └── build-apk.yml           ← Compilación automática
```

---

## 🚀 INICIO RÁPIDO

### Si NO quieres instalar nada:

```
1. Lee: COMO-OBTENER-APK.md
2. Usa: Método 1 (GitHub Actions) o Método 2 (Online)
3. Descarga APK
4. Instala
```

### Si tienes Android Studio:

**Windows:**
```cmd
1. Doble click en: generar-apk.bat
2. Opción 1: Setup inicial
3. Opción 2: Compilar APK Debug
4. Instala app-debug.apk
```

**Linux/Mac:**
```bash
chmod +x generar-apk.sh
./generar-apk.sh
# Opción 1: Setup inicial
# Opción 2: Compilar APK Debug
# Instala app-debug.apk
```

---

## 📦 APK GENERADAS

### app-debug.apk (Desarrollo)
- **Ubicación:** `android/app/build/outputs/apk/debug/`
- **Firmada:** ✅ Automáticamente
- **Instalable:** ✅ Directamente
- **Tamaño:** ~10-15 MB
- **Para:** Pruebas y uso personal

### app-release-unsigned.apk (Producción)
- **Ubicación:** `android/app/build/outputs/apk/release/`
- **Firmada:** ❌ Requiere firma manual
- **Instalable:** ❌ Solo después de firmar
- **Tamaño:** ~7-10 MB (optimizada)
- **Para:** Distribución y Google Play

**💡 Recomendación:** Usa `app-debug.apk` para uso personal

---

## 🔧 REQUISITOS

### Para compilar localmente:
- ✅ Node.js 16+ (https://nodejs.org/)
- ✅ Android Studio (https://developer.android.com/studio)
- ✅ 10+ GB espacio en disco
- ✅ Windows, Mac o Linux

### Para GitHub Actions o Online:
- ✅ Navegador web
- ✅ Conexión a internet
- ❌ **NO necesitas instalar nada**

---

## ⚙️ CONFIGURACIÓN

### Cambiar nombre de la app

**Archivo:** `capacitor.config.json`
```json
{
  "appName": "Tu Nombre Aquí"
}
```

### Cambiar ID del paquete

**Archivo:** `capacitor.config.json`
```json
{
  "appId": "com.tuempresa.tunombre"
}
```

### Cambiar ícono

Reemplaza los archivos en:
```
android/app/src/main/res/mipmap-*/ic_launcher.png
```

Tamaños:
- mdpi: 48x48
- hdpi: 72x72
- xhdpi: 96x96
- xxhdpi: 144x144
- xxxhdpi: 192x192

---

## 🛠️ COMANDOS ÚTILES

```bash
# Setup inicial
npm run setup

# Copiar archivos web
npm run copy

# Sincronizar
npx cap sync

# Compilar APK Debug
npm run android:build-debug

# Compilar APK Release
npm run android:build

# Abrir en Android Studio
npx cap open android

# Limpiar proyecto
cd android && ./gradlew clean && cd ..
```

---

## 📱 INSTALACIÓN EN ANDROID

1. **Copia la APK a tu teléfono**
   ```
   Via USB, email, Drive, etc.
   ```

2. **Habilita "Instalar apps desconocidas"**
   ```
   Ajustes → Seguridad → Fuentes desconocidas
   ```

3. **Abre la APK**
   ```
   Explorador de archivos → app-debug.apk
   ```

4. **Instala**
   ```
   Click en "Instalar"
   ```

---

## 🔐 PERMISOS NFC

La app requiere y solicita automáticamente:

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc" android:required="true" />
```

**No necesitas configurar nada extra** - Capacitor lo maneja automáticamente.

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### "Node no reconocido"
```
Instala Node.js desde: https://nodejs.org/
```

### "npm install falla"
```bash
# Limpia cache
npm cache clean --force
rm -rf node_modules
npm install
```

### "gradlew no funciona"
```bash
# Dale permisos (Linux/Mac)
chmod +x android/gradlew

# En Windows, usa:
android\gradlew.bat
```

### "SDK location not found"
```bash
# Crea android/local.properties
echo "sdk.dir=/ruta/a/Android/Sdk" > android/local.properties
```

### "APK no instala"
```
1. Verifica que sea app-debug.apk (firmada)
2. Habilita "Instalar apps desconocidas"
3. Si es release, necesitas firmarla primero
```

### "GitHub Actions falla"
```
1. Verifica que todos los archivos estén en el repo
2. Incluye la carpeta android-project/ completa
3. Revisa logs en Actions tab
```

---

## 🎯 RECOMENDACIONES

### Primera vez - Sin conocimientos técnicos:
👉 **Usa AppsGeyser.com**
- No instalas nada
- 5 minutos
- APK lista

### Primera vez - Con conocimientos técnicos:
👉 **Usa GitHub Actions**
- Profesional
- Gratis
- Automatizado
- Versionado

### Desarrollo continuo:
👉 **Compilación Local**
- Más rápido
- Control total
- Sin dependencias online

---

## 📊 COMPARACIÓN: PWA vs APK

| Característica | PWA | APK |
|----------------|-----|-----|
| Instalación | Navegador | Google Play / Manual |
| Tamaño | ~500 KB | ~10 MB |
| Actualizaciones | Automáticas | Manual / Play Store |
| Permisos NFC | ✅ | ✅ |
| Funciona offline | ✅ | ✅ |
| Ícono en inicio | ✅ | ✅ |
| Notificaciones | ⚠️ Limitado | ✅ Completo |
| Acceso completo | ⚠️ Limitado | ✅ Total |
| Compatibilidad | Chrome/Edge | Todos los Android |

**💡 Ambas versiones funcionan igual para NFC**

La diferencia principal es que la APK:
- Se instala como app "real"
- Funciona en todos los navegadores
- Puede tener más permisos si lo necesitas

---

## 📚 DOCUMENTACIÓN ADICIONAL

- **COMO-OBTENER-APK.md** - Guía detallada con 3 métodos
- **capacitor.config.json** - Configuración de la app
- **package.json** - Dependencias y scripts
- **.github/workflows/build-apk.yml** - Automatización

---

## 🆘 SOPORTE

### Documentación Oficial:
- Capacitor: https://capacitorjs.com/docs
- Android Studio: https://developer.android.com/docs
- GitHub Actions: https://docs.github.com/actions

### Problemas Comunes:
Lee `COMO-OBTENER-APK.md` - Sección "Solución de Problemas"

---

## ✨ CARACTERÍSTICAS

### ✅ Incluido en la APK:
- 📱 Menú principal de navegación
- 🔵 Lector estándar (tokens NFC)
- 🆔 Lector identificación (tarjetas ID)
- 🔍 Lector debug (diagnóstico)
- ⚡ Lector avanzado (lectura + escritura)
- 📍 Guía visual de posicionamiento
- 🔄 Funcionalidad offline completa
- 📡 Timer visual de espera
- ✅ Sin error de timeout falso

---

## 🎉 RESUMEN

### Para obtener la APK (elige uno):

1. **No quiero instalar nada:**
   ```
   → AppsGeyser.com (5 minutos)
   → GitHub Actions (10 minutos)
   ```

2. **Tengo Android Studio:**
   ```
   → generar-apk.bat/sh
   → Opción 2: Compilar Debug
   ```

3. **Soy desarrollador:**
   ```
   → npm run setup
   → npm run android:build-debug
   ```

**Resultado:** `app-debug.apk` lista para instalar

---

**🚀 ¡Tu app Android está lista! Solo elige el método y obtén la APK!**
