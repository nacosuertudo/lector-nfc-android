# 📱 OBTENER APK DE ANDROID - 3 MÉTODOS

## 🎯 OPCIONES DISPONIBLES

Tienes 3 formas de obtener la APK:

| Método | Dificultad | Tiempo | Requisitos |
|--------|-----------|--------|------------|
| **GitHub Actions** | ⭐ Fácil | 5-10 min | Cuenta GitHub (gratis) |
| **APK Builder Online** | ⭐ Muy Fácil | 3-5 min | Navegador web |
| **Compilación Local** | ⭐⭐⭐ Difícil | 30-60 min | Android Studio |

---

## 🚀 MÉTODO 1: GitHub Actions (RECOMENDADO)

**Compilación automática en la nube - GRATIS**

### Ventajas:
✅ No instalas nada  
✅ Compila en la nube (GitHub)  
✅ APK lista para descargar  
✅ Gratis para repositorios públicos  
✅ Automatizado  

### Pasos:

#### 1. Crear cuenta GitHub (si no tienes)
```
https://github.com/join
```

#### 2. Crear repositorio nuevo
```
1. Click en "+" → "New repository"
2. Nombre: lector-nfc-android
3. ✅ Public
4. Click "Create repository"
```

#### 3. Subir archivos
```bash
# En tu computadora, en la carpeta del proyecto:

# Inicializar git
git init

# Agregar archivos
git add .

# Commit
git commit -m "Initial commit"

# Conectar con GitHub (reemplaza TU-USUARIO)
git remote add origin https://github.com/TU-USUARIO/lector-nfc-android.git

# Subir
git push -u origin main
```

**O usa GitHub Desktop (más fácil):**
```
1. Descarga GitHub Desktop: https://desktop.github.com/
2. File → Add Local Repository
3. Selecciona la carpeta
4. Publish repository
```

#### 4. GitHub Actions compilará automáticamente

```
1. Ve a tu repositorio en GitHub
2. Click en "Actions"
3. Verás "Build Android APK" ejecutándose
4. Espera 5-10 minutos
5. Cuando termine (✅ verde), click en el workflow
6. Sección "Artifacts" → Descarga "app-debug"
```

#### 5. Instala la APK
```
1. Descomprime el ZIP descargado
2. Transfiere app-debug.apk a tu Android
3. Instala
```

**🎉 ¡LISTO! APK compilada en la nube sin instalar nada**

---

## 🌐 MÉTODO 2: APK Builder Online

**Servicios web que compilan por ti**

### Opción A: AppsGeyser (Más Fácil)

**URL:** https://www.appsgeyser.com/

#### Pasos:
```
1. Ve a AppsGeyser
2. Selecciona "Website to App"
3. Sube tu proyecto o ingresa URL
4. Personaliza (nombre, ícono, colores)
5. Click "Create App"
6. Espera 5 minutos
7. Descarga APK
```

**Limitación:** Puede agregar anuncios (versión gratis)

---

### Opción B: Appery.io

**URL:** https://appery.io/

#### Pasos:
```
1. Crea cuenta gratis
2. New App → "Blank App"
3. Sube tus archivos HTML
4. Export → Android
5. Build APK
6. Descarga
```

**Limitación:** Plan gratis limitado

---

### Opción C: Appy Pie

**URL:** https://www.appypie.com/app-builder/appmaker

#### Pasos:
```
1. "Create App Now"
2. Selecciona categoría "Utilities"
3. Diseña la app (arrastra y suelta)
4. Agrega tu código HTML
5. Build para Android
6. Descarga APK
```

**Limitación:** Plan gratis con marca de agua

---

## 🔧 MÉTODO 3: Compilación Local

**Si tienes o quieres instalar Android Studio**

