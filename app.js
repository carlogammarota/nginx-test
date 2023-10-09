const express = require('express');
const path = require('path');

const app = express();
const port = 3000;

// Configurar una ruta para servir archivos estáticos (por ejemplo, tu archivo HTML)
app.use(express.static(path.join(__dirname, 'public')));

// Manejar solicitudes GET en la raíz ("/") y enviar el archivo HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Iniciar el servidor Express
app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});
