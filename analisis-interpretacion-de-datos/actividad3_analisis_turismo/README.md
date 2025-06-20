# Actividad 3 - Análisis Inferencial de la Satisfacción Turística

Este proyecto forma parte de la **Actividad 3** de la asignatura _Análisis e Interpretación de Datos_, perteneciente al:

📚 **Máster Universitario en Análisis y Visualización de Datos Masivos**
🎓 Universidad Internacional de La Rioja (UNIR)

## 📌 Objetivo del proyecto

Analizar la **satisfacción turística** utilizando técnicas de estadística inferencial sobre datos simulados del sector turismo. Se aplican contrastes de hipótesis para responder a dos preguntas:

1. ¿La satisfacción media supera un valor de referencia?
2. ¿Existen diferencias significativas en la satisfacción entre turistas con y sin necesidades de accesibilidad?

## 🗃️ Dataset utilizado

**Cultural Tourism Dataset** ([ver en Kaggle](https://www.kaggle.com/datasets/ziya07/cultural-tourism-dataset))
Contiene registros simulados sobre turistas, intereses, rutas, uso de VR, precisión del sistema de recomendación y valoración general.

Variables principales analizadas:

- `satisfaction`: Satisfacción del turista (Likert 1–5)
- `tourist_rating`: Valoración del servicio
- `vr_experience_quality`: Calidad de la experiencia VR
- `recommendation_accuracy`: Precisión del sistema
- `accessibility`: Requiere o no accesibilidad

## 🔍 Técnicas aplicadas

- Limpieza de datos (`janitor`, `dplyr`)
- Descomposición de columnas multivaluadas (`interests`, `sites_visited`)
- Visualización con `ggplot2`
- Contrastes de hipótesis:
  - Test t de una muestra
  - Test t para muestras independientes
- Análisis de correlaciones
- Segmentación por edad e intereses

## 📈 Resultados destacados

- La media de satisfacción supera ligeramente el valor de referencia (media ≈ 3.53 sobre 5)
- No hay diferencias significativas en satisfacción por accesibilidad (p > 0.05)
- Las variables mejor correlacionadas con la satisfacción son `tourist_rating` y `vr_experience_quality`
- Los intereses más frecuentes fueron `Nature`, `Art`, y `Cultural`

---

## 📄 Ver el proyecto completo

Puedes consultar la versión final del cuaderno RMarkdown exportado en HTML en el siguiente enlace:

👉 [Ver cuaderno del proyecto en la web](https://ea-analisisdatos.github.io/projects-and-pages/actividad3-analisis-inferencial/)

---

## ✨ Conéctate conmigo

¿Quieres aprender más sobre Ciencia de Datos y mantenerte actualizado sobre las últimas tendencias y tecnologías?
¿Estás interesado/a en colaborar en proyectos open source, académicos o formar equipo para participar en **Hackathons**?

🎯 ¡Estoy abierta a nuevas oportunidades de colaboración profesional, mentoring o networking académico!

📧 Contacto principal: **erikaalvares.analisisdatos@gmail.com**

🌐 **Sitio web personal:** [erikaalvares.es](https://www.erikaalvares.es/)

🔗 **Redes y plataformas técnicas:**

- GitHub: [github.com/ea-analisisdatos](https://github.com/ea-analisisdatos)
- LinkedIn: [linkedin.com/in/erikaalvares](https://www.linkedin.com/in/erikaalvares/)
- Medium: [@erikaalvares.portafolioweb](https://medium.com/@erikaalvares.portafolioweb)
- Hugging Face: [huggingface.co/erika-alvares](https://huggingface.co/erika-alvares)
- Kaggle: [kaggle.com/datatecherikaalvares](https://www.kaggle.com/datatecherikaalvares)
- Discord: [Unirme a mi comunidad](https://discord.com/invite/Scu8ewYZ3j)
- Telegram: [t.me/+N3RlOTstV3ZjNDI0](https://t.me/+N3RlOTstV3ZjNDI0)
- Dev.to: [dev.to (erikaalvares.analisisdatos@gmail.com)](https://dev.to/?signin=true)

---

## 🧑‍💻 Alumna

**Erika Samara Alvares Angelim**
Ingeniera en TIC | Estudiante de máster en Big Data e IA
Repositorio del curso UNIR: [github.com/ea-analisisdatos/unir](https://github.com/ea-analisisdatos/unir)

---

## 🧾 Referencias

- Boone, H. N., & Boone, D. A. (2012). Analyzing Likert Data. *Journal of Extension*.
- Joshi, A. et al. (2015). Likert Scale: Explored and Explained. *British Journal of Applied Science & Technology*.
- Montgomery, D. C., & Runger, G. C. (2014). *Probabilidad y estadística aplicada a la ingeniería*. Wiley.
- Cultural Tourism Dataset. (2022). *Kaggle*. https://www.kaggle.com/datasets/ziya07/cultural-tourism-dataset
