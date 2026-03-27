# UX Research — Portafolio de Marc Solé Domènech

**Fecha:** Marzo 2026
**Metodología:** Auditoría heurística basada en código fuente + análisis de flujos de conversión
**Público objetivo:** Reclutadores, clientes potenciales (fractional PM), colaboradores técnicos

---

## Preguntas de investigación

Antes de identificar problemas, estas son las suposiciones más arriesgadas del sitio que habría que validar con usuarios reales:

1. ¿Un reclutador que llega al sitio entiende en menos de 10 segundos qué hace Marc y por qué debería contactarle?
2. ¿Un cliente potencial (startup que busca fractional PM) encuentra suficiente evidencia para dar el siguiente paso?
3. ¿Los visitantes que llegan por el blog acaban descubriendo los proyectos y el CV?
4. ¿La página de contacto genera fricción o confianza?
5. ¿Los proyectos comunican impacto o solo actividad?

---

## Hallazgos por página

### Home (index.astro)
- La bio es sólida y tiene voz propia.
- La sección "Now" menciona trabajo fractional pero no hay ninguna CTA ni enlace de contacto asociado — es la oferta de mayor valor económico y pasa desapercibida.
- Los proyectos en Home son bullets sin enlace: el usuario no puede profundizar desde aquí.
- 3 de los 4 artículos en "Recent Thoughts" tienen `href="#"` — son dead links. Un reclutador que hace clic y no pasa nada percibe abandono o descuido.
- El orden de secciones (Thoughts antes que Projects) prioriza el blog sobre el trabajo, lo que puede ser confuso para reclutadores que buscan evidencia de impacto.

### Projects (projects.astro)
- Los tres proyectos usan placeholders literales: "Project One", "A short description of what this project is…". El contenido real existe en Home (search overhaul, B2B onboarding, notifications platform) pero no se ha trasladado aquí.
- `url: null` en todos los proyectos: ninguno enlaza a ningún lugar. No hay artefacto, caso de estudio, ni contexto adicional.
- No hay métricas de impacto en esta página (sí las hay en Home, lo cual es incoherente).

### Resume (resume.astro)
- Todos los campos son placeholders: "Job Title — Company Name", "A brief description…". El CV está vacío de contenido real.
- No hay botón para descargar el CV en PDF — el formato más esperado por reclutadores.
- El único enlace de acción es "Contact →" en la esquina superior derecha, con estilo muy apagado (`text-neutral-400`), casi invisible.

### Contact (contact.astro)
- El email es `your@email.com` — placeholder sin reemplazar. Si alguien hace clic, el mailto falla o abre un cliente con una dirección falsa.
- Los enlaces de LinkedIn y Twitter/X apuntan a `href="#"` — no llevan a ningún sitio.
- No hay contexto de para qué contactar ni qué esperar (tiempo de respuesta, tipo de consultas bienvenidas). La página dice solo "Get in touch." — tres palabras para la acción más crítica del sitio.

### Blog (blog/index.astro + hello-world.md)
- Solo existe un post real publicado, con 6 líneas de contenido.
- El post no tiene ningún enlace al resto del sitio al finalizar la lectura (no hay CTA, no hay "También te puede interesar", no hay enlace a proyectos).
- El BlogLayout no incluye información del autor ni enlace de vuelta al perfil — un lector que llegue por buscador no sabe quién es Marc.

### Navegación global (BaseLayout.astro)
- El ítem "Blog" en el nav se llama "Thoughts" — pero la URL es `/blog`. Esta inconsistencia de etiqueta/URL es menor pero genera duda.
- No hay indicador de página activa en el nav — el usuario no sabe dónde está.
- El footer solo tiene copyright, sin enlaces de contacto ni redes sociales.

---

## Top 5 Gaps de UX — con recomendaciones concretas

---

### Gap 1. La página de contacto está rota y sin contexto

**Observacion:** El email es un placeholder (`your@email.com`), LinkedIn y Twitter apuntan a `#`. Cualquier intento de contacto falla.

**Inferencia:** El visitante que llega motivado a contactar — probablemente el más valioso — encuentra una barrera técnica que interpreta como abandono o poca seriedad.

**Implicacion de diseño:** Antes de cualquier otra mejora, reemplazar todos los datos reales. Añadir una frase de contexto que reduzca la ansiedad del visitante: para qué sirve contactar, qué tipo de proyectos se aceptan, cuándo esperar respuesta. Un ejemplo: "Estoy disponible para conversaciones sobre fractional PM, advisory, o colaboraciones. Respondo en 48h."

**Prioridad: Critica — bloquea conversiones.**

---

### Gap 2. Los proyectos no tienen contenido real ni prueba de impacto

**Observacion:** La página `/projects` muestra tres placeholders genéricos sin métricas, sin contexto, sin enlace. El contenido real (con métricas concretas: -40% time-to-result, 18% conversion lift, 2M eventos/día) existe en Home pero no se ha migrado a Projects.

**Inferencia:** Un reclutador o cliente que navega a Projects — la página que debería ser el argumento más fuerte — encuentra menos información que en la Home. Esto invierte la jerarquía de credibilidad esperada.

