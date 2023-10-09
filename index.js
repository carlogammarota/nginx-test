const express = require('express');
const { exec } = require('child_process');
const Docker = require('dockerode');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;
const path = require('path');

app.use(express.json());
app.use(bodyParser.json());

const dockerfilePath = path.join(__dirname, 'template-themeforest-api', 'Dockerfile');

app.use('/template-themeforest-api', express.static(__dirname + '/template-themeforest-api'));

// Ruta al directorio que contiene el Dockerfile
// const dockerfilePath = __dirname + '/template-themeforest-api/Dockerfile';
const imageName = 'api'; // Nombre de la imagen Docker
const containerName = 'mi-app-charly'; // Nombre del contenedor
const exposedPort = '1313'; // Puerto a exponer en el contenedor

// app.use('/template-themeforest-api', express.static(__dirname + '/template-themeforest-api'));
// app.use('template-themeforest-api', express.static(__dirname +'./template-themeforest-api'));


app.post('/build-and-create', (req, res) => {
  let { hostPort, containerName } = req.body;
  console.log(req.body);
  // Definir las variables necesarias
  const imageName = 'front'; // Reemplaza con el nombre de tu imagen
  // const dockerfilePath = '/Users/carlogammarota/Desktop/automatization/template-themeforest-api/'; // Reemplaza con la ruta de tu Dockerfile

  const exposedPort = '1313'; // Reemplaza con el puerto que deseas exponer

  // Comando para construir la imagen Docker desde el Dockerfile
  
  const buildCommand = `docker-compose -p ${containerName} -e NODE_APP_PORT=${hostPort} up  `;

  exec(buildCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('Error al construir la imagen Docker:', error);
      res.status(500).send('Error al construir la imagen Docker');
    } else {
      // Una vez construida la imagen, crear y ejecutar el contenedor
      const docker = new Docker({ socketPath: '/var/run/docker.sock' });

      const containerConfig = {
        Image: imageName,
        name: containerName,
        ExposedPorts: {
          [`${exposedPort}/tcp`]: {}, // Exponer el puerto específico
        },
        HostConfig: {
          PortBindings: {
            [`${exposedPort}/tcp`]: [{ HostPort: hostPort }], // Mapeo del puerto en el host
          },
        },
      };

      docker.createContainer(containerConfig, (err, container) => {
        if (err) {
          console.error('Error al crear el contenedor:', err);
          res.status(500).send('Error al crear el contenedor');
        } else {
          container.start((err, data) => {
            if (err) {
              console.error('Error al iniciar el contenedor:', err);
              res.status(500).send('Error al iniciar el contenedor');
            } else {
              console.log('Contenedor creado y en ejecución:', data);
              res.send('Contenedor creado y en ejecución');
            }
          });
        }
      });
    }
  });
});

app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});
