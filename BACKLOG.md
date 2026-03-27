# BACKLOG — Marc Solé Domènech Portfolio
_Generado: 2026-03-27_

---

## Contexto del producto

Portafolio personal de un Product Manager senior (Marc Solé Domènech) en búsqueda activa o
captación de oportunidades: roles de liderazgo, advisory, fractional PM y networking profesional.

**Usuarios principales:**
- **Reclutador / hiring manager** — llega de LinkedIn, evalúa credibilidad y fit en < 2 min
- **Founder / early-stage startup** — busca advisory o fractional PM, lee el blog para validar criterio
- **Peer PM / comunidad** — descubre el contenido por SEO o redes, puede convertirse en audiencia recurrente

**Métrica norte:** tasa de contacto cualificado (clics en email/LinkedIn desde el sitio) por sesión.

---

## Framework de priorización: RICE

| # | Feature | Reach | Impact | Confidence | Effort | RICE Score | MoSCoW |
|---|---------|-------|--------|------------|--------|------------|--------|
| 1 | Contenido real en Resume + Projects | 10 | 3 | 1.0 | 1 | **30** | Must |
| 2 | SEO + Open Graph por página | 9 | 3 | 0.9 | 1 | **24** | Must |
| 3 | Feed RSS del blog | 7 | 2 | 0.9 | 1 | **12.6** | Should |
| 4 | Modo oscuro | 8 | 1 | 0.8 | 2 | **3.2** | Could |
| 5 | Analytics de privacidad (Plausible/Fathom) | 6 | 2 | 0.8 | 1 | **9.6** | Should |

> Reach: nº de usuarios afectados por semana (escala 1-10).
> Impact: impacto en la métrica norte (1=mínimo, 3=alto).
> Confidence: certeza del estimado (0-1).
> Effort: semanas-persona (1 = menos de 1 día, 2 = 1-3 días).
> RICE = (Reach x Impact x Confidence) / Effort.

---

## Feature 1 — Contenido real en Resume y Projects
**RICE: 30 | MoSCoW: Must Have**

### Problema
`resume.astro` y `projects.astro` contienen exclusivamente placeholder text
("Job Title — Company Name", "Project One"). Un reclutador que llega hoy abandona el sitio
sin ninguna señal de credibilidad. Es el mayor gap entre la propuesta de valor declarada en
Home y la evidencia que el sitio entrega.

### User Stories

**US-1.1 — Resume con experiencia real**
> Como reclutador que llega desde LinkedIn,
> quiero ver la trayectoria profesional de Marc con empresa, cargo, fechas e impacto medible,
> para evaluar si encaja con el rol que estoy contratando sin tener que pedirle el CV.

Criterios de aceptación:
- Given que visito `/resume`, when la página carga, then veo al menos 3 posiciones reales con: empresa, cargo, rango de fechas y 1-2 logros cuantificados (%, €, usuarios, tiempo ahorrado).
- Given que visito `/resume` desde mobile, when la página carga, then el layout no desborda horizontalmente y las fechas son legibles.
- Given que un reclutador quiere el CV completo, when hace clic en "Download CV", then se descarga un PDF actualizado (o abre en nueva pestaña).

**US-1.2 — Projects con casos reales**
> Como founder que evalúa contratar a Marc para advisory,
> quiero leer el contexto, el problema que resolvió y el resultado de cada proyecto,
> para juzgar si su forma de pensar sobre producto encaja con mis retos.

Criterios de aceptación:
- Given que visito `/projects`, when la página carga, then veo al menos 3 proyectos reales. Cada uno incluye: nombre descriptivo, empresa (o "confidencial"), mi rol, el problema que se resolvía y una métrica de resultado.
- Given que un proyecto tiene URL pública, when hago clic en el enlace "↗", then se abre en nueva pestaña y no devuelve 404.
- Given que los proyectos tienen tags, when los tags están presentes, then reflejan categorías reales (no "Project Strategy", "0→1" vacíos).

---

## Feature 2 — SEO + Open Graph por página
**RICE: 24 | MoSCoW: Must Have**

