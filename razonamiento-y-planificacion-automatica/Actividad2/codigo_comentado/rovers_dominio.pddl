;; Definimos un dominio llamado "Rover-battery"
(define (domain Rover-battery)

 ;; Indicamos los requisitos que este dominio usa: tipado de variables y STRIPS (acciones con precondiciones y efectos)
 (:requirements :typing :strips)

 ;; "Lander" en inglés significa "módulo de aterrizaje" o "vehículo de aterrizaje".
 ;; En el contexto del dominio PDDL que estamos utilizando (relacionado con exploración espacial, como misiones a Marte), un lander es:
 ;; Una nave espacial que aterriza en la superficie de un planeta (en este caso, por ejemplo, Marte) y que puede:
    ; Servir como base de operaciones para los rovers.
    ; Cargar las baterías de los rovers.
    ; Enviar o recibir datos (puede tener un canal de comunicación).
    ; Estar ubicado en un punto fijo del terreno (waypoint).
 
 ;; Definiciones de los tipos de objetos en el dominio:
;; 1. En resumen, lander (?l) es un módulo de aterrizaje que se comunica con el rover
;; 2. rover (?r) es un vehículo robótico que se mueve por la superficie
;; 3. waypoint (?x, ?y, ?w, ?p, ?z) son puntos de interés en la superficie
;; 4. store (?s) es un almacén donde el rover guarda muestras
;; 5. camera (?c, ?i) es una cámara que el rover usa para capturar imágenes
;; 6. mode (?m) es un modo de operación de la cámara
;; 7. objective (?o, ?t) son los objetivos que el rover puede observar
;; 8. blevel (?l1, ?l2) es el nivel de batería del rover
;; 9. battery (?b) es la batería que alimenta al rover
    
 

 ;; Definimos los tipos de objetos que pueden existir en este dominio
 (:types rover waypoint store camera mode lander objective
        blevel battery
 )

 
;; VARIABLES USADAS EN PREDICADOS Y ACCIONES DEL DOMINIO

;; ?r - rover                                           ;; vehículo explorador: es una variable que representa un rover.

;; ?x, ?y, ?w, ?p                                       ;; son variables que representan waypoints (puntos de interés en el terreno o ubicaciones).
;; ?z - waypoint                                        ;; punto: representa otro waypoint (punto de interés en el terreno o ubicación).
;; Ejemplos                                             ;; Entonces, el predicado (at ?x ?y) significa: "El rover ?x está en el waypoint ?y".
                                                        ;; Entonces, el predicado ?y - waypoint / lander / waypoint significa: punto / módulo de aterrizaje / punto

;; ?b - battery                                         ;; batería
;; ?bmax - blevel                                       ;; nivel máximo de batería
;; ?bcur - blevel                                       ;; nivel actual de batería
;; ?bnext - blevel                                      ;; siguiente nivel de batería (representa el nuevo nivel de batería después de una acción.)
;; ?l - lander                                          ;; módulo de aterrizaje
;; ?s - store                                           ;; almacén donde el rover guarda muestras.
;; ?c - camera                                          ;; cámara
;; ?i - camera                                          ;; cámara
;; ?m - mode                                            ;; representa un modo de operación de la cámara (ej. imagen, infrarrojo)
;; ?o - objective                                       ;; objetivo (a fotografiar o analizar)
;; ?t - objective                                       ;; objetivo (alternativo): representa un objetivo (objective) que el rover puede observar.
;; ?l1 - blevel                                         ;; nivel de batería 1
;; ?l2 - blevel                                         ;; nivel de batería 2



 ;; Predicados: expresan hechos que pueden ser verdaderos o falsos en un estado del mundo
 (:predicates 
   ;; El rover ?x está en el punto ?y
   (at ?x - rover ?y - waypoint)

   ;; El módulo de aterrizaje ?x está en el punto ?y
   (at_lander ?x - lander ?y - waypoint)

   ;; El rover ?r puede moverse entre los puntos ?x y ?y
   (can_traverse ?r - rover ?x - waypoint ?y - waypoint)

   ;; El rover está equipado para análisis de suelo
   (equipped_for_soil_analysis ?r - rover)

   ;; El rover está equipado para análisis de rocas
   (equipped_for_rock_analysis ?r - rover)

   ;; El rover está equipado para capturar imágenes
   (equipped_for_imaging ?r - rover)

   ;; El almacén (store) ?s está vacío
   (empty ?s - store)

   ;; El rover ?r tiene un análisis de roca tomado en el punto ?w
   (have_rock_analysis ?r - rover ?w - waypoint)

   ;; El rover ?r tiene un análisis de suelo tomado en el punto ?w
   (have_soil_analysis ?r - rover ?w - waypoint)

   ;; El almacén ?s está lleno
   (full ?s - store)

   ;; La cámara ?c ha sido calibrada para el rover ?r
   (calibrated ?c - camera ?r - rover)

   ;; La cámara ?c es compatible con el modo ?m
   (supports ?c - camera ?m - mode)

   ;; El rover está disponible (no está ocupado)
   (available ?r - rover)

   ;; El punto ?w puede "ver" al punto ?p (está dentro de la línea de visión)
   (visible ?w - waypoint ?p - waypoint)

   ;; El rover ?r tiene una imagen del objetivo ?o tomada en el modo ?m
   (have_image ?r - rover ?o - objective ?m - mode)

   ;; Ya se ha comunicado el dato de suelo recogido en el punto ?w
   (communicated_soil_data ?w - waypoint)

   ;; Ya se ha comunicado el dato de roca recogido en el punto ?w
   (communicated_rock_data ?w - waypoint)

   ;; Ya se ha comunicado una imagen del objetivo ?o en el modo ?m
   (communicated_image_data ?o - objective ?m - mode)

   ;; Hay una muestra de suelo disponible en el punto ?w
   (at_soil_sample ?w - waypoint)

   ;; Hay una muestra de roca disponible en el punto ?w
   (at_rock_sample ?w - waypoint)

   ;; El objetivo ?o es visible desde el punto ?w
   (visible_from ?o - objective ?w - waypoint)

   ;; El almacén ?s pertenece al rover ?r
   (store_of ?s - store ?r - rover)

   ;; El objetivo ?o es usado para calibrar la cámara ?i
   (calibration_target ?i - camera ?o - objective)

   ;; La cámara ?i está montada en el rover ?r
   (on_board ?i - camera ?r - rover)

   ;; El canal de comunicación del lander ?l está libre
   (channel_free ?l - lander)

   ;; La batería ?b está instalada en el rover ?r, con nivel máximo ?bmax y nivel actual ?bcur
   (battery_installed ?r - rover ?b - battery ?bmax ?bcur - blevel)

   ;; El nivel ?l1 de batería es menor que el nivel ?l2
   (lower ?l1 ?l2 - blevel)
 )

 ;; Acción para navegar de un punto a otro usando batería
 ; El rover se mueve de un punto a otro, si tiene suficiente batería y puede ver el destino. Al moverse, gasta la batería (baja el nivel)
 (:action navigate-bat
  :parameters (?r - rover ?y - waypoint ?z - waypoint
               ?b - battery ?bmax ?bcur ?bnext - blevel)
  :precondition (and 
     (can_traverse ?r ?y ?z)    ;; El rover puede moverse de y a z
     (available ?r)             ;; El rover está disponible
     (at ?r ?y)                 ;; El rover está en y
     (visible ?y ?z)            ;; El punto z es visible desde y
     (battery_installed ?r ?b ?bmax ?bcur) ;; El rover tiene la batería instalada
     (lower ?bnext ?bcur)       ;; El nuevo nivel de batería será menor al actual
  )
  :effect (and
     (not (at ?r ?y))           ;; El rover ya no está en y
     (at ?r ?z)                 ;; El rover está ahora en z
     (not (battery_installed ?r ?b ?bmax ?bcur)) ;; Quitamos la batería con nivel viejo
     (battery_installed ?r ?b ?bmax ?bnext)      ;; Instalamos la misma batería con nuevo nivel
  )
 )

 ;; Acción para recargar la batería usando un lander
 ; El rover recarga su batería al estar en el mismo waypoint que el lander, y la batería se recarga completamente
 (:action recharge
  :parameters (?r - rover ?l - lander ?w - waypoint
               ?b - battery ?bmax ?bcur - blevel)
  :precondition (and
     (at ?r ?w)                 ;; El rover está en w
     (at_lander ?l ?w)          ;; El lander también está en w
     (battery_installed ?r ?b ?bmax ?bcur) ;; Hay una batería instalada
  )
  :effect (and
     (not (battery_installed ?r ?b ?bmax ?bcur)) ;; Quitamos la batería con nivel actual
     (battery_installed ?r ?b ?bmax ?bmax)       ;; Instalamos la batería totalmente cargada
  )
 )

 ;; Acción para tomar una muestra de suelo
 ; El rover toma una muestra de suelo si está en el waypoint(lugar/punto) correcto, tiene el equipo necesario y su almacén está vacío
 (:action sample_soil
  :parameters (?r - rover ?s - store ?p - waypoint)
  :precondition (and
     (at ?r ?p)                         ;; El rover está en p
     (at_soil_sample ?p)               ;; Hay muestra de suelo
     (equipped_for_soil_analysis ?r)   ;; El rover puede analizar suelo
     (store_of ?s ?r)                  ;; El almacén pertenece al rover
     (empty ?s)                        ;; El almacén está vacío
  )
  :effect (and
     (not (empty ?s))                  ;; El almacén ya no está vacío
     (full ?s)                         ;; Ahora está lleno
     (have_soil_analysis ?r ?p)        ;; El rover tiene un análisis de suelo
     (not (at_soil_sample ?p))         ;; Ya no queda muestra en el lugar
  )
 )

 ;; Acción para tomar una muestra de roca
;; El rover toma una muestra de roca si está en el waypoint(lugar/punto) correcto, tiene el equipo necesario y su almacén está vacío
 (:action sample_rock
  :parameters (?r - rover ?s - store ?p - waypoint)
  :precondition (and
     (at ?r ?p)
     (at_rock_sample ?p)
     (equipped_for_rock_analysis ?r)
     (store_of ?s ?r)
     (empty ?s)
  )
  :effect (and
     (not (empty ?s))
     (full ?s)
     (have_rock_analysis ?r ?p)
     (not (at_rock_sample ?p))
  )
 )

 ;; Acción para vaciar el almacén
    ;; El rover vacía su almacén si está en el waypoint correcto y el almacén está lleno para poder recoger nuevas muestras
 (:action drop
  :parameters (?r - rover ?s - store)
  :precondition (and (store_of ?s ?r) (full ?s))
  :effect (and (not (full ?s)) (empty ?s))
 )

 ;; Acción para calibrar una cámara
    ;; El rover calibra una cámara si está equipado para imágenes, la cámara tiene un objetivo de calibración, está en el waypoint correcto y la cámara está montada en el rover
    ;; El rover calibra su cámara usando un objetivo específico, si está en el lugar correcto y la cámara está instalada.
 (:action calibrate
  :parameters (?r - rover ?i - camera ?t - objective ?w - waypoint)
  :precondition (and
     (equipped_for_imaging ?r)
     (calibration_target ?i ?t)
     (at ?r ?w)
     (visible_from ?t ?w)
     (on_board ?i ?r)
  )
  :effect (calibrated ?i ?r)
 )

 ;; Acción para tomar una imagen
 ;; El rover toma una foto de un objetivo en un modo específico, si está calibrado y en el lugar correcto.
 (:action take_image
  :parameters (?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode)
  :precondition (and
     (calibrated ?i ?r)
     (on_board ?i ?r)
     (equipped_for_imaging ?r)
     (supports ?i ?m)
     (visible_from ?o ?p)
     (at ?r ?p)
  )
  :effect (and
     (have_image ?r ?o ?m)
     (not (calibrated ?i ?r))
  )
 )

 ;; Acción para comunicar datos de suelo
 (:action communicate_soil_data
  :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
  :precondition (and
     (at ?r ?x)
     (at_lander ?l ?y)
     (have_soil_analysis ?r ?p)
     (visible ?x ?y)
     (available ?r)
     (channel_free ?l)
  )
  :effect (and
     (not (available ?r))
     (not (channel_free ?l))
     (channel_free ?l)
     (communicated_soil_data ?p)
     (available ?r)
  )
 )

 ;; Acción para comunicar datos de roca
 (:action communicate_rock_data
  :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
  :precondition (and
     (at ?r ?x)
     (at_lander ?l ?y)
     (have_rock_analysis ?r ?p)
     (visible ?x ?y)
     (available ?r)
     (channel_free ?l)
  )
  :effect (and
     (not (available ?r))
     (not (channel_free ?l))
     (channel_free ?l)
     (communicated_rock_data ?p)
     (available ?r)
  )
 )

 ;; Acción para comunicar datos de imagen
 (:action communicate_image_data
  :parameters (?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint)
  :precondition (and
     (at ?r ?x)
     (at_lander ?l ?y)
     (have_image ?r ?o ?m)
     (visible ?x ?y)
     (available ?r)
     (channel_free ?l)
  )
  :effect (and
     (not (available ?r))
     (not (channel_free ?l))
     (channel_free ?l)
     (communicated_image_data ?o ?m)
     (available ?r)
  )
 )

)  ;; Fin del dominio
;; Fin del dominio Rover-battery