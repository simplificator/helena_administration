#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require lib/codemirror.js
#= require mode/javascript/javascript.js

$ ->
  $('textarea.slim_lang').each ->
    CodeMirror.fromTextArea(@, { mode: 'application/x-slim', lineNumbers: true, tabSize: 2, insertSoftTab: true })

  $('textarea.yaml_lang').each ->
    CodeMirror.fromTextArea(@, { mode: 'yaml', lineNumbers: true, tabSize: 2, insertSoftTab: true })
