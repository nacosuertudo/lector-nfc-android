#!/bin/bash

echo "========================================"
echo "  GENERADOR DE APK - Lector NFC"
echo "========================================"
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Node.js no está instalado"
    echo ""
    echo "Descarga desde: https://nodejs.org/"
    exit 1
fi

echo -e "${GREEN}[OK]${NC} Node.js detectado: $(node --version)"
echo ""

# Menú principal
menu() {
    echo "========================================"
    echo "  OPCIONES"
    echo "========================================"
    echo ""
    echo "1. Setup inicial (primera vez)"
    echo "2. Compilar APK Debug (rápido)"
    echo "3. Compilar APK Release (producción)"
    echo "4. Abrir en Android Studio"
    echo "5. Limpiar y recompilar"
    echo "6. Ver archivos generados"
    echo "7. Salir"
    echo ""
    read -p "Selecciona una opción (1-7): " opcion

    case $opcion in
        1) setup ;;
        2) debug ;;
        3) release ;;
        4) studio ;;
        5) clean ;;
        6) files ;;
        7) exit 0 ;;
        *) echo "Opción inválida"; menu ;;
    esac
}

setup() {
    echo ""
    echo -e "${YELLOW}[1/5]${NC} Instalando dependencias..."
    npm install || error

    echo -e "${YELLOW}[2/5]${NC} Agregando plataforma Android..."
    npx cap add android 2>/dev/null || echo "[NOTA] La plataforma ya existe, continuando..."

    echo -e "${YELLOW}[3/5]${NC} Copiando archivos web..."
    mkdir -p www
    cp ../*.html www/ 2>/dev/null || true
    cp ../manifest.json www/ 2>/dev/null || true
    cp ../sw.js www/ 2>/dev/null || true

    echo -e "${YELLOW}[4/5]${NC} Sincronizando..."
    npx cap sync || error

    echo -e "${YELLOW}[5/5]${NC} Configurando permisos..."
    cd android
    chmod +x gradlew 2>/dev/null || true
    cd ..

    echo ""
    echo "========================================"
    echo "  SETUP COMPLETADO"
    echo "========================================"
    echo ""
    echo "Ahora puedes:"
    echo "- Compilar APK Debug (opción 2)"
    echo "- Abrir en Android Studio (opción 4)"
    echo ""
    read -p "Presiona Enter para continuar..."
    menu
}

debug() {
    echo ""
    echo -e "${YELLOW}[1/3]${NC} Sincronizando archivos..."
    npx cap sync || error

    echo -e "${YELLOW}[2/3]${NC} Compilando APK Debug..."
    cd android
    chmod +x gradlew
    ./gradlew assembleDebug || error
    cd ..

    echo -e "${YELLOW}[3/3]${NC} Buscando APK..."
    APK_PATH="android/app/build/outputs/apk/debug/app-debug.apk"
    if [ -f "$APK_PATH" ]; then
        echo ""
        echo "========================================"
        echo "  APK GENERADA"
        echo "========================================"
        echo ""
        echo "Ubicación: $APK_PATH"
        echo "Tamaño: $(ls -lh $APK_PATH | awk '{print $5}')"
        echo ""
        echo "Ya puedes instalarla en tu Android"
        echo ""
        
        # Abrir carpeta (según sistema)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "android/app/build/outputs/apk/debug"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open "android/app/build/outputs/apk/debug" 2>/dev/null || echo "Carpeta: android/app/build/outputs/apk/debug"
        fi
    else
        echo -e "${RED}[ERROR]${NC} No se generó la APK"
        error
    fi
    
    read -p "Presiona Enter para continuar..."
    menu
}

release() {
    echo ""
    echo -e "${YELLOW}[1/3]${NC} Sincronizando archivos..."
    npx cap sync || error

    echo -e "${YELLOW}[2/3]${NC} Compilando APK Release..."
    cd android
    chmod +x gradlew
    ./gradlew assembleRelease || error
    cd ..

    echo -e "${YELLOW}[3/3]${NC} Buscando APK..."
    APK_PATH="android/app/build/outputs/apk/release/app-release-unsigned.apk"
    if [ -f "$APK_PATH" ]; then
        echo ""
        echo "========================================"
        echo "  APK RELEASE GENERADA"
        echo "========================================"
        echo ""
        echo "Ubicación: $APK_PATH"
        echo "Tamaño: $(ls -lh $APK_PATH | awk '{print $5}')"
        echo ""
        echo -e "${YELLOW}NOTA:${NC} Esta APK NO está firmada"
        echo "Necesitas firmarla para instalarla"
        echo "Ver: COMO-OBTENER-APK.md"
        echo ""
        
        # Abrir carpeta
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "android/app/build/outputs/apk/release"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open "android/app/build/outputs/apk/release" 2>/dev/null || echo "Carpeta: android/app/build/outputs/apk/release"
        fi
    else
        echo -e "${RED}[ERROR]${NC} No se generó la APK"
        error
    fi
    
    read -p "Presiona Enter para continuar..."
    menu
}

studio() {
    echo ""
    echo "Abriendo Android Studio..."
    npx cap open android
    echo ""
    echo "Android Studio debería abrirse en unos momentos"
    echo "Si no se abre, verifica que esté instalado"
    echo ""
    read -p "Presiona Enter para continuar..."
    menu
}

clean() {
    echo ""
    echo -e "${YELLOW}[1/3]${NC} Limpiando proyecto..."
    cd android
    ./gradlew clean
    cd ..

    echo -e "${YELLOW}[2/3]${NC} Sincronizando..."
    npx cap sync || error

    echo -e "${YELLOW}[3/3]${NC} Recompilando APK Debug..."
    cd android
    ./gradlew assembleDebug || error
    cd ..

    echo ""
    echo -e "${GREEN}[OK]${NC} Limpieza y recompilación completada"
    read -p "Presiona Enter para continuar..."
    menu
}

files() {
    echo ""
    echo "========================================"
    echo "  ARCHIVOS GENERADOS"
    echo "========================================"
    echo ""
    
    if [ -f "android/app/build/outputs/apk/debug/app-debug.apk" ]; then
        echo -e "${GREEN}[OK]${NC} APK Debug: android/app/build/outputs/apk/debug/app-debug.apk"
        ls -lh android/app/build/outputs/apk/debug/app-debug.apk | awk '{print "     Tamaño: " $5 " - " $6 " " $7 " " $8}'
    else
        echo -e "${RED}[X]${NC} APK Debug: No generada aún"
    fi
    
    echo ""
    
    if [ -f "android/app/build/outputs/apk/release/app-release-unsigned.apk" ]; then
        echo -e "${GREEN}[OK]${NC} APK Release: android/app/build/outputs/apk/release/app-release-unsigned.apk"
        ls -lh android/app/build/outputs/apk/release/app-release-unsigned.apk | awk '{print "     Tamaño: " $5 " - " $6 " " $7 " " $8}'
    else
        echo -e "${RED}[X]${NC} APK Release: No generada aún"
    fi
    
    echo ""
    read -p "Presiona Enter para continuar..."
    menu
}

error() {
    echo ""
    echo "========================================"
    echo "  ERROR"
    echo "========================================"
    echo ""
    echo "Algo salió mal. Verifica:"
    echo "1. Node.js instalado"
    echo "2. Conexión a internet"
    echo "3. Espacio en disco"
    echo "4. Android SDK configurado (para compilación local)"
    echo ""
    echo "Para más ayuda, consulta: COMO-OBTENER-APK.md"
    echo ""
    read -p "Presiona Enter para salir..."
    exit 1
}

# Inicio
menu