### Problema
`BaseLayout.astro` define una sola `<meta name="description">` genérica para todas las páginas.
No hay `<meta property="og:*">` ni `<meta name="twitter:card">`. Consecuencias directas: (1) las
páginas del blog no se indexan con snippet diferenciado; (2) al compartir cualquier URL en
LinkedIn o Slack aparece sin imagen ni descripción — reduce la tasa de clic.

### User Stories

**US-2.1 — Meta description única por página**
> Como peer PM que comparte un post del blog en LinkedIn,
> quiero que el preview muestre título, descripción e imagen relevantes,
> para que mis contactos entiendan de qué trata antes de hacer clic.

Criterios de aceptación:
- Given que comparto `/blog/hello-world` en LinkedIn, when el scraper de LinkedIn procesa la URL, then el preview muestra el `og:title` del post, su `excerpt` como `og:description`, y una imagen (puede ser la imagen de perfil como fallback).
- Given que visito cualquier página con un inspector de SEO, when analizo el `<head>`, then `og:title`, `og:description`, `og:url` y `og:image` están presentes y son únicos por página.
- Given que una página de blog tiene `frontmatter.excerpt`, when se renderiza el `<head>`, then `<meta name="description">` usa ese excerpt (no el valor por defecto de BaseLayout).

**US-2.2 — Canonical URL + sitemap**
> Como motor de búsqueda que indexa el sitio,
> quiero encontrar un sitemap.xml y canonical tags,
> para indexar correctamente las páginas sin duplicados.

Criterios de aceptación:
- Given que visito `/sitemap-index.xml` o `/sitemap.xml`, when la URL resuelve, then el sitemap contiene todas las rutas públicas del sitio (home, projects, blog, resume, contact, posts individuales).
- Given que visito cualquier página, when reviso el `<head>`, then existe `<link rel="canonical" href="...">` con la URL absoluta y correcta de esa página.
- Given que `astro.config.mjs` no tiene `site` definido, when se genera el build, then el sitemap usa la URL de producción correcta.

---

## Feature 3 — Feed RSS del blog
**RICE: 12.6 | MoSCoW: Should Have**

### Problema
La sección "Thoughts" aspira a ser el vector de distribución principal del contenido (lo dice
el copy de Home). Sin RSS, los lectores habituales no tienen forma de suscribirse sin depender
de redes sociales. Esto corta el loop de retención y limita el alcance orgánico de posts futuros.

### User Stories

**US-3.1 — Suscripción al blog vía RSS**
> Como peer PM que lee blogs de producto con un lector RSS (Feedly, Reeder),
> quiero suscribirme al feed de "Thoughts" con mi lector habitual,
> para recibir nuevos posts sin tener que volver a visitar el sitio manualmente.

Criterios de aceptación:
- Given que visito `/rss.xml`, when la URL resuelve, then devuelve un feed RSS 2.0 o Atom válido con: título del blog, descripción, link, y una entrada por cada post publicado que incluya `<title>`, `<link>`, `<pubDate>` y `<description>` con el excerpt.
- Given que se añade un nuevo post `.md` con `date` y `excerpt` en el frontmatter, when se hace build, then el post aparece en el feed ordenado de más reciente a más antiguo.
- Given que visito `/blog`, when la página carga, then hay un enlace o icono RSS visible que apunta a `/rss.xml` (no oculto).
- Given que copio la URL del feed y la pego en Feedly, when Feedly la procesa, then la suscripción se crea correctamente sin errores de parsing.

---

## Feature 4 — Analytics de privacidad (Plausible o Fathom)
**RICE: 9.6 | MoSCoW: Should Have**

### Problema
El sitio no tiene ningún mecanismo para saber qué páginas se visitan, de dónde vienen los
visitantes ni qué posts generan más interés. Sin datos, no hay forma de validar si el contenido
y el posicionamiento están funcionando, ni de priorizar qué escribir a continuación.
Google Analytics queda descartado por complejidad de GDPR y cookie banner.

### User Stories

**US-4.1 — Visibilidad del comportamiento de visitantes**
> Como dueño del portafolio,
> quiero ver pageviews, fuentes de tráfico y posts más leídos en un dashboard simple,
> para saber qué contenido resuena y de dónde llega la gente.

