---
description: Genera un carrusel a partir de una newsletter existente usando Higgsfield. Invocar con /carrusels <ruta-newsletter>. Ejemplo: /carrusels output/newsletter-2026-06-06.md
disable-model-invocation: true
allowed-tools: Agent, Read, Write
arguments: [newsletter]
---

## Pipeline de carrusel

### Paso 1 — Verificar el input

Comprueba que el archivo `$newsletter` existe y tiene contenido.
Si no existe: "Archivo no encontrado: $newsletter"

### Paso 2 — Generar el carrusel

Invoca al agente `carrusel-designer` pasándole la ruta: `$newsletter`
Espera a que confirme la URL o ID del carrusel generado.

### Paso 3 — Resumen

Muestra:
- Carrusel generado: [URL o ID de Higgsfield]
- Estructura guardada en: `output/carrusel-estructura-[fecha].md`
- Número de slides
- Próximo paso: publicar en Instagram o programar en Metricool
