---
description: Orquesta el pipeline completo. Transcribe audio, genera newsletter y LinkedIn, revisa con brand voice y programa en Metricool. Invocar con /publica-esto <ruta-del-audio>
disable-model-invocation: true
allowed-tools: Bash, Agent, Write, Read
arguments: [audio]
---

## Pipeline de publicación

### Paso 1 — Transcribir el audio

!`venv/bin/python3 tools/transcribe.py "$audio"`

El texto anterior es la transcripción completa del audio.
Úsalo como input para el siguiente paso.

### Paso 2 — Redactar el contenido

Invoca al agente `redactor` pasándole el texto transcrito completo.
Espera a que confirme que los archivos están guardados en `output/`.

### Paso 3 — Revisar

Invoca al agente `revisor` con las rutas de los archivos generados en `output/`.
Lee el JSON de respuesta:
- Si `"aprobado_global": true` → continuar al Paso 4
- Si `"aprobado_global": false` → mostrar qué piezas fallaron y parar

### Paso 4 — Publicar en Metricool

Solo si el revisor aprobó.
Invoca al agente `publicador` con las rutas de los archivos aprobados.

### Paso 5 — Resumen final

Muestra:
- Posts programados (plataforma, fecha y hora exacta)
- Ruta de la newsletter para publicación manual: `output/newsletter-[fecha].md`
