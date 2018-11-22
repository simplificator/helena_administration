#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require codemirror
#= require codemirror/modes/xml
#= require codemirror/modes/htmlembedded
#= require codemirror/modes/htmlmixed
#= require codemirror/modes/coffeescript
#= require codemirror/modes/javascript
#= require codemirror/modes/ruby
#= require codemirror/modes/markdown
#= require codemirror/modes/slim
#= require codemirror/modes/yaml
$ ->
  $('textarea.slim_lang').each ->
    CodeMirror.fromTextArea(@, { mode: 'application/x-slim', lineNumbers: true, tabSize: 2, insertSoftTab: true })

  $('textarea.yaml_lang').each ->
    CodeMirror.fromTextArea(@, { mode: 'yaml', lineNumbers: true, tabSize: 2, insertSoftTab: true })
