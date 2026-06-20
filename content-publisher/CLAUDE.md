# CLAUDE.md

## Proyecto

Sistema de marketing con Claude Code: convierte audio grabado en contenido publicado.

**Flujo:** audio → transcripción → redacción → revisión → publicación en Metricool

## Estructura de carpetas

```
/
├── CLAUDE.md                   ← este archivo
├── brand_voice.md              ← EDITAR antes de usar (fuente de verdad de tu voz)
├── brand_design.md             ← EDITAR antes de usar (paleta, tipografía, layout)
├── tools/
│   └── transcribe.py           ← transcripción de audio con faster-whisper
├── audio/                      ← audios a procesar
└── output/                     ← newsletter, posts LinkedIn y estructuras de carrusel

.claude/
├── agents/
│   ├── redactor.md             ← sonnet: genera newsletter y posts LinkedIn
│   ├── revisor.md              ← haiku: evalúa calidad contra brand_voice.md → JSON
│   ├── publicador.md           ← haiku: programa en Metricool (solo si revisor aprueba)
│   └── carrusel-designer.md    ← sonnet: diseña carruseles con Higgsfield
└── skills/
    ├── publica-esto/
    │   └── SKILL.md            ← /publica-esto: pipeline completo audio → publicado
    └── carrusels/
        └── SKILL.md            ← /carrusels: carrusel desde newsletter o tema
```

## MCPs necesarios

Instala y autentica en Claude Code antes de usar:

- **Metricool** — programación de posts en LinkedIn e Instagram
- **Higgsfield** — generación de imágenes para carruseles

## Comandos

- `/publica-esto audio/mi-grabacion.mp3` — pipeline completo desde audio
- `/carrusels output/newsletter-2026-06-01.md` — genera carrusel desde newsletter existente

## Agentes

| Agente | Modelo | Función |
|---|---|---|
| `redactor` | sonnet | Newsletter + 3 posts LinkedIn desde transcripción |
| `revisor` | haiku | Evaluación de calidad contra brand_voice.md → JSON |
| `publicador` | haiku | Programación en Metricool (solo si revisor aprueba) |
| `carrusel-designer` | sonnet | Carruseles para Instagram con Higgsfield |

## Reglas del sistema

- Leer `brand_voice.md` siempre antes de redactar cualquier texto
- Leer `brand_design.md` siempre antes de generar imágenes o estructurar carruseles
- El revisor debe devolver `aprobado_global: true` antes de publicar
- No inventar datos, métricas ni citas — solo lo que esté en el audio original
- El publicador programa posts de LinkedIn en Metricool (la newsletter es publicación manual)
- No modificar `brand_voice.md` ni `brand_design.md` sin confirmación del usuario

## Setup inicial

1. Edita `brand_voice.md` con tu voz, tono y ejemplos reales de tus mejores textos ✅ hecho
2. Edita `brand_design.md` con tu paleta de colores, tipografía y estilo visual (colores/tipografía ya puestos)
3. Instala dependencias: entorno virtual en `venv/` con `faster-whisper` ya instalado (`venv/bin/pip install faster-whisper`)
4. Instala y autentica los MCPs de Metricool e Higgsfield en Claude Code
5. Crea las carpetas: `audio/` y `output/` ✅ hechas
6. Prueba el pipeline: `/publica-esto audio/primer-audio.mp3`
