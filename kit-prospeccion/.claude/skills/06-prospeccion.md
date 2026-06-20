---
name: prospeccion
description: Busca negocios locales, verifica su presencia digital y genera un informe HTML con prospectos ordenados por oportunidad para Pawzn Visual Studio.
---

Cuando el usuario pida buscar prospectos o mencione un nicho + ciudad, ejecuta este flujo completo:

## FASE 1 — Entender la búsqueda

Extrae del mensaje del usuario:
- **Nicho:** tipo de negocio (restaurante, clínica dental, gimnasio, etc.)
- **Ciudad:** ubicación geográfica
- **Cantidad:** cuántos prospectos quiere (default: 15)
- **Servicio a ofrecer:** web, SEO, redes, email (default: todos)

## FASE 2 — Buscar negocios

Usa WebSearch para encontrar negocios reales:

```
Busca: "[nicho] en [ciudad] site:google.com/maps OR directorio"
Busca: "[nicho] [ciudad] contacto teléfono web"
Busca: "[nicho] [ciudad] mejores listado"
```

Para cada negocio encontrado, recopila solo lo que aparezca explícitamente en los resultados:
- Nombre del negocio
- Dirección / zona
- Teléfono (si aparece)
- URL del sitio web (si tiene)
- Perfil de Google Maps (si existe)
- Redes sociales detectadas

**Regla anti-invención:** si un dato no aparece en la búsqueda, escribe "No disponible" — nunca lo inventes ni lo deduzcas. Si no alcanzas la cantidad solicitada con negocios reales, entrega los que encontraste y dilo explícitamente en tu respuesta al usuario.

## FASE 3 — Verificar presencia digital

Los resultados de búsqueda (snippets) no son suficientes para afirmar cosas como "sin SSL" o "redes inactivas" — hay que comprobarlas.

Para los **10–15 candidatos con mayor potencial**, usa WebFetch para abrir su sitio web y sus perfiles sociales y confirmar con evidencia real:

**Sitio web:**
- ¿Tiene sitio propio? (no cuenta redes sociales)
- ¿Es moderno o desactualizado? (Wix básico, sin HTTPS, diseño visiblemente antiguo)
- ¿Tiene viewport/diseño responsive? ¿Botón de contacto claro?

**Redes sociales:**
- ¿Tiene Instagram/Facebook activo?
- ¿Fecha de la última publicación visible?
- ¿Pocos seguidores para su tipo de negocio?

**Google:**
- ¿Cuántas reseñas tiene? (más reseñas = más activo)
- ¿Responde a las reseñas?
- ¿Foto de perfil y horario actualizados?

**Email marketing:**
- ¿Tiene newsletter o formulario de suscripción visible en su web?
- ¿Aparece en Klaviyo/Mailchimp públicamente?

Para el resto de candidatos (más allá del top 10–15), basa el análisis en las señales visibles de la búsqueda y marca esos campos como "sin verificar" en vez de afirmarlos con la misma certeza.

## FASE 4 — Calcular puntuación de oportunidad

Para cada prospecto, asigna puntos:

| Criterio | Puntos |
|---|---|
| Sin sitio web | +3 |
| Sitio desactualizado/básico | +2 |
| Sin redes sociales activas | +2 |
| Redes inactivas +3 meses | +1 |
| Sin email marketing | +1 |
| Muchas reseñas Google (negocio activo) | +1 |

El puntaje final es la suma directa (máximo 10 puntos). Los de mayor puntuación = mejores prospectos.

## FASE 5 — Personalizar mensaje de contacto

Para cada prospecto genera un mensaje personalizado (WhatsApp/email) de máximo 4 líneas:

- Menciona algo específico y **verificado** de su negocio (no inventes detalles que no comprobaste en la FASE 2/3)
- Identifica el problema principal detectado
- Propone solución concreta de Pawzn Visual Studio
- Llama a la acción con número o email de contacto

Varía la apertura entre prospectos — evita que todos los mensajes empiecen igual. Si un prospecto quedó "sin verificar", el mensaje debe ser más genérico y no afirmar cosas no confirmadas.

Firma siempre: **Pawzn Visual Studio | contacto@pawznvisualstudio.com**

## FASE 6 — Generar dashboard HTML

Crea el archivo `informe-prospectos-[nicho]-[ciudad]-[fecha].html` con este diseño:

```html
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Prospectos — [Nicho] en [Ciudad]</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Segoe UI', sans-serif; background: #0a0a0f; color: #e2e8f0; min-height: 100vh; }

  /* HEADER */
  .header { background: linear-gradient(135deg, #7c3aed, #4f46e5); padding: 2rem; text-align: center; }
  .header h1 { font-size: 1.8rem; font-weight: 700; }
  .header p { opacity: 0.85; margin-top: 0.5rem; }

  /* STATS STRIP */
  .stats { display: flex; gap: 1rem; padding: 1.5rem 2rem; background: #111118; flex-wrap: wrap; justify-content: center; }
  .stat { background: #1a1a2e; border: 1px solid #2d2d44; border-radius: 12px; padding: 1rem 2rem; text-align: center; }
  .stat-num { font-size: 2rem; font-weight: 800; color: #a78bfa; }
  .stat-label { font-size: 0.75rem; color: #94a3b8; margin-top: 0.25rem; }

  /* TABLA */
  .container { padding: 2rem; max-width: 1400px; margin: 0 auto; }
  .container-head { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.75rem; margin-bottom: 1rem; }
  h2 { font-size: 1.2rem; color: #c4b5fd; }
  .export-btn { background: #1a1a2e; border: 1px solid #2d2d44; color: #c4b5fd; padding: 0.5rem 1rem; border-radius: 8px; font-size: 0.78rem; cursor: pointer; }
  .export-btn:hover { background: #24243f; }
  table { width: 100%; border-collapse: collapse; background: #111118; border-radius: 12px; overflow: hidden; }
  th { background: #1a1a2e; padding: 1rem; text-align: left; font-size: 0.8rem; color: #94a3b8; text-transform: uppercase; }
  td { padding: 1rem; border-bottom: 1px solid #1e1e2e; font-size: 0.9rem; vertical-align: top; }
  tr:last-child td { border-bottom: none; }
  tr:hover td { background: #16162a; }

  /* SCORE BADGE */
  .score { display: inline-block; width: 36px; height: 36px; border-radius: 50%; font-weight: 800; font-size: 0.9rem; line-height: 36px; text-align: center; }
  .score-high { background: #14532d; color: #4ade80; }
  .score-mid { background: #713f12; color: #fbbf24; }
  .score-low { background: #450a0a; color: #f87171; }

  /* TAGS */
  .tag { display: inline-block; padding: 0.2rem 0.6rem; border-radius: 6px; font-size: 0.7rem; margin: 0.15rem; }
  .tag-web { background: #1e1b4b; color: #a5b4fc; }
  .tag-redes { background: #1a0533; color: #e879f9; }
  .tag-email { background: #0c2a16; color: #4ade80; }
  .tag-sin { background: #2d1515; color: #f87171; }
  .tag-unverified { background: #1e1e1e; color: #94a3b8; }

  /* MENSAJE */
  .msg { background: #0f172a; border-left: 3px solid #7c3aed; padding: 0.75rem 1rem; border-radius: 0 8px 8px 0; font-size: 0.82rem; line-height: 1.6; color: #cbd5e1; cursor: pointer; }
  .msg:hover { background: #1e293b; }
  .copy-btn { display: inline-block; margin-top: 0.5rem; padding: 0.3rem 0.8rem; background: #7c3aed; color: white; border: none; border-radius: 6px; font-size: 0.72rem; cursor: pointer; }

  /* WEB LINK */
  a { color: #818cf8; text-decoration: none; }
  a:hover { text-decoration: underline; }
  .no-web { color: #f87171; font-size: 0.8rem; }

  /* FOOTER */
  .footer { text-align: center; padding: 2rem; color: #475569; font-size: 0.8rem; }
  .footer .disclaimer { margin-top: 0.5rem; color: #3f3f5c; max-width: 600px; margin-left: auto; margin-right: auto; }
</style>
</head>
<body>

<div class="header">
  <h1>Prospectos — [NICHO] en [CIUDAD]</h1>
  <p>Generado por Pawzn Visual Studio · [FECHA]</p>
</div>

<div class="stats">
  <div class="stat"><div class="stat-num">[TOTAL]</div><div class="stat-label">Prospectos encontrados</div></div>
  <div class="stat"><div class="stat-num">[SIN_WEB]</div><div class="stat-label">Sin sitio web</div></div>
  <div class="stat"><div class="stat-num">[REDES_INACTIVAS]</div><div class="stat-label">Redes inactivas</div></div>
  <div class="stat"><div class="stat-num">[OPORTUNIDAD_ALTA]</div><div class="stat-label">Oportunidad alta (7+)</div></div>
</div>

<div class="container">
  <div class="container-head">
    <h2>Prospectos ordenados por oportunidad</h2>
    <div>
      <button class="export-btn" onclick="downloadJSON()">Descargar JSON</button>
      <button class="export-btn" onclick="downloadCSV()">Descargar CSV (Google Sheets)</button>
    </div>
  </div>
  <table>
    <thead>
      <tr>
        <th>#</th>
        <th>Score</th>
        <th>Negocio</th>
        <th>Contacto</th>
        <th>Web</th>
        <th>Problemas detectados</th>
        <th>Mensaje personalizado</th>
      </tr>
    </thead>
    <tbody>
      <!-- FILA EJEMPLO — repite para cada prospecto -->
      <tr>
        <td>1</td>
        <td><span class="score score-high">9</span></td>
        <td><strong>[NOMBRE]</strong><br><small style="color:#64748b">[DIRECCIÓN]</small></td>
        <td>[TELÉFONO]<br><a href="[MAPS_URL]" target="_blank">Ver en Maps</a></td>
        <td class="no-web">Sin sitio web</td>
        <td>
          <span class="tag tag-sin">Sin web</span>
          <span class="tag tag-redes">Redes inactivas</span>
          <!-- si el prospecto no pasó por verificación con WebFetch (FASE 3), añade también: -->
          <!-- <span class="tag tag-unverified">Sin verificar</span> -->
        </td>
        <td>
          <div class="msg" onclick="copyMsg(this)">
            [MENSAJE PERSONALIZADO]
            <br><br>
            <button class="copy-btn">Copiar mensaje</button>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<div class="footer">
  Pawzn Visual Studio · contacto@pawznvisualstudio.com · Kit de Prospección
  <div class="disclaimer">Datos obtenidos de búsqueda pública el [FECHA]. Verifica cada dato antes de contactar de forma masiva.</div>
</div>

<!-- Reemplaza el array de abajo con un objeto por cada prospecto generado -->
<script id="prospect-data" type="application/json">
[
  {
    "nombre": "[NOMBRE]",
    "direccion": "[DIRECCIÓN]",
    "telefono": "[TELÉFONO]",
    "web": "[URL O 'No disponible']",
    "maps_url": "[MAPS_URL]",
    "score": 9,
    "problemas": ["Sin web", "Redes inactivas"],
    "verificado": true,
    "mensaje": "[MENSAJE PERSONALIZADO]"
  }
]
</script>

<script>
function copyMsg(el) {
  const text = el.innerText.replace('Copiar mensaje', '').trim();
  navigator.clipboard.writeText(text).then(() => {
    const btn = el.querySelector('.copy-btn');
    btn.textContent = '¡Copiado!';
    setTimeout(() => btn.textContent = 'Copiar mensaje', 2000);
  });
}

function getProspectData() {
  return JSON.parse(document.getElementById('prospect-data').textContent);
}

function triggerDownload(content, filename, mime) {
  const blob = new Blob([content], { type: mime });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}

function downloadJSON() {
  const data = getProspectData();
  triggerDownload(JSON.stringify(data, null, 2), 'prospectos.json', 'application/json');
}

function downloadCSV() {
  const data = getProspectData();
  const cols = ['nombre', 'direccion', 'telefono', 'web', 'maps_url', 'score', 'problemas', 'verificado', 'mensaje'];
  const esc = v => `"${String(v).replace(/"/g, '""')}"`;
  const rows = [cols.join(',')];
  data.forEach(p => {
    rows.push(cols.map(c => esc(c === 'problemas' ? p[c].join('; ') : p[c])).join(','));
  });
  triggerDownload(rows.join('\n'), 'prospectos.csv', 'text/csv');
}
</script>
</body>
</html>
```

Rellena todos los `[PLACEHOLDERS]` con datos reales de los prospectos encontrados, incluyendo el bloque `<script id="prospect-data">` (debe tener un objeto por cada fila de la tabla, en el mismo orden).
Guarda el archivo en la carpeta `kit-prospeccion/` y confirma al usuario con la ruta exacta.
