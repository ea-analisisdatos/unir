;;"Estamos definiendo una misión llamada 'roverprob1234' donde un rover explorará Marte. Usa reglas de un manual llamado 'Rover-battery'."
(define (problem roverprob1234) (:domain Rover-battery) ;; Personajes de la historia
    ;; "En esta historia, tenemos un rover llamado 'rover0' que se mueve por Marte. Tiene una batería llamada 'bat0' y una cámara llamada 'camera0'."
    ;; "El rover tiene un almacén llamado 'rover0store' para guardar muestras. Hay varios puntos de interés en Marte, llamados 'waypoint0', 'waypoint1', 'waypoint2' y 'waypoint3'."
    ;; "El rover tiene dos objetivos científicos: 'objective0' y 'objective1'."
    ;; "El rover puede tomar fotos con su cámara y tiene diferentes modos de cámara: 'high_res' y 'low_res'."
    ;; "El rover tiene diferentes niveles de batería, desde 'b0' (vacía) hasta 'b5' (llena)."
    ;; "El rover está en un lugar llamado 'general' (Lander), que es como el centro de control de la misión."
    ;; "El rover puede moverse entre los puntos de interés y recoger muestras de suelo y rocas. También puede tomar fotos de los objetivos científicos."
    ;; "El rover puede comunicarse con el centro de control para enviar datos sobre las muestras y las fotos que toma."

(:objects
	general - Lander                                    ; Base central (como el centro de control)
	colour high_res low_res - Mode                      ; Modos de la cámara (como diferentes lentes o color, alta resolución, baja resolución)    
	rover0 - Rover                                      ; Nuestro robot explorador (Un rover que se mueve por Marte)
	rover0store - Store                                 ; Almacén del rover para guardar muestras
	waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint  ; Puntos de interés en Marte (como lugares donde el rover puede ir)
	camera0 - Camera                                    ; Cámara del rover (como una cámara que toma fotos)
	objective0 objective1 - Objective                   ; Objetivos de la misión (como lugares específicos que el rover debe visitar) / Objetivos científicos (ej: fotografiar un cráter)
    b0 b1 b2 b3 b4 b5 - Blevel                          ; Niveles de batería (como diferentes niveles de carga de la batería del rover) / Niveles de batería (b0=vacía, b5=llena)
    bat0 - Battery                                      ; Batería física del rover: Batería del rover (como la batería que alimenta al rover)
	) ;; Imagina esto como el elenco de una película. Cada objeto tiene un rol específico.

;; predicates
;; "En esta historia, el rover puede moverse entre los puntos de interés, 
;; recoger muestras de suelo y rocas, tomar fotos de los objetivos científicos y 
;; comunicarse con el centro de control para enviar datos sobre las muestras y las fotos que toma."
;; Escenario inicial (Acto 1)
(:init                              ; Mapa de conexiones entre waypoints (carreteras marcianas)
    ; Todas las rutas posibles entre los waypoints: ... (12 conexiones similares) 
	(visible waypoint1 waypoint0)   ; Se puede ir de WP1 a WP0 
	(visible waypoint0 waypoint1)   ; Se puede ir de WP0 a WP1  
	
	(visible waypoint2 waypoint0)   ; Se puede ir de WP2 a WP0
	(visible waypoint0 waypoint2)   ; Se puede ir de WP0 a WP2
	
	(visible waypoint2 waypoint1)   ; Se puede ir de WP2 a WP1
	(visible waypoint1 waypoint2)   ; Se puede ir de WP1 a WP2
	
	(visible waypoint3 waypoint0)   ; Se puede ir de WP3 a WP0
	(visible waypoint0 waypoint3)   ; Se puede ir de WP0 a WP3
	
	(visible waypoint3 waypoint1)   ; Se puede ir de WP3 a WP1
	(visible waypoint1 waypoint3)   ; Se puede ir de WP1 a WP3
	
	(visible waypoint3 waypoint2)   ; Se puede ir de WP3 a WP2
	(visible waypoint2 waypoint3)   ; Se puede ir de WP3 a WP2
	
	; Muestras disponibles en cada ubicación
	(at_soil_sample waypoint0)  ; Hay una muestra de suelo en WP0
	(at_rock_sample waypoint1)  ; Hay una muestra de roca en WP1
    (at_soil_sample waypoint1)  ; Hay una muestra de suelo en WP1
	(at_soil_sample waypoint2)  ; Hay una muestra de suelo en WP2
	(at_rock_sample waypoint2)  ; Hay una muestra de roca en WP2
	(at_soil_sample waypoint3)  ; Hay una muestra de suelo en WP3
	(at_rock_sample waypoint3)  ; Hay una muestra de roca en WP3
    
	; Configuración inicial
	(at_lander general waypoint0)       ; El Lander está en WP0 (La base está en WP0 )
	(channel_free general)              ; El canal de comunicación con el Lander está libre (Comunicaciones disponibles)
	(at rover0 waypoint3)               ; El rover está en WP3 (Rover empieza en WP3)
	(available rover0)                  ; El rover está disponible para moverse (Listo para operar)
	(store_of rover0store rover0)       ; El almacén del rover está asociado al rover (rover0store es el almacén del rover)
	(empty rover0store)                 ; El almacén del rover está vacío al inicio
	
	; Equipamiento del rover
	(equipped_for_soil_analysis rover0) ; El rover está equipado para analizar muestras de suelo
	(equipped_for_rock_analysis rover0) ; El rover está equipado para analizar muestras de roca
	(equipped_for_imaging rover0)       ; El rover está equipado para tomar imágenes (Tiene cámara instalada)
	
	; Movilidad permitida: Red de caminos permitidos
	(can_traverse rover0 waypoint3 waypoint0)   ; Puede ir de WP3 a WP0
	(can_traverse rover0 waypoint0 waypoint3)   ; Puede ir de WP0 a WP3
	(can_traverse rover0 waypoint3 waypoint1)   ; Puede ir de WP3 a WP1
	(can_traverse rover0 waypoint1 waypoint3)   ; Puede ir de WP1 a WP3
	(can_traverse rover0 waypoint1 waypoint2)   ; Puede ir de WP1 a WP2
	(can_traverse rover0 waypoint2 waypoint1)   ; Puede ir de WP2 a WP1
	
	; Configuración de cámara
	(on_board camera0 rover0)               ; La cámara está instalada en el rover  
	(calibration_target camera0 objective1) ; La cámara está calibrada para el objetivo 1 (como un objetivo científico)
	(supports camera0 colour)               ; La cámara soporta el modo de color (Saca fotos en color)
	(supports camera0 high_res)             ; La cámara soporta el modo de alta resolución (Saca fotos en alta resolución)
	
	 ; Batería
	; Bateria cargada en rover 0
	(battery_installed rover0 bat0 b4 b4)                                   ; La batería está instalada en el rover con nivel b4 (batería cargada al 80%)   
	; Niveles de bateria
	(lower b0 b1) (lower b1 b2) (lower b2 b3) (lower b3 b4) (lower b4 b5)   ; b0 < b1 (jerarquía de niveles): Niveles de batería (b0 es el nivel más bajo, b5 es el más alto)

	
; Visibilidad de objetivos: Dónde fotografiar cada objetivo
	; Objetivos científicos (como lugares específicos que el rover debe visitar)
	(visible_from objective0 waypoint0) ; El objetivo 0 es visible desde el waypoint 0 (WP0)
	(visible_from objective0 waypoint1) ; El objetivo 0 es visible desde el waypoint 1
	(visible_from objective0 waypoint2) ; El objetivo 0 es visible desde el waypoint 2
	(visible_from objective0 waypoint3) ; El objetivo 0 es visible desde el waypoint 3
	
	(visible_from objective1 waypoint0) ; El objetivo 1 es visible desde el waypoint 0
	(visible_from objective1 waypoint1) ; El objetivo 1 es visible desde el waypoint 1
	(visible_from objective1 waypoint2) ; El objetivo 1 es visible desde el waypoint 2
)

;; Objetivos de la misión (Acto 3)
(:goal (and
   (communicated_soil_data waypoint2)               ; Se ha comunicado la muestra de suelo del waypoint 2 (; Enviar datos de SUELO de WP2)
   (communicated_rock_data waypoint3)               ; Se ha comunicado la muestra de roca del waypoint 3 (; Enviar datos de ROCA de WP3)
   (communicated_image_data objective1 high_res)    ; Se ha comunicado la imagen del objetivo 1 en alta resolución (Enviar imagen de OBJETIVO1 en alta resolución (Foto HD de Obj1))
   )
) ;¡El rover debe completar estas 3 tareas para ganar!
)