Criterios de aceptación:
- Given que un visitante carga cualquier página del sitio, when la página renderiza, then el script de analytics se ejecuta sin bloquear el render (debe cargarse de forma asíncrona o `defer`).
- Given que visito el dashboard de analytics (Plausible / Fathom), when filtro por los últimos 30 días, then veo al menos: páginas más visitadas, fuentes de tráfico top 5 y visitantes únicos.
- Given que el sitio se sirve en producción, when un bloqueador de anuncios estándar (uBlock Origin) está activo, then el script de analytics se carga a través del dominio propio (proxy) para no ser bloqueado — o se acepta explícitamente esta limitación y se documenta.
- Given que no hay banner de cookies, when el script corre, then el proveedor elegido no usa cookies de seguimiento ni requiere consentimiento bajo GDPR (Plausible y Fathom cumplen esto por defecto).

---

## Feature 5 — Modo oscuro
**RICE: 3.2 | MoSCoW: Could Have**

### Problema
El sitio es 100% light mode. Aunque no afecta directamente la conversión, la preferencia del
sistema `prefers-color-scheme: dark` es mayoría en la audiencia técnica. La ausencia de modo
oscuro genera una percepción de menor cuidado en el detalle — señal negativa menor para un PM
que vende su criterio como producto.

### User Stories

**US-5.1 — Respetar la preferencia del sistema**
> Como visitante que usa dark mode en mi SO,
> quiero que el portafolio respete mi preferencia automáticamente,
> para no sentir que el sitio me fuerza a leer texto oscuro sobre blanco brillante de noche.

Criterios de aceptación:
- Given que mi SO está en modo oscuro (`prefers-color-scheme: dark`), when cargo cualquier página del sitio, then el fondo es oscuro (#0f0f0f o equivalente) y el texto es claro, sin texto ilegible por bajo contraste.
- Given que el sitio usa Tailwind CSS, when se implementa dark mode, then se usa la estrategia `class` o `media` de Tailwind (no CSS custom properties manuales) para mantener consistencia.
- Given que el color accent (#C4654A del logo) se usa en ambos modos, when se muestra en dark mode, then cumple ratio de contraste WCAG AA (>= 4.5:1 sobre fondo oscuro), o se ajusta el tono.

**US-5.2 — Toggle manual de tema (fase 2, opcional)**
> Como visitante que prefiere controlar el tema independientemente de su SO,
> quiero un botón para cambiar entre light y dark,
> para poder leer el blog en el modo que me resulte más cómodo en ese momento.

Criterios de aceptación:
- Given que hago clic en el toggle de tema en el header, when el toggle activa dark mode, then la transición es suave (< 200ms, sin flash de contenido blanco) y la preferencia se persiste en `localStorage`.
- Given que recargo la página después de activar dark mode, when la página carga, then el modo oscuro se aplica antes del primer paint (sin FOUC).
- Given que el toggle existe en el header, when el viewport es mobile, then el toggle no desplaza ni rompe el menú de navegación existente.

---

## Backlog excluido del MVP (Won't Have ahora)

| Feature | Motivo de exclusión |
|---------|-------------------|
| Filtros por tag en Projects | Solo 3 proyectos — los filtros no aportan valor hasta tener >= 8 proyectos |
| Testimonios | Requiere coordinar con terceros; alta fricción, bajo impacto hasta tener tráfico |
| Newsletter (Buttondown / Substack) | RSS cubre el caso de uso inmediato con menor fricción; newsletter es fase 3 |
| Página de caso de estudio individual | Valiosa pero costosa; se desbloquea tras tener contenido real en Projects |

---

## Orden de ejecución recomendado

```
Semana 1   Feature 1 — Contenido real (sin código, solo copywriting + estructura)
Semana 1   Feature 2 — SEO/OG (1 día de ingeniería, alto retorno inmediato)
Semana 2   Feature 3 — RSS (< 4 horas con @astrojs/rss)
Semana 2   Feature 4 — Analytics (< 2 horas con Plausible Cloud)
Semana 3+  Feature 5 — Dark mode (3 horas estimadas)
```

> Feature 1 es la única que no requiere ingeniero: es trabajo del dueño del producto (Marc).
> Features 2, 3 y 4 son de muy bajo esfuerzo técnico en Astro 4 y se pueden paralelizar.
