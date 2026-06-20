# Brand Design

## Paleta de colores

- Color principal: #060608 — negro profundo (fondo de marca)
- Color secundario: #10101a — gris carbón (fondo de cards)
- Color de acento: degradado violeta → rosa: #8b5cf6 (violeta) → #c084fc (violeta claro) → #e879f9 (rosa)
- Fondo habitual: #060608
- Color de texto: #f2f2f5 (texto principal), #7a7a8c (texto secundario/dim)

## Tipografía

- Fuente títulos: Inter (peso Bold/Black)
- Fuente cuerpo: Inter (peso Regular)
- Tamaño título portada: [ej. 48px]
- Tamaño texto cuerpo: [ej. 24px]
- Tamaño CTA: [ej. 28px]

## Layout por tipo de slide

### Slide de portada (slide 1)
- Estructura: [ej. imagen de fondo + texto centrado + nombre en esquina inferior]
- Máximo palabras: [ej. 8 palabras]
- Elementos fijos: [ej. logo, foto, gradiente]

### Slides de contenido (slides 2-6)
- Estructura: [ej. número + texto izquierda + espacio visual derecha]
- Máximo palabras por slide: [ej. 30 palabras]
- Uso de iconos o imágenes: [sí/no, dónde]

### Slide de CTA (último slide)
- Estructura: [ej. frase de acción + perfil + @handle]
- Texto del CTA: [ej. "Sígueme para más"]

## Modelo de imagen en Higgsfield

- Modelo que uso habitualmente: nano_banana_pro (renderiza texto literal en español de forma fiable)
- Estilo de prompt que funciona para mí: describir fondo oscuro #060608 + glow degradado violeta→rosa en una esquina o centrado, tipografía Inter blanca/bold, pedir el texto EXACTO entre comillas, y aclarar explícitamente "no other text, no logos" para que no invente texto adicional
- Ejemplo de prompt que ha funcionado bien:
  "Instagram carousel slide, dark minimalist background #060608, subtle violet-to-pink gradient glow #8b5cf6 to #e879f9 in one corner, clean white Inter typography, medium-size text centered reading exactly: \"[texto del slide]\" no other text, no logos, premium tech aesthetic, square 1:1 composition."

## Reglas de diseño

- Lo que SIEMPRE hago: pedir aspect_ratio 1:1, fondo oscuro de marca, y el texto exacto entre comillas en el prompt
- Lo que NUNCA hago: pedir más de una frase larga por slide de contenido (se desborda o Higgsfield resume mal)
- Número habitual de slides: 7 (1 portada + 5 contenido + 1 CTA)
- Nota de calidad: revisar cada slide generado antes de publicar — en una tanda de 7, 1 salió con un borde/card gris en vez de fondo a sangre completa; regenerar esa si pasa.

## Ejemplo de estructura de carrusel sobre cualquier tema

Slide 1 — Portada: [ejemplo de titular de portada]
Slide 2 — Punto 1: [ejemplo]
Slide 3 — Punto 2: [ejemplo]
Slide 4 — Punto 3: [ejemplo]
Slide 5 — Punto 4: [ejemplo]
Slide 6 — CTA: [ejemplo]

---
RECUERDA: Actualiza este archivo cada vez que generes un carrusel que te guste especialmente.
