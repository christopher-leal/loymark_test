# loymark_test

## Para correr el backend correr el comando npm start
- Incluye las variables de entorno por ser un proyecto de prueba
## Como correr peticiones locales en la app
- en android las peticiones locales no pueden hacerse http://localhost:3000 por lo cual es necesario estar en la misma red donde esta el backend corriendo y correr el siguiente comando (se se corre la app en ios no hay ningun problema)
- ipconfig en Windows, ifconfig Linux y copiar la direccion IPv4 en el archivo lib/core/environment.dart
- Una vez con la url base lista en la app, procedemos a correr la app descargar todas las dependencias flutter pub get y despues corremos flutter run
