;; extends

; Lit html`` → inject HTML
((template_string
   (string_fragment) @lit.tag (#eq? @lit.tag "html"))
 @injection.content
 (#set! injection.language "html")
 (#set! injection.combined)
 (#set! injection.include-children))

; Lit css`` → inject CSS
((template_string
   (string_fragment) @lit.tag (#eq? @lit.tag "css"))
 @injection.content
 (#set! injection.language "css")
 (#set! injection.combined)
 (#set! injection.include-children))

; Optional: svg``
((template_string
   (string_fragment) @lit.tag (#eq? @lit.tag "svg"))
 @injection.content
 (#set! injection.language "svg")
 (#set! injection.combined))