### Requisitos:
- Node.js (https://nodejs.org/)
- Android Studio (https://developer.android.com/studio)
- 10+ GB espacio en disco

### Pasos Completos:

#### 1. Instalar herramientas

**Node.js:**
```bash
# Descarga de: https://nodejs.org/
# Instala versión LTS
```

**Android Studio:**
```bash
# Descarga de: https://developer.android.com/studio
# Durante instalación:
# ✅ Android SDK
# ✅ Android SDK Platform
# ✅ Android Virtual Device
```

**Variables de entorno (Windows):**
```
ANDROID_HOME = C:\Users\TuUsuario\AppData\Local\Android\Sdk
PATH += %ANDROID_HOME%\platform-tools
PATH += %ANDROID_HOME%\tools
```

#### 2. Configurar proyecto

```bash
# En la carpeta android-project/

# Instalar dependencias
npm install

# Agregar plataforma Android
npx cap add android

# Copiar archivos web
npm run copy

# Sincronizar
npx cap sync
```

#### 3. Opción A: Compilar por línea de comandos

**APK de Debug (firmada automáticamente):**
```bash
cd android
./gradlew assembleDebug

# APK estará en:
# android/app/build/outputs/apk/debug/app-debug.apk
```

**APK de Release (requiere firma):**
```bash
cd android
./gradlew assembleRelease

# APK estará en:
# android/app/build/outputs/apk/release/app-release-unsigned.apk
```

#### 4. Opción B: Compilar con Android Studio

```bash
# Abrir proyecto en Android Studio
npx cap open android
```

En Android Studio:
```
1. Build → Build Bundle(s) / APK(s) → Build APK(s)
2. Espera a que compile
3. Click en "locate" cuando termine
4. Copia app-debug.apk
```

#### 5. Firmar APK de Release (opcional)

**Crear Keystore:**
```bash
keytool -genkey -v -keystore lector-nfc.keystore -alias lector-nfc -keyalg RSA -keysize 2048 -validity 10000

# Te pedirá:
# - Contraseña del keystore (guárdala)
# - Nombre, organización, etc.
```

**Firmar APK:**
```bash
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore lector-nfc.keystore app-release-unsigned.apk lector-nfc

# Ingresa la contraseña del keystore
```

**Optimizar (zipalign):**
```bash
zipalign -v 4 app-release-unsigned.apk lector-nfc-release.apk
```

**🎉 APK firmada lista: `lector-nfc-release.apk`**

---

## 📊 COMPARACIÓN DE MÉTODOS

| Característica | GitHub Actions | Online Builder | Local |
|----------------|----------------|----------------|-------|
| Costo | Gratis | Gratis/Pago | Gratis |
| Instalación | ❌ No | ❌ No | ✅ Sí (3GB+) |
| Tiempo | 10 min | 5 min | 1 hora |
| Control | Alto | Bajo | Máximo |
| APK firmada | ✅ | ✅ | ✅ |
| Automatizable | ✅ | ❌ | ✅ |
| Offline | ❌ | ❌ | ✅ |

---

## 🎯 RECOMENDACIONES

### Para principiantes:
👉 **Método 2: APK Builder Online (AppsGeyser)**
- Más fácil
- No instalas nada
- 5 minutos

### Para desarrolladores:
👉 **Método 1: GitHub Actions**
- Profesional
- Gratis
- Automatizado
- Versionado

### Para máximo control:
👉 **Método 3: Compilación Local**
- Control total
- Sin dependencias externas
- Personalización completa

---

## 🚨 PERMISOS NFC

La APK generada automáticamente incluye los permisos NFC necesarios:

```xml
<!-- Incluido automáticamente por Capacitor -->
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc" android:required="true" />
```

No necesitas configurar nada extra.

---

## 📱 INSTALACIÓN EN ANDROID

### Pasos:

1. **Transfiere la APK a tu teléfono**
   ```
   - Via cable USB
   - Via email
   - Via Google Drive
   - Via cualquier método
   ```

2. **Habilita instalación de apps desconocidas**
   ```
   Ajustes → Seguridad → Instalar apps desconocidas
   → [Tu navegador/explorador de archivos] → Permitir
   ```

3. **Abre la APK en tu teléfono**
   ```
   - Explorador de archivos → Descargas → app-debug.apk
   - Click para instalar
   ```

4. **¡Listo!**
   ```
   La app aparecerá en tu cajón de apps
   Ícono: 📱 Lector NFC
   ```

---

## ⚙️ CONFIGURACIÓN AVANZADA

### Cambiar ícono de la app

**Ubicación:** `android/app/src/main/res/`

**Carpetas de íconos:**
```
mipmap-mdpi/ic_launcher.png     (48x48)
mipmap-hdpi/ic_launcher.png     (72x72)
mipmap-xhdpi/ic_launcher.png    (96x96)
mipmap-xxhdpi/ic_launcher.png   (144x144)
mipmap-xxxhdpi/ic_launcher.png  (192x192)
```

**Reemplaza estos archivos con tu ícono**

### Cambiar nombre de la app

**Archivo:** `android/app/src/main/res/values/strings.xml`

```xml
<resources>
    <string name="app_name">Tu Nombre Aquí</string>
    ...
</resources>
```

### Cambiar ID de paquete

**Archivo:** `capacitor.config.json`

```json
{
  "appId": "com.tuempresa.tunombre",
  ...
}
```

Luego vuelve a sincronizar:
```bash
npx cap sync
```

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### "SDK location not found"
```bash
# Crea archivo local.properties en android/
echo "sdk.dir=/ruta/a/tu/Android/Sdk" > android/local.properties
```

### "Gradle build failed"
```bash
# Limpia el proyecto
cd android
./gradlew clean
./gradlew assembleDebug
```

### "Permission denied: gradlew"
```bash
# Dale permisos de ejecución
chmod +x android/gradlew
```

### GitHub Actions falla
```
1. Verifica que todos los archivos estén en el repo
2. Revisa los logs en la pestaña Actions
3. Asegúrate de que android-project/ contenga todo
```

### APK no instala en Android
```
1. Verifica que sea app-debug.apk (firmada automáticamente)
2. Habilita "Instalar apps desconocidas"
3. Si es app-release-unsigned.apk, necesitas firmarla
```

---

## 📦 CONTENIDO DEL PROYECTO

```
android-project/
├── .github/
│   └── workflows/
│       └── build-apk.yml          ← GitHub Actions workflow
├── package.json                    ← Configuración npm
├── capacitor.config.json          ← Configuración Capacitor
├── www/                           ← Archivos web (auto-copiados)
│   ├── index.html
│   ├── lector-*.html
│   ├── manifest.json
│   └── sw.js
└── android/                       ← Proyecto Android (generado)
    └── app/
        └── build/
            └── outputs/
                └── apk/
                    ├── debug/      ← app-debug.apk
                    └── release/    ← app-release.apk
```

---

## 🎉 RESUMEN

### Quiero la APK YA (más fácil):
```
1. Ve a AppsGeyser.com
2. Upload tus archivos
3. Descarga APK
4. Instala
⏱️ 5 minutos
```

### Quiero calidad profesional (recomendado):
```
1. Sube a GitHub
2. GitHub Actions compila automáticamente
3. Descarga APK de Artifacts
4. Instala
⏱️ 10 minutos
```

### Quiero control total:
```
1. Instala Android Studio
2. npm install && npm run setup
3. npm run android:build
4. Instala
⏱️ 60 minutos
```

---

**🎯 Recomendación final:**

Para tu caso (primera vez), usa:
1. **AppsGeyser** (si quieres algo YA)
2. **GitHub Actions** (si quieres calidad profesional gratis)

Ambos métodos NO requieren instalar nada y te dan la APK en menos de 10 minutos.

**¡Elige el método que prefieras y tendrás tu APK lista! 📱✨**
