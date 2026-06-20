# Auditoría — www.pawznvisualstudio.com (2026-06-20)

Nota: Semrush MCP no devolvió datos porque el plan actual no incluye acceso a MCP (ver https://www.semrush.com/mcp-access). Esta auditoría se hizo combinando inspección en vivo del sitio (curl/headers) y revisión del código fuente en este repo.

## 🔴 Crítico

**1. El dominio canónico (pawzn.com) está caído — HTTP 402 Payment Required**
El sitio real funciona en `www.pawznvisualstudio.com` (confirmado: HTTP 200, servido por GitHub Pages), pero el `<link rel="canonical">`, `og:url`, `og:image`, el JSON-LD (`url`) y los emails de contacto en [index.html](../index.html) apuntan todos a `https://pawzn.com/`, que devuelve **402 Payment Required** (probablemente un hosting/dominio sin pagar o un proyecto pausado).
- Google puede indexar el sitio con un canonical que apunta a una URL rota → riesgo de desindexación o de que el contenido no se atribuya a la URL real.
- Cualquier compartido en redes sociales (WhatsApp, LinkedIn, etc.) intentará cargar la imagen Open Graph desde `pawzn.com/og-image.jpg`, que no carga.
- Si algún visitante tiene JavaScript desactivado, el formulario de contacto cae al fallback nativo de `formsubmit.co`, que redirige tras el envío a `https://pawzn.com/gracias` — una página rota.

**Acción recomendada:** decidir cuál es el dominio definitivo. Si es `www.pawznvisualstudio.com`, actualizar canonical, og:url, og:image, JSON-LD y el `_next` del formulario para que apunten ahí. Si `pawzn.com` debe seguir siendo el dominio de marca, reactivar su hosting/pago.

**2. Faltan `robots.txt` y `sitemap.xml`**
Ninguno de los dos existe (confirmado 404 en vivo y ausentes en el repo). Sin sitemap, Google tarda más en descubrir e indexar las páginas; sin robots.txt no hay control explícito de crawling.

## 🟠 Importante

**3. `vercel.json` no tiene efecto — el sitio se sirve desde GitHub Pages, no Vercel**
Headers de respuesta confirman `server: GitHub.com`. Esto significa que las cabeceras de seguridad definidas en [vercel.json](../vercel.json) (`X-Content-Type-Options`, `X-Frame-Options`) **no se están aplicando en producción**, y la regla de rewrite `/pick-pro → /agente-pick-pro.html` tampoco funciona (confirmado 404 en `/pick-pro` mientras `/agente-pick-pro.html` sí responde 200).
- Si hay algún material de marketing, QR o post que use la URL corta `/pick-pro`, está roto.
- Las cabeceras de seguridad (clickjacking, MIME sniffing) no están activas en el sitio real.

**Acción recomendada:** si el deploy real es GitHub Pages, eliminar `vercel.json` (o migrar el deploy a Vercel si se prefiere esa plataforma) y, si se quiere mantener la URL `/pick-pro`, crear un archivo HTML de redirección o cambiar el nombre del archivo.

**4. Enlaces legales del footer son placeholders**
"Política de privacidad", "Aviso legal" y "Cookies" en el footer de [index.html](../index.html#L475-L478) apuntan a `href="#"` — no llevan a ningún contenido real. Para una agencia que vende sitios web a otros negocios, no tener estas páginas resueltas es una mala señal de credibilidad, además de un requisito legal mínimo en muchas jurisdicciones.

## 🟡 Menor

**5. Meta description sí existe (el análisis automático inicial no la detectó), pero conviene revisar longitud**
Está presente en `index.html` línea 6 y es coherente con el contenido. Bien.

**6. Carga de 7 pesos de fuente (Inter 300–900)**
`index.html` carga `Inter:wght@300;400;500;600;700;800;900` — siete variantes. La mayoría de los sitios solo necesitan 3-4 (ej. 400, 500, 700, 800). Reducir variantes disminuye el tiempo de carga de fuentes y mejora LCP/CLS.

**7. Meta keywords**
Presente pero sin efecto en SEO moderno (Google la ignora desde hace años). No es un problema, pero es peso muerto en el `<head>`.

**8. Webhook de n8n expuesto en el cliente**
`main.js` línea 70 expone la URL completa del webhook de n8n (`mi-n8n-2026.app.n8n.cloud/webhook/pawzn-leads`) en JavaScript público. No es una vulnerabilidad grave (es solo un endpoint de captura de leads), pero cualquiera puede ver esa URL y enviarle datos arbitrarios (spam) sin pasar por el formulario. Si el workflow de n8n no valida/sanitiza la entrada, conviene añadir alguna validación mínima del lado de n8n.

## ✅ Lo que está bien

- Estructura semántica correcta (`<nav>`, `<main>`, `<footer>`, jerarquía H1→H2→H3 limpia).
- JSON-LD `ProfessionalService` implementado.
- Open Graph y Twitter Cards completos (solo falta corregir el dominio).
- Accesibilidad básica cuidada: `aria-label` en nav, botón hamburguesa y redes sociales; `sr-only` labels en el formulario; `aria-live` en el feedback del formulario.
- Formulario con manejo JS robusto (fetch + fallback de error) y envío paralelo a n8n para automatización de leads.
- CSS liviano (~24KB) y sin imágenes pesadas — todo el fondo decorativo es SVG/gradientes inline, buen approach de performance.
- `preconnect` a Google Fonts implementado correctamente.

## Prioridad de arreglo sugerida

1. Resolver el conflicto de dominio (pawzn.com vs pawznvisualstudio.com) — afecta SEO, social sharing y conversión.
2. Agregar `robots.txt` y `sitemap.xml`.
3. Eliminar o corregir `vercel.json` según la plataforma real de deploy.
4. Resolver los enlaces legales del footer (al menos una página básica de privacidad/cookies).
5. Reducir pesos de fuente cargados.
