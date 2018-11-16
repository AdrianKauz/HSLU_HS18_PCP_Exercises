; GIMP Skript das ein konfigurierbares Gitternetz im GIMP zeichnet
; Im GIMP und im Menu registrieren
(script-fu-register 
 "script-fu-add-grid-lines"    ; Funktionsname
 "Add Gridlines"	       ; Menu Punkt
 "Illustrates the structure of a GIMP script" ; Beschreibung
 "Roger Diehl"                 ; Autor
 "2018, HSLU - I"              ; Copyright Notiz
 "October 2018"                ; Erstellungsdatum
 ""                            ; Bild Typ des Skript - "" heisst, es muss kein Bild geladen sein
 ; aktuelle Parameter von script-fu-grid-lines
 SF-IMAGE "Image" 0                                  ; current image 
 SF-ADJUSTMENT "Spacing" '(10 2 100 1 1 0 1)         ; spacing - default 20
 SF-BRUSH "Brush" '("Circle (01)" 100.0 1 0)         ; brush - default Circle (01)
 SF-ADJUSTMENT "Brush Size" '(2 1 100 1 10 0 1)
 SF-COLOR "Foreground" '(0 0 0)                      ; foreground color - default white
 SF-TOGGLE "Horizontal lines" TRUE                   ; horizontal - default TRUE
 SF-TOGGLE "Vertical lines" FALSE                    ; vertical - default FALSE
 SF-TOGGLE "Dashed lines" FALSE                      ; dashed - default FALSE
 )
(script-fu-menu-register "script-fu-add-grid-lines"
                         "<Image>/File/Create/Gridlines")

; Das eigentliche Skript
(define (script-fu-add-grid-lines image spacing brush brush-size forecolor horizontal vertical dashed)
  
  (gimp-context-push)
  (let*(
        ; Grundeinstellungen - Farbe, Breite, Höhe, Ebene...
        (color 0)
        (drawable_width (car(gimp-image-width image)))
        (drawable_height (car(gimp-image-height image)))
        
        (layer (car(gimp-layer-new image drawable_width drawable_height RGBA-IMAGE "grid-layer" 100 NORMAL-MODE)))
        (layer_width (car(gimp-drawable-width layer)))
        (layer_height (car(gimp-drawable-height layer)))
        ; Anfangs- und Endpunkt einer Linie definieren x1, y1, x2, y2
        (point (cons-array 4 'double))
        (invert FALSE)
        )
        ; Gimp Kontext setzen - Transparenz, Hintergrund, Vordergrund, Pinsel, Füllfarbe, Ebene...
        (set! color TRANSPARENT-FILL)
    
        (gimp-context-set-foreground  forecolor)
        (gimp-context-set-brush (car brush))
        (gimp-context-set-brush-size brush-size)
        (gimp-drawable-fill layer color)
        (gimp-image-add-layer image layer -1)

        ; Linie zeichnen
        ; --------------
        (define (draw-line x-from y-from x-to y-to)
            (aset point 0 x-from)
            (aset point 1 y-from)
            (aset point 2 x-to  )
            (aset point 3 y-to  )
            (gimp-pencil layer 4 point))
    
    
        ; ab hier die Gitterlinien-Funktionen...
        ; --------------------------------------

        ; Horizontale Linie (x-Achse)
        (define (draw-horizontal-line posY)
                (when (< posY layer_height)
                      (draw-line 0 posY layer_width posY)
                      (draw-horizontal-line (+ posY spacing))))

        ; Vertikale Linie (y-Achse)
        (define (draw-vertical-line posX)
                (when (< posX layer_width)
                      (draw-line posX 0 posX layer_height)
                      (draw-vertical-line (+ posX spacing))))

        ; Horizontal Linie (x-Achse) gestrichelt
        (define (draw-horizontal-line-dashed posX posY)
                (when (< posY layer_height)
                      (if (<= posX layer_width)
                          (begin
                              (draw-line posX posY (+ posX spacing) posY)
                              (draw-horizontal-line-dashed (+ posX (* 2 spacing)) posY))
                          (draw-horizontal-line-dashed 0 (+ posY spacing)))))

        ; Vertikale Linie (y-Achse) gestrichelt
        (define (draw-vertical-line-dashed posX posY)
                (when (< posX layer_width)
                      (if (<= posY layer_height)
                          (begin
                              (draw-line posX posY posX (+ posY spacing))
                              (draw-vertical-line-dashed posX (+ posY (* 2 spacing))))
                          (draw-vertical-line-dashed (+ posX spacing) 0))))

        ; User-Settings auslesen
        (when (eq? horizontal TRUE)
              (if (eq? dashed TRUE)
                  (draw-horizontal-line-dashed 0 spacing)
                  (draw-horizontal-line spacing)))

        (when (eq? vertical TRUE)
              (if (eq? dashed TRUE)
                  (draw-vertical-line-dashed 0 spacing)
                  (draw-vertical-line spacing)))

        ; --------------------------------------
        ; ...Ende der Gitterlinien-Funktionen
    
        ; Layer anzeigen
        (gimp-context-pop)
        (gimp-displays-flush)
     )
  )
