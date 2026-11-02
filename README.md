# 🚀 Práctica MLOps: CI/CD con Azure y GitHub Actions

**Grupo 02**
* Integrante 1: 
* Integrante 2: 
* Integrante 3: 
* Integrante 3

## 📝 Descripción del Proyecto
Este repositorio contiene la implementación de una arquitectura MLOps completa para el despliegue de un modelo de Machine Learning (`adult-income`). El proyecto automatiza el ciclo de vida del software (CI/CD) utilizando GitHub Actions, empaquetando la aplicación FastAPI en Docker y desplegándola en Azure Container Apps.

## ⚙️ Arquitectura de Pipelines (CI/CD)
El flujo de automatización se divide en tres flujos de trabajo (workflows) principales, protegidos bajo la regla de no permitir subidas directas a la rama `main`:

1. **Integración (`integration.yml`):** Se dispara al crear un Pull Request hacia `main`. Levanta un entorno, instala dependencias, descarga el dataset y el modelo desde MLflow, y ejecuta los tests unitarios.
2. **Construcción (`build.yml`):** Se dispara al hacer Merge en `main`. Entrena el modelo, lo evalúa y lo registra en el Workspace de Azure MLflow (`grupo02-adult-income`).
3. **Despliegue (`deploy.yml`):** Se dispara simultáneamente tras el Merge en `main`. Construye la imagen de la aplicación utilizando el `Dockerfile` de la raíz, la sube a Docker Hub y actualiza el recurso en Azure Container Apps (`grupo02-devops-0926`).

## 📂 Estructura Principal del Repositorio
* `.github/workflows/`: Definición de los pipelines de GitHub Actions.
* `src/`: Código fuente de la aplicación (FastAPI, data loaders, model logic).
* `tests/`: Batería de pruebas unitarias para la validación continua.
* `scripts/`: Scripts auxiliares (como `download_model.py` para la integración).
* `Dockerfile`: Archivo de configuración para la contenerización de la API.
* `requirements.txt`: Dependencias del proyecto.

## 🛠️ Retos Técnicos y Soluciones
Durante el desarrollo e implementación de la práctica, nos enfrentamos a varios desafíos de infraestructura:

* **Error 403 Forbidden en MLflow:** El pipeline de integración fallaba al intentar descargar el modelo de Azure. Esto fue debido a que la librería interna de MLflow exige estrictamente la variable `MLFLOW_TRACKING_URI`. Además, depuramos los Secretos de GitHub para eliminar espacios en blanco invisibles al final de las credenciales.