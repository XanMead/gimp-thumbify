(define (script-fu-thumbify theImage theDrawable)
	(let*
		(
			(imageWidth (car (gimp-image-width theImage) ) )
			(imageHeight (car (gimp-image-height theImage) ) )
			(xOffset)
			(yOffset)
		)

		;get image height and width
		(set! imageWidth (car (gimp-image-width theImage) ) )
		(set! imageHeight (car (gimp-image-height theImage) ) )
		
		;determine which is larger, and assign larger value to smaller
		(if (> imageWidth imageHeight)
			(set! imageHeight imageWidth) ;wide! make taller
			(set! imageWidth imageHeight) ;tall! make wider
		)

		;calculate offset
		(set! xOffset (/ (- imageWidth (car (gimp-drawable-width theDrawable) ) ) 2 ) )
		(set! yOffset (/ (- imageHeight (car (gimp-drawable-height theDrawable) ) ) 2 ) )

		;start undo group
		(gimp-image-undo-group-start theImage)
		(gimp-context-push)

		;extend image boundaries
		(gimp-image-resize theImage imageWidth imageHeight xOffset yOffset)

		;end undo group
		(gimp-context-pop)
		(gimp-image-undo-group-end theImage)
		(gimp-displays-flush)
	)
)

(script-fu-register
	"script-fu-thumbify"                   ;func name
	"Thumbify"                             ;menu label
	"Extends the boundaries of the image\
		such that the image is a square\
		and resolution is maintained.\
		Empty space is filled with black." ;description
	"Xan Mead"                             ;author
	"copyright 2015, Xan Mead"             ;copyright notice
	"October 27, 1997"                     ;date created
	"RGB"                                  ;image type that the script works on
	SF-IMAGE     "Image"     0
	SF-DRAWABLE  "Drawable"  0
)
(script-fu-menu-register "script-fu-thumbify" "<Image>/Image/Transform")