@echo off
echo ========================================
echo   GENERADOR DE APK - Lector NFC
echo ========================================
echo.

REM Verificar Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js no esta instalado
    echo.
    echo Descarga desde: https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js detectado: 
node --version
echo.

echo ========================================
echo   OPCIONES
echo ========================================
echo.
echo 1. Setup inicial (primera vez)
echo 2. Compilar APK Debug (rapido)
echo 3. Compilar APK Release (produccion)
echo 4. Abrir en Android Studio
echo 5. Limpiar y recompilar
echo 6. Ver archivos generados
echo.
set /p opcion="Selecciona una opcion (1-6): "

if "%opcion%"=="1" goto setup
if "%opcion%"=="2" goto debug
if "%opcion%"=="3" goto release
if "%opcion%"=="4" goto studio
if "%opcion%"=="5" goto clean
if "%opcion%"=="6" goto files
goto end

:setup
echo.
echo [1/5] Instalando dependencias...
call npm install
if %ERRORLEVEL% NEQ 0 goto error

echo [2/5] Agregando plataforma Android...
call npx cap add android
if %ERRORLEVEL% NEQ 0 (
    echo [NOTA] La plataforma ya existe, continuando...
)

echo [3/5] Copiando archivos web...
if not exist "www" mkdir www
copy /Y ..\*.html www\ >nul 2>nul
copy /Y ..\manifest.json www\ >nul 2>nul
copy /Y ..\sw.js www\ >nul 2>nul

echo [4/5] Sincronizando...
call npx cap sync
if %ERRORLEVEL% NEQ 0 goto error

echo [5/5] Configurando permisos...
cd android
if exist "gradlew.bat" (
    echo Permisos configurados
) else (
    echo [ERROR] No se encuentra gradlew
    goto error
)
cd ..

echo.
echo ========================================
echo   SETUP COMPLETADO
echo ========================================
echo.
echo Ahora puedes:
echo - Compilar APK Debug (opcion 2)
echo - Abrir en Android Studio (opcion 4)
echo.
pause
goto menu

:debug
echo.
echo [1/3] Sincronizando archivos...
call npx cap sync
if %ERRORLEVEL% NEQ 0 goto error

echo [2/3] Compilando APK Debug...
cd android
call gradlew.bat assembleDebug
if %ERRORLEVEL% NEQ 0 goto error
cd ..

echo [3/3] Buscando APK...
set APK_PATH=android\app\build\outputs\apk\debug\app-debug.apk
if exist "%APK_PATH%" (
    echo.
    echo ========================================
    echo   APK GENERADA
    echo ========================================
    echo.
    echo Ubicacion: %APK_PATH%
    echo Tamano: 
    dir "%APK_PATH%" | find "app-debug.apk"
    echo.
    echo Ya puedes instalarla en tu Android
    echo.
    start "" "%CD%\android\app\build\outputs\apk\debug"
) else (
    echo [ERROR] No se genero la APK
    goto error
)
pause
goto menu

:release
echo.
echo [1/3] Sincronizando archivos...
call npx cap sync
if %ERRORLEVEL% NEQ 0 goto error

echo [2/3] Compilando APK Release...
cd android
call gradlew.bat assembleRelease
if %ERRORLEVEL% NEQ 0 goto error
cd ..

echo [3/3] Buscando APK...
set APK_PATH=android\app\build\outputs\apk\release\app-release-unsigned.apk
if exist "%APK_PATH%" (
    echo.
    echo ========================================
    echo   APK RELEASE GENERADA
    echo ========================================
    echo.
    echo Ubicacion: %APK_PATH%
    echo.
    echo NOTA: Esta APK NO esta firmada
    echo Necesitas firmarla para instalarla
    echo Ver: COMO-OBTENER-APK.md
    echo.
    start "" "%CD%\android\app\build\outputs\apk\release"
) else (
    echo [ERROR] No se genero la APK
    goto error
)
pause
goto menu

:studio
echo.
echo Abriendo Android Studio...
call npx cap open android
echo.
echo Android Studio deberia abrirse en unos momentos
echo Si no se abre, verifica que este instalado
echo.
pause
goto menu

:clean
echo.
echo [1/3] Limpiando proyecto...
cd android
call gradlew.bat clean
cd ..

echo [2/3] Sincronizando...
call npx cap sync
if %ERRORLEVEL% NEQ 0 goto error

echo [3/3] Recompilando APK Debug...
cd android
call gradlew.bat assembleDebug
if %ERRORLEVEL% NEQ 0 goto error
cd ..

echo.
echo [OK] Limpieza y recompilacion completada
pause
goto menu

:files
echo.
echo ========================================
echo   ARCHIVOS GENERADOS
echo ========================================
echo.
if exist "android\app\build\outputs\apk\debug\app-debug.apk" (
    echo [OK] APK Debug: android\app\build\outputs\apk\debug\app-debug.apk
    dir "android\app\build\outputs\apk\debug\app-debug.apk" | find "app-debug.apk"
) else (
    echo [X] APK Debug: No generada aun
)
echo.
if exist "android\app\build\outputs\apk\release\app-release-unsigned.apk" (
    echo [OK] APK Release: android\app\build\outputs\apk\release\app-release-unsigned.apk
    dir "android\app\build\outputs\apk\release\app-release-unsigned.apk" | find "app-release"
) else (
    echo [X] APK Release: No generada aun
)
echo.
pause
goto menu

:error
echo.
echo ========================================
echo   ERROR
echo ========================================
echo.
echo Algo salio mal. Verifica:
echo 1. Node.js instalado
echo 2. Conexion a internet
echo 3. Espacio en disco
echo.
echo Para mas ayuda, consulta: COMO-OBTENER-APK.md
echo.
pause
exit /b 1

:menu
echo.
set /p continuar="Volver al menu? (S/N): "
if /i "%continuar%"=="S" goto start
if /i "%continuar%"=="s" goto start
goto end

:end
echo.
echo Gracias por usar Lector NFC
echo.
pause
