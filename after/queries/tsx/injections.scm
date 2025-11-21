;; extends

((template_string
   (string_fragment) @lit.tag (#eq? @lit.tag "html"))
 @injection.content
 (#set! injection.language "html")
 (#set! injection.combined)
 (#set! injection.include-children))

((template_string
   (string_fragment) @lit.tag (#eq? @lit.tag "css"))
 @injection.content
 (#set! injection.language "css")
 (#set! injection.combined)
 (#set! injection.include-children))
