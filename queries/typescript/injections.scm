; Inject HTML for lit-html tagged template literals
((call_expression
   function: (identifier) @function
   arguments: (template_string) @html
   (#eq? @function "html"))
 (#set! language "html")
 (#set! combined))
