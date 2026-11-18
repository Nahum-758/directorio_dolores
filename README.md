# directorio_dolores
El ciclo TDD de siempre
🔴 ROJO: escribe la prueba (debe FALLAR)
Escribes la prueba de lo que debería pasar; falla.
🟢 VERDE: el código mínimo para pasar
Escribes el código mínimo para que pase.
🔵 REFACTOR: ordena sin romper nada

Ciclo 2.2 · Leer todos los campos
🔴 ROJO: escribe la prueba (debe FALLAR)
$ flutter test
<img width="778" height="306" alt="image" src="https://github.com/user-attachments/assets/f3ee9e68-05e3-4bb8-aead-d7a2c284b14c" />
<img width="778" height="155" alt="image" src="https://github.com/user-attachments/assets/a850889a-6440-4e28-a62b-910a5d7f0c9d" />


🟢 VERDE: el código mínimo para pasar

 <img width="683" height="113" alt="image" src="https://github.com/user-attachments/assets/26edaf13-0e48-4976-b632-10308da6b817" />


Ronda 3 · El cliente HTTP con MockClient
Ciclo 3.1 · Listar
🔴 ROJO: escribe la prueba (debe FALLAR)

<img width="1004" height="337" alt="image" src="https://github.com/user-attachments/assets/3fcb29b2-c9c6-4c78-a3eb-f1cce680327e" />
<img width="1004" height="84" alt="image" src="https://github.com/user-attachments/assets/8a744dc1-1651-4195-8591-fddb39a0b5fa" />


🟢 VERDE: el código mínimo para pasar

<img width="711" height="111" alt="image" src="https://github.com/user-attachments/assets/4bf5db8c-b89a-491a-ad7a-a9f7f2e38187" />


Ciclo 3.2 · Los casos de falla
🔴 ROJO: escribe la prueba (debe FALLAR)

<img width="718" height="339" alt="image" src="https://github.com/user-attachments/assets/ef02ddb7-d2a5-4654-bb49-184bca085782" />
<img width="716" height="142" alt="image" src="https://github.com/user-attachments/assets/e054053c-0846-4161-a4eb-6e571143b3b3" />


🟢 VERDE: el código mínimo para pasar
Ya pasan con el código de arriba. Mira el truco del timeout: el parámetro espera permite que en la prueba sea de 20 milisegundos y en la app de 5 segundos. Diseñar para probar mejora el diseño.
<img width="706" height="109" alt="image" src="https://github.com/user-attachments/assets/a7516d3e-35d9-486c-bb20-1d16a6f4981b" />


Ciclo 3.3 · Crear, buscar y eliminar
🔴 ROJO: escribe la prueba (debe FALLAR)

<img width="855" height="309" alt="image" src="https://github.com/user-attachments/assets/1d7c964f-3e87-4fe0-ba56-b152a186db30" />
<img width="856" height="127" alt="image" src="https://github.com/user-attachments/assets/d27cfa21-ed88-4f31-90a7-08181042eb4c" />

  
🟢 VERDE: el código mínimo para pasar
Todo ya está implementado. Ejecuta:
$ flutter test
 <img width="411" height="105" alt="image" src="https://github.com/user-attachments/assets/e00e652d-9b16-41d5-ad19-9fcd12e3d5d6" />


Ronda 5 · Conectar app y API de verdad
Ciclo 5.1 · Pruebas de la secuencia de estados
🔴 ROJO: escribe la prueba (debe FALLAR)

 <img width="799" height="269" alt="image" src="https://github.com/user-attachments/assets/7e2bd408-99a5-4cb7-8a58-f71aad3b1497" />
<img width="803" height="130" alt="image" src="https://github.com/user-attachments/assets/6d025827-51c5-440f-be41-b3933e3c00f0" />
 

🟢 VERDE: el código mínimo para pasar

<img width="529" height="145" alt="image" src="https://github.com/user-attachments/assets/89f61cbe-1137-4fd4-86da-4323cf8c2b81" />


Ronda 6 · La pantalla y la prueba final
Preguntas para discutir en clase
16.	¿Por qué inyectamos el http.Client en lugar de crearlo dentro de NegociosApi? Porque lo inyectamos por desacoplamiento testabilidad, y al pasar el cliente HTTP por el constructor, podemos usar en MockClientdurante pruebas unitarias para simular respuestas sin necesidad de levantar un servidor real en internet cada vez que corremos los tests.
17.	¿Qué ventaja tiene que la API devuelva 201 al crear en lugar de 200? Que Sigue el estándar de arquitectura REST. El código 201 Created indica explícitamente que la petición no solo fue exitosa, sino que además se creó un nuevo recurso en el servidor como resultado de la solicitud. Usar 201 en lugar de un genérico 200 OK mejora la semántica de la API, facilitando que el cliente y otros servicios identifiquen de inmediato que se generó un registro nuevo.
18.	¿Qué pasaría si dos celulares borran el mismo negocio al mismo tiempo? En el 1ro si se eliminaría con éxito, pero el otro devolverá el error 404 ya que no lo encuentra porque ya no existe
19.	¿Qué cambiaría en la app si mañana la API fuera un servidor real con HTTPS? A nivel de código de la lógica de negocio y de los modelos no cambiaría prácticamente nada, ya que la app sigue consumiendo los mismos endpoints y mapeando los mismos JSONs.
Retos finales por equipos
•	Agrega búsqueda en vivo: un campo de texto que llame a listar(busqueda: ...) con una pausa de 400 ms entre teclas (debounce).
•	Agrega el campo "horario" en la API, el modelo, las pruebas y la pantalla (empieza por la prueba).
•	Cambia la API en memoria por un archivo JSON en disco para que los datos sobrevivan al apagado.
•	Agrega una pantalla de detalle con GET /negocios/ID y manejo del 404.
•	Agrega autenticación sencilla con un token en el header Authorization.
🏅 INSIGNIA DESBLOQUEADA: Desarrollador de apps conectadas
Recuerda: una app conectada debe estar preparada para que la conexión falle. ¡Éxito en tu directorio!
