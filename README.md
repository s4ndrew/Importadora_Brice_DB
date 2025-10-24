
---------------------------
# 🏪 Importadora_Brice_DB

> Ejecuta el archivo principal y tendrás todas las rutas de la API funcionando al 💯%  

---

## ⚙️ Configuración del puerto TCP/IP (1433)

Para permitir las conexiones externas al servidor SQL:

1. Abre **SQL Server Configuration Manager**  
2. Dirígete a:  
   ```
   Configuración de red de SQL Server
   ```
3. Despliega las opciones y selecciona:  
   ```
   Protocolos de SQLEXPRESS
   ```
4. En el panel derecho, busca **TCP/IP**, haz **clic derecho → Habilitar**  
5. Luego, **clic derecho → Propiedades**  
6. En la ventana que aparece, entra en la pestaña **"Direcciones IP"**  
7. Desplázate hasta el final, busca la sección **"IPAII"**  
8. En el campo **"Puerto TCP"**, escribe:
   ```
   1433
   ```
9. Haz clic en **Aplicar** y luego en **Aceptar**

---

## 🔄 Reiniciar el servicio SQL

Para aplicar los cambios:

1. Abre la aplicación **Servicios** (del sistema de Windows)  
2. Busca el servicio con nombre similar a:
   ```
   SQL Server (SQLEXPRESS)
   ```
3. Haz clic derecho y selecciona **Reiniciar**

---

✅ **Listo:** tu servidor SQL ya acepta conexiones TCP/IP en el puerto **1433**.
