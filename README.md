# loymark_test

## Para correr el backend correr el comando npm start
- Incluye las variables de entorno por ser un proyecto de prueba
## Como correr peticiones locales en la app
- en android las peticiones locales no pueden hacerse a http://localhost:3000 por lo cual es necesario estar en la misma red donde esta el backend corriendo y correr el siguiente comando (si se corre la app en ios no hay ningun problema y se puede evitar el paso siguiente)
- ipconfig en Windows, ifconfig Linux y copiar la direccion IPv4 en el archivo lib/core/environment.dart
- Una vez con la url base lista en la app, procedemos a descargar todas las dependencias flutter pub get y despues corremos la app flutter run