**Implicacion de diseño:** Cada proyecto necesita: nombre real, rol del autor, métricas de impacto, contexto del problema, y si es posible un artefacto (deck, caso de estudio, mockup). Si no puede publicarse información confidencial, al menos describir el "antes y después" con datos anonimizados.

**Prioridad: Alta — es la evidencia principal para contratar.**

---

### Gap 3. El CV está vacío y no es descargable

**Observacion:** Resume muestra tres entradas con "Job Title — Company Name" y descripciones placeholder. No existe un enlace para descargar el CV en PDF.

**Inferencia:** Los reclutadores tienen flujos de trabajo que incluyen guardar, reenviar y comentar CVs. Un CV solo-web sin descarga obliga a hacer capturas de pantalla. Un CV vacío simplemente descalifica.

**Implicacion de diseño:** (1) Rellenar el contenido real de experiencia. (2) Añadir un enlace de descarga PDF prominente — no en `text-neutral-400` sino con el color de acento o al menos claramente visible. (3) Considerar que esta página tiene una función diferente para cada audiencia: el reclutador quiere ver cronología, el cliente quiere ver dominios de expertise — puede valer la pena adaptar el énfasis.

**Prioridad: Alta — es el artefacto central para reclutadores.**

---

### Gap 4. Dead links que señalan contenido prometido pero inexistente

**Observacion:** En Home, tres de cuatro artículos en "Recent Thoughts" tienen `href="#"`: "Why most roadmaps are a waste of time", "The PM skill nobody talks about: saying no well", "On building product culture from scratch". Son títulos que generan expectativa y prometen valor, pero al hacer clic no pasa nada.

**Inferencia:** El visitante registra la promesa (títulos con opinión y criterio) pero no puede consumirla. Esto es peor que no tener los títulos: crea frustración activa. Además, para un PM cuya marca personal se basa en "claridad", tener un sitio con elementos rotos es contradictorio.

**Implicacion de diseño:** Dos opciones: (a) publicar los posts aunque sean borradores mínimos, o (b) eliminar los ítems con `href="#"` del listado hasta que el contenido exista. La segunda es la más rápida y no degrada la credibilidad.

**Prioridad: Media-alta — daña la percepcion de cuidado y criterio.**

---

### Gap 5. No hay CTA para la oferta de mayor valor (fractional PM)

**Observacion:** La sección "Now" en Home menciona explícitamente: "I also advise two early-stage startups on product strategy and occasionally do fractional PM work for teams that need senior product thinking without a full-time hire." No hay ninguna CTA, enlace, ni señal visual que invite a actuar sobre esta información.

**Inferencia:** Este es probablemente el segmento de mayor valor económico del sitio (un cliente fractional vs. un reclutador que busca empleado full-time). Sin embargo, el visitante que encaja exactamente en ese perfil no recibe ninguna invitación explícita a dar el siguiente paso.

**Implicacion de diseño:** Añadir una CTA contextual al final de esa sección: "Si tu equipo necesita esto, hablemos →" enlazando a Contact. Opcionalmente, crear una sección o página dedicada a la oferta fractional con más detalle sobre cómo funciona, qué tipo de equipos ha ayudado, y un proceso claro de engagement.

**Prioridad: Alta — es la conversion de mayor impacto economico.**

---

## Resumen de prioridades

| # | Gap | Impacto | Esfuerzo | Prioridad |
|---|-----|---------|----------|-----------|
| 1 | Contacto roto (datos falsos) | Critico | Minimo (editar texto) | Inmediata |
| 2 | Proyectos sin contenido real | Alto | Medio (escribir casos) | Esta semana |
| 3 | CV vacio y sin descarga | Alto | Medio (rellenar + PDF) | Esta semana |
| 4 | Dead links en blog (href="#") | Medio | Minimo (eliminar o publicar) | Esta semana |
| 5 | Sin CTA para oferta fractional | Alto | Minimo (anadir 1 enlace) | Esta semana |

---

## Flujos rotos identificados

**Flujo reclutador:**
Llega a Home → ve proyectos pero no puede entrar al detalle → va a Resume → encuentra placeholders → intenta descargar CV → no hay descarga → va a Contact → el email es falso. **Flujo completamente roto.**

**Flujo cliente potencial (fractional PM):**
Llega a Home → lee "Now" → le interesa el fractional → no hay CTA → busca Contact → encuentra datos falsos. **Conversion imposible.**

**Flujo lector de blog:**
Llega por buscador a un post → lee 6 lineas → no hay enlace al autor ni a su trabajo → sale del sitio sin descubrir nada mas. **Sin retención.**

---

## Recomendaciones de siguiente paso para el equipo de diseño

1. **Sprint 0 (hoy):** Reemplazar todos los placeholders en Contact. Eliminar hrefs="#" del listado de blog en Home.
2. **Sprint 1:** Migrar el contenido real de proyectos de Home a Projects. Añadir metricas y contexto.
3. **Sprint 2:** Rellenar Resume con experiencia real. Añadir enlace de descarga PDF.
4. **Sprint 3:** Diseñar y añadir CTA contextual para fractional PM en seccion Now.
5. **Backlog:** Añadir indicador de pagina activa en nav. Enriquecer footer con enlaces clave. Crear post-read CTA en BlogLayout.
